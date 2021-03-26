import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

// other components
import 'package:kisaanCorner/Screens/EditAnswer/ui_copmponents/AlertDialogs.dart';
import 'package:kisaanCorner/Screens/EditAnswer/ui_copmponents/LoadingDialogs.dart';
import 'package:kisaanCorner/Models/Answer.dart';
import 'package:kisaanCorner/provider/user_details.dart';
import 'package:provider/provider.dart';

class AddAnswerToFirestore {
  static Future<void> submitAnswerToFirestore(
    BuildContext context,
    GlobalKey _keyLoader,
    DocumentSnapshot _questionSnapshot,
    File _imageFile,
    TextEditingController _answerEditingController,
  ) async {
    Firestore _firestore = Firestore.instance;
    LoadingDialogs.showPLeaseWaitLoading(context, _keyLoader);

    if (_imageFile != null) {
      UserDetails _userDetails =
          Provider.of<UserDetails>(context, listen: false);
      Answer _answerToPass = new Answer();
      // question details to answer
      _answerToPass.questionByName = _questionSnapshot.data['questionByName'];
      _answerToPass.questionByUID = _questionSnapshot.data['questionByUID'];
      _answerToPass.questionByProfession =
          _questionSnapshot.data['questionByProfession'];
      _answerToPass.questionByImageURL =
          _questionSnapshot.data['questionByImageURL'];
      _answerToPass.questionText = _questionSnapshot.data['questionText'];
      _answerToPass.questionTimeStamp =
          _questionSnapshot.data['questionTimeStamp'];
      _answerToPass.questionUID = _questionSnapshot.documentID;
      // answer user details
      _answerToPass.answerText = _answerEditingController.text.toString();
      _answerToPass.answerByUID = _userDetails.user_id;
      _answerToPass.answerByName = _userDetails.user_name;
      _answerToPass.answerByProfession = _userDetails.userProfession;
      _answerToPass.answerByImageURL = _userDetails.user_image_url;
      _answerToPass.answerTimeStamp = DateTime.now().toString();
      _answerToPass.likesCount = 0;
      // have to add image and the answer also
      final StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child(
              'answerImages/${DateTime.now().millisecondsSinceEpoch.toString()}');
      final StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
      var completedTask = await task.onComplete;
      String _uplodedImageURL = await completedTask.ref.getDownloadURL();
      // now upload this answer to firebase
      _answerToPass.answerImageURL = _uplodedImageURL;
      _firestore
          .collection('answerData')
          .add(_answerToPass.toMap())
          .then((value) {
        print(
            "AddAnswerToFirestore()''': new answer added success with id: ${value.documentID}");
        // now update latest answer details to tehe question
        _firestore
            .collection("questionData")
            .document(_answerToPass.questionUID)
            .updateData({
          "latestAnswerText": _answerToPass.answerText,
          "isAnswered": true,
          "replyCount": ++_questionSnapshot.data['replyCount']
        }).whenComplete(() {
          print(
              "AddAnswerToFirestore()''': latest answer is updated to the question");
          //TODO: show alert dialog to tell answer is added and Navigatoer pop
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          print("AddAnswerToFirestore()''': update answer with image complete");
          AlertDialogs.showAlertDialogWithOKbutton(
              context, 'Answer Added Succesfully');
        });
      }).catchError((e) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        AlertDialogs.showAlertDialogWithOKbutton(
            context, 'Something went wrong. Please, try again later');
        print("AddAnswerToFirestore()''': Error while adding a new answer $e");
      });
      // then update the question details

    } else {
      // only upload the answer text
      UserDetails _userDetails =
          Provider.of<UserDetails>(context, listen: false);
      Answer _answerToPass = new Answer();
      // question details to answer
      _answerToPass.questionByName = _questionSnapshot.data['questionByName'];
      _answerToPass.questionByUID = _questionSnapshot.data['questionByUID'];
      _answerToPass.questionByProfession =
          _questionSnapshot.data['questionByProfession'];
      _answerToPass.questionByImageURL =
          _questionSnapshot.data['questionByImageURL'];
      _answerToPass.questionText = _questionSnapshot.data['questionText'];
      _answerToPass.questionTimeStamp =
          _questionSnapshot.data['questionTimeStamp'];
      _answerToPass.questionUID = _questionSnapshot.documentID;
      // answer user details
      _answerToPass.answerText = _answerEditingController.text.toString();
      _answerToPass.answerByUID = _userDetails.user_id;
      _answerToPass.answerByName = _userDetails.user_name;
      _answerToPass.answerByProfession = _userDetails.userProfession;
      _answerToPass.answerByImageURL = _userDetails.user_image_url;
      _answerToPass.answerTimeStamp = DateTime.now().toString();
      _answerToPass.likesCount = 0;
      _firestore
          .collection('answerData')
          .add(_answerToPass.toMap())
          .then((value) {
        print(
            "AddAnswerToFirestore()''': new answer added success with id: ${value.documentID}");
        // now update latest answer details to tehe question
        _firestore
            .collection("questionData")
            .document(_answerToPass.questionUID)
            .updateData({
          "latestAnswerText": _answerToPass.answerText,
          "isAnswered": true,
          "replyCount": ++_questionSnapshot.data['replyCount']
        }).whenComplete(() {
          print(
              "AddAnswerToFirestore()''': latest answer is updated to the question");
          //TODO: show alert dialog to tell answer is added and Navigatoer pop
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          print("AddAnswerToFirestore()''': update answer with image complete");
          AlertDialogs.showAlertDialogWithOKbutton(
              context, 'Answer Added Succesfully');
        });
      }).catchError((e) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        AlertDialogs.showAlertDialogWithOKbutton(
            context, 'Something went wrong. Please, try again later');
        print("AddAnswerToFirestore()''': Error while adding a new answer $e");
      });
    }
  }
}
