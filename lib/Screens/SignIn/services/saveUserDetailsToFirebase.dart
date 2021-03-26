import 'package:flutter/material.dart';

// added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisaanCorner/provider/MyLikesAndBookmarks.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

// app dependencies
import 'package:kisaanCorner/provider/user_details.dart';

import 'package:kisaanCorner/Screens/SignIn/services/ProfileImageInput.dart';
import 'package:kisaanCorner/Screens/EditAnswer/ui_copmponents/LoadingDialogs.dart';
import 'package:kisaanCorner/Screens/SignIn/ui_components/showAlertDialogOKbutton.dart';

class SaveUserDetailsToFirebase {
  static Future<void> onCLickSaveDetailsToFirebaseUser(
      {@required BuildContext context,
      @required GlobalKey keyLoader,
      @required String userId,
      @required String userImageURL,
      @required String userName,
      String userEmail,
      @required String userProfession,
      String userPhoneNumber,
      String userOrganization}) async {
    Firestore _firestore = Firestore.instance;
    // show spinning loader
    LoadingDialogs.showPLeaseWaitLoading(context, keyLoader);
    UserDetails _userToPass = Provider.of<UserDetails>(context, listen: false);
    _userToPass.user_id = userId;

    if (ProfileImageInput.cropped != null) {
      // call the function to upload that imag to firebase
      final StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child(
              'profileImages/${DateTime.now().millisecondsSinceEpoch.toString()}');
      final StorageUploadTask task =
          firebaseStorageRef.putFile(ProfileImageInput.cropped);
      var completedTask = await task.onComplete;
      //String uplodedImageURL =await completedTask.ref.getDownloadURL().then((value) => _userToPass.user_image_url = value.toString());
      await completedTask.ref
          .getDownloadURL()
          .then((value) => _userToPass.user_image_url = value.toString());

      //_userToPass.user_image_url = uplodedImageURL;
      _userToPass.user_name = userName;
      _userToPass.userEmailID = userEmail;
      _userToPass.userProfession = userProfession;
      _userToPass.userPhoneNumber = userPhoneNumber;
      _userToPass.userOrganization = userOrganization;

      MyLikesAnsBookmarks myLikesAnsBookmarks =
          Provider.of<MyLikesAnsBookmarks>(context, listen: false);
      myLikesAnsBookmarks.storeMyLikesAnswers([]);

      await _firestore
          .collection('userData')
          .document(userId)
          .setData(UserDetails.toJson(_userToPass))
          .then((value) {
        // the user details are upadet to firebase
        print(
            "SaveUserDeatailsToFirebase()''': The user detials are save dsussesfully ");

        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();

        AlertDialogs.showAlertDialogWithOKbutton(
            context, 'New User Added Successfully');
        // store to provider
      }).catchError((e) {
        // some error on creating the user
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();

        AlertDialogs.showAlertDialogOnError(context, 'Error in adding user');
        // store to provider
        // push home screen
        // stop loading show
        // tell user error
        //push sign in sign in screen
      });

      // then save details to user
    } else {
      (userImageURL == null)
          ? _userToPass.user_image_url = null
          : _userToPass.user_image_url = userImageURL;
      _userToPass.user_name = userName;
      _userToPass.userEmailID = userEmail;
      _userToPass.userProfession = userProfession;
      _userToPass.userPhoneNumber = userPhoneNumber;
      _userToPass.userOrganization = userOrganization;

      await _firestore
          .collection('userData')
          .document(userId)
          .setData(UserDetails.toJson(_userToPass))
          .then((value) {
        // the user details are upadet to firebase
        print(
            "SaveUserDeatailsToFirebase()''': The user detials are save dsussesfully ");

        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();

        AlertDialogs.showAlertDialogWithOKbutton(
            context, 'New User Added Successfully');
        // store to provider
        // push home screen
      }).catchError((e) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();

        AlertDialogs.showAlertDialogOnError(context, 'Error in adding user');
        // stop loading show
        // tell user error
        //push sign in sign in screen
      });
    }
  }
}
