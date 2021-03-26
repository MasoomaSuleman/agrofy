import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisaanCorner/Screens/EditAnswer/ui_copmponents/AlertDialogs.dart';

import 'package:kisaanCorner/Screens/EditAnswer/ui_copmponents/LoadingDialogs.dart';

class UpdateAndDelete {
  static Future<void> updateAnswer(
    BuildContext context,
    GlobalKey _keyLoader,
    DocumentSnapshot _answerSnapshot,
    TextEditingController _answerText,
    String _answerImageURl,
    File _imageFile,
  ) async {
    Firestore _firestore = Firestore.instance;
    LoadingDialogs.showPLeaseWaitLoading(context, _keyLoader);
    String _time = DateTime.now().toString();
    // imagefile is not null then first upload the image to firestore t then updaste the answer
    if (_imageFile != null) {
      final StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child(
              'answerImages/${DateTime.now().millisecondsSinceEpoch.toString()}');
      final StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
      var completedTask = await task.onComplete;
      String uplodedImageURL = await completedTask.ref.getDownloadURL();
      _firestore
          .collection('answerData')
          .document(_answerSnapshot.documentID)
          .updateData({
        'answerText': _answerText.text,
        'answerTimeStamp': '$_time',
        'answerImageURL': uplodedImageURL
      }).then((value) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        print("EditAnswerScreen()''': update answer with image complete");
        AlertDialogs.showAlertDialogWithOKbutton(
            context, 'Answer Updated Succesfully');
      }).catchError((e) {
        print(
            "UpdateAndDeleteToFirestore()''': Error while updating the answer $e");
      });
    } else {
      _firestore
          .collection('answerData')
          .document(_answerSnapshot.documentID)
          .updateData({
        'answerText': _answerText.text,
        'answerTimeStamp': '$_time'
      }).then((value) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        //print("EditAnswerScreen()''': update answer complete");
        AlertDialogs.showAlertDialogWithOKbutton(
            context, 'Answer Updated Succesfully');
      }).catchError((e) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true)
            .pop(); //close the dialoge
        // show error message
        // print("EditAnswerScreen()''': Error while updating the answer $e");
        AlertDialogs.showAlertDialogWithOKbutton(
            context, 'Something went wronk.Please try again later');
      });
    }
  }

  static Future<void> deleteAnswer(BuildContext context, GlobalKey _keyLoader,
      DocumentSnapshot answerSnapshot) {
    Firestore _firestore = Firestore.instance;
    LoadingDialogs.showPLeaseWaitLoading(context, _keyLoader);
    _firestore
        .collection('answerData')
        .document(answerSnapshot.documentID)
        .delete()
        .then((value) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      AlertDialogs.showAlertDialogWithOKbutton(
          context, 'Answer deleted Succesfully');
    }).catchError(() {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      AlertDialogs.showAlertDialogWithOKbutton(
          context, 'Something went wrong try again later');
    });
  }

  static Future<void> deleteMyQuestion(BuildContext context,
      GlobalKey _keyLoader, DocumentSnapshot questionSnapshot) {
    Firestore _firestore = Firestore.instance;
    LoadingDialogs.showPLeaseWaitLoading(context, _keyLoader);
    _firestore
        .collection('questionData')
        .document(questionSnapshot.documentID)
        .delete()
        .then((value) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      AlertDialogs.showAlertDialogWithOKbutton(
          context, 'Question deleted Succesfully');
    }).catchError(() {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      AlertDialogs.showAlertDialogWithOKbutton(
          context, 'Something went wrong try again later');
    });
  }
}
