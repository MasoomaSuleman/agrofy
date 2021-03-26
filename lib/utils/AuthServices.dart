import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

//derived dependencies
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisaanCorner/Screens/otp_input_screen.dart';
import 'package:kisaanCorner/provider/MyLikesAndBookmarks.dart';
import 'package:kisaanCorner/src/network/user_signIn_functions.dart';

import 'package:provider/provider.dart';

//app dependencies

import '../Screens/Home/HomeScreen.dart';

import '../main.dart';
import '../provider/user_details.dart';

class AuthServices {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;
  static FirebaseUser firebaseUser;
  static final GoogleSignIn googleSignIn = new GoogleSignIn();
  static final FirebaseMessaging _messaging = FirebaseMessaging();
  //static User currentUser;
  static String verID;
  static bool isLoading = true;
  static List<String> _myLikes = [];
  //handle auth for changes in user
//  static handleAuth() {
//    return ChangeNotifierProvider<Userdetails>(
//        create: (_) => Userdetails(),
//        builder: (context, widget) {
//          var userDetails = Provider.of<Userdetails>(context);
//          return StreamBuilder(
//              stream: FirebaseAuth.instance.onAuthStateChanged,
//              builder: (BuildContext context, snapshot) {
//                if (snapshot.hasData) {
//                  _firebaseAuth.currentUser().then((value) {
//                    firebaseUser = value;
//                    _firestore
//                        .collection('userData')
//                        .document('${firebaseUser.uid}')
//                        .get()
//                        .then((snap) {
//                      //get details of user here and add to provider class
//                      userDetails.user_image_url = snap['profileImageURl'];
//                      userDetails.user_id = snap.documentID;
//                      userDetails.user_name = snap['name'];
//                      userDetails.user_number = snap['phoneNumber'];
//                      userDetails.user_email_id = snap['email'];
//                      userDetails.user_organization = snap['organization'];
//                      userDetails.user_profession = snap['profession'];
//                      // push replacemnt for my account screen
//                      AuthServices.isLoading = false;
//                      print(
//                          "AuthServices()''': Getting user details from firebase, ${userDetails.user_name} ${userDetails.user_number}");
//                    }).catchError((e) {
//                      print(
//                          "AuthServices()''': Error on getting user detail in handleAuth()");
//                    });
//                  });
//                  return MyAccountScreen();
//                } else {
//                  isLoading = false;
//                  return Signin_Signup_Tabs();
//                }
//              });
//        });
//  }

  static Future<dynamic> customGoogleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    //this following line is not being recognized by firebase user so used stackpoverflow alternative
    //FirebaseUser user = await _auth.signInWithGoogle();
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: gSA.idToken, accessToken: gSA.accessToken);
//    AuthResult _authResult =
//        await
    _firebaseAuth.signInWithCredential(credential).then((_authResult) {
      FirebaseUser user = _authResult.user;
      print(
          "AuthServices()''': Signed in with google and Name is ${user.displayName}");
      // now check if this user is signing in for the first time
      _firestore
          .collection('userData')
          .document("${user.uid}")
          .get()
          .then((docSnap) {
        //if we get a value here in doc snap then the user details already exist
        if (docSnap.exists) {
          // then save the details in user class and go to home page
          //currentUser.name = docSnap['name'];
          return 1;
        } else {
          // this means the user is using google signup here for the first time
          print(
              "AuthServices()''': the signing is for the first time to to profile set up page");
          //use navigator here and pass the email, name, with navigator
          return 0;
        }
      });
    });
    //FirebaseUser user = _authResult.user;
    //print("CreateAccount_Android()''': Name is ${user.displayName}");
    //return user;
  }

  static Future<void> signInWithOTP(
      {authCredential,
      smsCode,
      verificationId,
      BuildContext context,
      Function() onResult}) async {
    print(
        "'AuthServices()''': signInWithOTP printing verID ${AuthServices.verID}");
//    print(
//        "'AuthServices()''': signInWithOTP printing verificarion Id being recieved  $verificationId");
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: AuthServices.verID, smsCode: smsCode);
    print(
        "AuthServices()''': signInWithOTP printing authCredential $_authCredential");
    _firebaseAuth.signInWithCredential(_authCredential).then((_signInResult) {
      FirebaseUser user = _signInResult.user;
      String deviceToken;
      // to check if first time login
      _firestore
          .collection('userData')
          .document("${user.uid}")
          .get()
          .then((snap) {
        if (snap.exists) {
          // TODO: save the details to current user variable
          _messaging.getToken().then((value) {
            // gettingthe token for push notifications here
            deviceToken = value;
            _firestore
                .collection('firebaseMessagingToken')
                .where('tokenString', isEqualTo: deviceToken)
                .getDocuments()
                .then((value) {
              if (value.documents.isEmpty) {
                // new token is detected add with user id
                _firestore.collection('firebaseMessagingToken').add(
                    {"tokenString": "$deviceToken", "userId": "${user.uid}"});
              } else {
                // just update the user id with this token value.documents.first.documentID
                _firestore
                    .collection('firebaseMessagingToken')
                    .document(value.documents.first.documentID)
                    .setData({
                  "tokenString": "$deviceToken",
                  "userId": "${user.uid}"
                });
              }
            });
          });

          _firestore
              .collection('likesData')
              .where('userId', isEqualTo: '${user.uid}')
              .getDocuments()
              .then((value2) {
            if (value2.documents.isNotEmpty) {
              value2.documents.forEach((element) {
                _myLikes.add(element['answerId']);
              });
            }
          });

          MyLikesAnsBookmarks myLikesAnsBookmarks =
              Provider.of<MyLikesAnsBookmarks>(context, listen: false);
          myLikesAnsBookmarks.storeMyLikesAnswers(_myLikes);

          Provider.of<UserDetails>(context, listen: false).setUserDetails(
              userID: snap.documentID,
              userName: snap['name'],
              userProfession: snap['profession'],
              userOrganization: snap['organization'],
              userPhoneNumber: snap['phoneNumber'],
              userEmailID: snap['email'],
              imageUrl: snap['profileImageURl']);
//
//          setUserDetails(
//            snap.documentID,
//            snap['name'],
//            snap['phoneNumber'],
//            snap['profileImageURl'],
//            snap['organization'],
//            snap['profession'],
//            snap['email'],
//          );
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
          onResult.call();
//                  builder: (context) => MyAccountScreen(snap.documentID)));
        } else {
          //TODO: make this push route named push to pop the loading screen

          print(
              "'AuthServices()''': signInWithOTP printing verID ${AuthServices.verID}");
          print(
              "'AuthServices()''': signInWithOTP printing USERID ${user.uid}");
          _messaging.getToken().then((value) {
            // gettingthe token for push notifications here
            deviceToken = value;
            _firestore
                .collection('firebaseMessagingToken')
                .where('tokenString', isEqualTo: deviceToken)
                .getDocuments()
                .then((value) {
              if (value.documents.isEmpty) {
                // new token is detected add with user id
                _firestore.collection('firebaseMessagingToken').add(
                    {"tokenString": "$deviceToken", "userId": "${user.uid}"});
              } else {
                // just update the user id with this token value.documents.first.documentID
                _firestore
                    .collection('firebaseMessagingToken')
                    .document(value.documents.first.documentID)
                    .setData({
                  "tokenString": "$deviceToken",
                  "userId": "${user.uid}"
                });
              }
            });
          });
          // new section added later will
          //TODO: to structuer the added code properly
          UserSignInFunctions _userSignInFunctions = UserSignInFunctions();
          _userSignInFunctions.newUserSignInPhoneNumber(
              context: context,
              userId: user.uid,
              phoneNumber: user.phoneNumber,
              deviceToken: deviceToken);

//          Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => ProfileSetupScreen(
//                        phoneNumber: user.phoneNumber,
//                        uid: user.uid,
//                      )));
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

  static Future<bool> verifyPhoneNumber(String phoneNumber,
      BuildContext context, Function moveToOtpScreen) async {
    String _verId;
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
      AuthServices.verID = verId;
      // as the condition is for codesent to the scaffold now it will show the otp input screen
      //TODO: send the smssent variable from here and verid
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpPage(
                    verificationId: AuthServices.verID,
                    number: phoneNumber,
                  )));
      if (moveToOtpScreen != null) {
        moveToOtpScreen.call();
      }
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      AuthServices.verID = verId;
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  static logOut(BuildContext context) {
    _firebaseAuth.signOut().then((value) {
      //now delete the local stored user data
      //Provider.of<UserDetails>(context, listen: false).deleteUserData();
      //TODO: pushreplacement to signIn Screen
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
      // Provider.of<UserDetails>(context).dispose();
    }).catchError(() {
      print("AuthServices()''': Error on logout");
    });
  }
}
