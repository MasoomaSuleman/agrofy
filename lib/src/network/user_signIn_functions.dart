import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// addeed dependnecies
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kisaanCorner/Screens/otp_input_screen.dart';

import 'package:provider/provider.dart';

// app dependencies
import 'package:kisaanCorner/src/view/profile/profile_landing_page.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/provider/user_details.dart';
import 'package:kisaanCorner/provider/MyLikesAndBookmarks.dart';
import 'package:kisaanCorner/Screens/Home/HomeScreen.dart';
import 'package:kisaanCorner/src/view/my_profile/my_profile_landing_page.dart';

enum SignInType { Google, PhoneNumber }

class UserSignInFunctions {
  String enumToString(Object o) => o.toString().split('.').last;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final Firestore _firestore = Firestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging();

  Future<void> customGoogleSignIn(BuildContext context,  {void Function() onError}) async {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    GoogleSignInAuthentication gSA;
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    try{
      gSA = await googleSignInAccount.authentication;
    }catch(e, t){
      if(onError != null){
        onError();
      }
    }
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: gSA.idToken, accessToken: gSA.accessToken);
    AuthResult _authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = _authResult.user;
    print(
        "UserSignInFunctions()''': customGoogleSignIn(): User logged in success name is ${user.displayName}");
    // use this obtained user to perform the tasks
    String _deviceToken;
    _messaging.getToken().then((value) {
      _deviceToken = value;
      _firestore
          .collection('firebaseMessagingToken')
          .where('tokenString', isEqualTo: _deviceToken)
          .getDocuments()
          .then((value) {
        if (value.documents.isEmpty) {
          // new token is detected add with user id
          _firestore
              .collection('firebaseMessagingToken')
              .add({"tokenString": "$_deviceToken", "userId": "${user.uid}"});
        } else {
          // just update the user id with this token value.documents.first.documentID
          _firestore
              .collection('firebaseMessagingToken')
              .document(value.documents.first.documentID)
              .setData(
                  {"tokenString": "$_deviceToken", "userId": "${user.uid}"});
        }
      });
    });

    _firestore
        .collection('userData')
        .document("${user.uid}")
        .get()
        .then((docSnap) {
      if (docSnap.exists) {
        //TODO: when new implementation is complete remove this old part
        Provider.of<User>(context, listen: false).fromSnap(docSnap);
        Provider.of<UserDetails>(context, listen: false).setUserDetails(
            userID: docSnap.documentID,
            userName: docSnap['name'],
            userProfession: docSnap['profession'],
            userOrganization: docSnap['organization'],
            userPhoneNumber: docSnap['phoneNumber'],
            userEmailID: docSnap['email'],
            imageUrl: docSnap['profileImageURl']);
        List<String> _myLikes = [];
        _firestore
            .collection('likesData')
            .where('userId', isEqualTo: '${user.uid}')
            .getDocuments()
            .then((value2) {
          // adding all my liked answers to the list
          value2.documents.forEach((element) {
            _myLikes.add(element['answerId']);
          });
        }).catchError((e) {
          throw Future.error(
              "UserSignInFunctions()''': customGoogleSignIn(): error while getting user likes details");
        });
        MyLikesAnsBookmarks myLikesAnsBookmarks =
            Provider.of<MyLikesAnsBookmarks>(context, listen: false);
        myLikesAnsBookmarks.storeMyLikesAnswers(_myLikes);
        //return true;
//        Navigator.pushReplacement(context,
//            MaterialPageRoute(builder: (context) => MyProfileLandingPage()));
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // go to new profile landing page
        // send details like
        // uid, signInmethod, profile pic, email address
        newUserSignInGoogle(
            context: context,
            fullName: user.displayName,
            email: user.email,
            userId: user.uid,
            profileImageUrl: user.photoUrl,
            deviceToken: _deviceToken);
      }
    }).catchError((e) {
      throw Future.error(
          "UserSignInFunctions()''': customGoogleSignIn(): error while getting user details");
    });
  }

  Future<void> phoneNumberVerify(BuildContext context, String phoneNumber,
      Function moveToOTPScreen) async {
    // first verify the number and call check number
    String verificationId;

    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      //call sign in with otp function
      //AuthServices.signInWithOTP(authCredential: authResult, context: context);
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      //phone verification failed print error message
      print(authException.message);
    };
    //this needs to be in the page itself
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      verificationId = verId;
      // as the condition is for codesent to the scaffold now it will show the otp input screen
      //TODO: send the smssent variable from here and verid
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpPage(
                    verificationId: verificationId,
                    number: phoneNumber,
                  )));
      if (moveToOTPScreen != null) {
        moveToOTPScreen.call();
      }
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      verificationId = verId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<void> customSignInWithOTP(
      {authCredential,
      smsCode,
      verificationId,
      BuildContext context,
      Function() onResult}) async {
    print("'AuthServices()''': signInWithOTP printing verID $verificationId");
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    print(
        "AuthServices()''': signInWithOTP printing authCredential $_authCredential");
    _auth.signInWithCredential(_authCredential).then((_signInResult) {
      FirebaseUser user = _signInResult.user;
      //TODO: .............................
      String _deviceToken;
      _messaging.getToken().then((value) {
        _deviceToken = value;
        _firestore
            .collection('firebaseMessagingToken')
            .where('tokenString', isEqualTo: _deviceToken)
            .getDocuments()
            .then((value) {
          if (value.documents.isEmpty) {
            // new token is detected add with user id
            _firestore
                .collection('firebaseMessagingToken')
                .add({"tokenString": "$_deviceToken", "userId": "${user.uid}"});
          } else {
            // just update the user id with this token value.documents.first.documentID
            _firestore
                .collection('firebaseMessagingToken')
                .document(value.documents.first.documentID)
                .setData(
                    {"tokenString": "$_deviceToken", "userId": "${user.uid}"});
          }
        });
      });
      //TODO:...................................
      // to check if first time login
      _firestore
          .collection('userData')
          .document("${user.uid}")
          .get()
          .then((docSnap) {
        if (docSnap.exists) {
          // TODO: save the details to current user variable
          Provider.of<User>(context, listen: false).fromSnap(docSnap);
          Provider.of<UserDetails>(context, listen: false).setUserDetails(
              userID: docSnap.documentID,
              userName: docSnap['name'],
              userProfession: docSnap['profession'],
              userOrganization: docSnap['organization'],
              userPhoneNumber: docSnap['phoneNumber'],
              userEmailID: docSnap['email'],
              imageUrl: docSnap['profileImageURl']);
          List<String> _myLikes = [];
          _firestore
              .collection('likesData')
              .where('userId', isEqualTo: '${user.uid}')
              .getDocuments()
              .then((value2) {
            // adding all my liked answers to the list
            value2.documents.forEach((element) {
              _myLikes.add(element['answerId']);
            });
          }).catchError((e) {
            throw Future.error(
                "UserSignInFunctions()''': customGoogleSignIn(): error while getting user likes details");
          });
          MyLikesAnsBookmarks myLikesAnsBookmarks =
              Provider.of<MyLikesAnsBookmarks>(context, listen: false);
          myLikesAnsBookmarks.storeMyLikesAnswers(_myLikes);
          //return true;
//          Navigator.pushReplacement(context,
//              MaterialPageRoute(builder: (context) => MyProfileLandingPage()));
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
          onResult.call();
//                  builder: (context) => MyAccountScreen(snap.documentID)));
        } else {
          //TODO: make this push route named push to pop the loading screen

          print(
              "'AuthServices()''': signInWithOTP printing verID $verificationId");
          print(
              "'AuthServices()''': signInWithOTP printing USERID ${user.uid}");
          //TODO: to structuer the added code properly
          newUserSignInPhoneNumber(
              context: context,
              userId: user.uid,
              phoneNumber: user.phoneNumber,
              deviceToken: _deviceToken);
          onResult.call();
        }
      });
    }).catchError((e) {
      print("AuthServices()''': signInWithOTP gave error ${e.toString()}");
      Fluttertoast.showToast(
          msg: "Please enter correct OTP.", toastLength: Toast.LENGTH_LONG);
      onResult.call();
    });
  }

  void newUserSignInGoogle(
      {BuildContext context,
      String fullName,
      String email,
      String userId,
      String profileImageUrl,
      String deviceToken}) {
    User newUser = User();
    newUser.personalInformation.fullName = fullName;
    newUser.personalInformation.email = email;
    newUser.personalInformation.profileImageUrl = profileImageUrl;

    newUser.userId = userId;
    newUser.deviceTokensList[0] = deviceToken;
    newUser.signInMethod = '${enumToString(SignInType.Google)}';

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileLandingPage(
                  newUser,
                )));
  }

  void newUserSignInPhoneNumber(
      {BuildContext context,
      String phoneNumber,
      String userId,
      String deviceToken}) {
    User newUser = User();
    newUser.personalInformation.phoneNumber = phoneNumber;

    newUser.userId = userId;
    newUser.deviceTokensList[0] = deviceToken;
    newUser.signInMethod = '${enumToString(SignInType.PhoneNumber)}';

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ProfileLandingPage(newUser)));
  }

  Future<bool> logOutUser(BuildContext context) async {
    _auth.signOut().then((value) {
      // delete the user provider details
      Provider.of<User>(
        context,
        listen: false,
      ).deleteUserDetails();
      return true;
    }).catchError((e) {
      return false;
    });
  }
}
