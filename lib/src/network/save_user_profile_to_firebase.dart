import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/model/user/personal_information/personal_information_model.dart';

class SaveUserProfileToFirebase {
  final Firestore _firestore = Firestore.instance;
  final StorageReference _firebaseStorageRef = FirebaseStorage.instance.ref();

  Future<bool> saveNewUserProfileToFirebase(
      User userToBeAdded, BuildContext context) async {
    if (userToBeAdded.personalInformation.profileImageUrl == null &&
        userToBeAdded.personalInformation.inputProfileImage != null) {
      print(
          "SaveUserProfileToFirebase():''' saveNewUserProfileToFirebase(): image is getting uploaded...");
      userToBeAdded.personalInformation.profileImageUrl =
          await saveProfileImageToFirestore(
              userToBeAdded.personalInformation.inputProfileImage,
              userToBeAdded.userId,
              context);
      print(
          "SaveUserProfileToFirebase():''' saveNewUserProfileToFirebase(): value of profileImage ${userToBeAdded.personalInformation.profileImageUrl}");

      String _upload = await _firestore
          .collection('userData')
          .document(userToBeAdded.userId)
          .setData(userToBeAdded.toMap())
          .then((value) {
        return 'success';
      }).catchError((e) => 'failed' + e.toString());
      if (_upload == 'success') {
        //returning false beacause it is awaiting error
        Provider.of<User>(context, listen: false).fromModel(userToBeAdded);
        return false;
      } else {
        print(
            "SaveUserProfileToFirebase()''': saveNewUserProfileToFirebase(): eroor on uploading new user data:  $_upload");
        return true;
      }
    } else {
      String _upload = await _firestore
          .collection('userData')
          .document(userToBeAdded.userId)
          .setData(userToBeAdded.toMap())
          .then((value) => 'success')
          .catchError((e) => 'failed ' + e.toString());
      if (_upload == 'success') {
        Provider.of<User>(context, listen: false).fromModel(userToBeAdded);
        return false;
      } else {
        print(
            "SaveUserProfileToFirebase()''': saveNewUserProfileToFirebase(): eroor on uploading new user data with error  $_upload");
        return true;
      }
    }
  }

  Future<bool> savePersonalInformationToFirebase(
      {PersonalInformationModel personalInformationModel,
      @required String userId,
      BuildContext context}) async {
    if (personalInformationModel.profileImageUrl == null &&
        personalInformationModel.inputProfileImage != null) {
//      print(
//          "SaveUserProfileToFirebase():''' saveNewUserProfileToFirebase(): image is getting uploaded...");
      //  personalInformationModel.profileImageUrl =
      await saveProfileImageToFirestore(
              personalInformationModel.inputProfileImage, userId, context)
          .then((value) {
        personalInformationModel.profileImageUrl = value;
      });
//      print(
//          "SaveUserProfileToFirebase():''' saveNewUserProfileToFirebase(): value of profileImage ${userToBeAdded.personalInformation.profileImageUrl}");
      String _upload = await _firestore
          .collection('userData')
          .document(userId)
          .updateData(personalInformationModel.toMap())
          .then((value) => 'success')
          .catchError((e) => 'failed ' + e.toString());
      if (_upload == 'success') {
        Provider.of<User>(context, listen: false)
            .fromPersonalInformationModel(personalInformationModel);
        return true;
      } else {
//        print(
//            "SaveUserProfileToFirebase()''': saveNewUserProfileToFirebase(): eroor on uploading new user data with error  $_upload");
        return false;
      }
    } else {
      String _upload = await _firestore
          .collection('userData')
          .document(userId)
          .updateData(personalInformationModel.toMap())
          .then((value) => 'success')
          .catchError((e) => 'failed ' + e.toString());
      if (_upload == 'success') {
        Provider.of<User>(context, listen: false)
            .fromPersonalInformationModel(personalInformationModel);
        return true;
      } else {
//        print(
//            "SaveUserProfileToFirebase()''': saveNewUserProfileToFirebase(): eroor on uploading new user data with error  $_upload");
        return false;
      }
    }
  }

  Future<dynamic> saveProfileImageToFirestore(
      File inputProfileImage, String userId, BuildContext context) async {
    final StorageUploadTask _task = _firebaseStorageRef
        .child('profileImages/$userId')
        .putFile(inputProfileImage);
    var completedTask = await _task.onComplete;
    if (_task.isSuccessful) {
      String temp = await completedTask.ref.getDownloadURL();
      List newList = temp.split('&token=');
//      print(
//          "SaveUserProfileToFirebase()''': saveProfileImageToFirestore()''': the split values are ${newList.toString()}");
      print(
          "SaveUserProfileToFirebase()''': saveProfileImageToFirestore()''': the split values are ${newList[0]}");
//
//      print(
//          "SaveUserProfileToFirebase()''': saveProfileImageToFirestore: image download url: ${value.toString()}");
      // set the input profile image to null
      Provider.of<User>(context, listen: false).setInputProfileImageToNull();
      return newList[0];
    } else {
      print(
          "SaveUserProfileToFirebase()''': saveProfileImageToFirestore: error on uploading user Profile Imaehe");
      return Future.error(
          "SaveUserProfileToFirebase()''': saveProfileImageToFirestore: error on uploading user Profile Imaehe ");
    }
  }

  Future<dynamic> saveNewProfileImageToFirestoreAndUserDetails(
      {File inputProfileImage, BuildContext context, String userId}) async {
    //  String userId = Provider.of<User>(context, listen: false).userId;
    final StorageUploadTask _task = _firebaseStorageRef
        .child('profileImages/$userId')
        .putFile(inputProfileImage);
    var completedTask = await _task.onComplete;
    if (_task.isSuccessful) {
      String temp = await completedTask.ref.getDownloadURL();
      List<String> newList = temp.split('&token=');

//      print(
//          "SaveUserProfileToFirebase()''': saveProfileImageToFirestore: image download url: ${newList[0].toString()}");
      // save the new profile image to user details
      await _firestore
          .collection('userData')
          .document(userId)
          .updateData({'profileImageUrl': newList[0]});
      //Provider.of<User>(context, listen: false).setNewProfileImage(newList[0]);
      return newList[0];
    } else {
      print(
          "SaveUserProfileToFirebase()''': saveProfileImageToFirestore: error on uploading user Profile Imaehe");
      return Future.error(
          "SaveUserProfileToFirebase()''': saveProfileImageToFirestore: error on uploading user Profile Imaehe ");
    }
  }

  Future<bool> addExp(List exp, String userId) async {
    String _upload =
        await _firestore.collection('userData').document(userId).updateData({
      'experienceList': exp.map((e) => e.toJson()).toList(),
    }).then((value) {
      return 'success';
    }).catchError((e) => 'failed' + e.toString());
    if (_upload == 'success') {
      return true;
    } else {
      print(
          "SaveUserProfileToFirebase()''': saveNewUserProfileToFirebase(): eroor on uploading new user data:  $_upload");
      return false;
    }
  }

  Future<bool> addAch(List ach, String userId) async {
    String _upload =
        await _firestore.collection('userData').document(userId).updateData({
      'achievementList': ach.map((e) => e.toJson()).toList(),
    }).then((value) {
      return 'success';
    }).catchError((e) => 'failed' + e.toString());
    if (_upload == 'success') {
      return true;
    } else {
      print(
          "SaveUserProfileToFirebase()''': saveNewUserProfileToFirebase(): eroor on uploading new user data:  $_upload");
      return false;
    }
    /*final user = await FirebaseAuth.instance.currentUser();

    String _upload =
        await _firestore.collection('userData').document(user.uid).updateData({
      'achievementList': ach.achievementList.map((e) => e.toJson()).toList(),
    }).then((value) {
      return 'success';
    }).catchError((e) => 'failed' + e.toString());
    if (_upload == 'success') {
      return false;
    } else {
      print(
          "SaveUserProfileToFirebase()''': saveNewUserProfileToFirebase(): eroor on uploading new user data:  $_upload");
      return true;
    }
  }*/
  }
}
