import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:kisaanCorner/src/model/answer/image_model.dart';
import 'package:kisaanCorner/src/model/answer/file_model.dart';
import 'package:kisaanCorner/src/model/answer/answer_model.dart';

class EditAnswerInFirebase {
  Firestore _firestore = Firestore.instance;
  void deleteAnswerImageFromList(
      String answerId, ImageModel imageModelToDelete) {
    Firestore.instance.collection('answerData').document(answerId).updateData({
      'answerImages': FieldValue.arrayRemove([imageModelToDelete.toJson()])
    });
  }

  void deleteAnswerFileFromList(String answerId, FileModel fileModelToDelete) {
    Firestore.instance.collection('answerData').document(answerId).updateData({
      'answerFiles': FieldValue.arrayRemove([fileModelToDelete.toJson()])
    });
  }

  Future<bool> editAnswerInFirebase(
      {Answer answerToPostToFirebase, String answerId}) async {
    try {
      if (answerToPostToFirebase.inputMultipleImages != null) {
        answerToPostToFirebase.answerImages =
            await storeMultipleImagesToFirebase(
                answerToPostToFirebase: answerToPostToFirebase,
                inputMultipleImages: answerToPostToFirebase.inputMultipleImages,
                userId: answerToPostToFirebase.answerByUID);
        await _firestore
            .collection('answerData')
            .document(answerId)
            .updateData({
//          'answerText': answerToPostToFirebase.answerText,
//          'answerTimeStamp': answerToPostToFirebase.answerTimeStamp,
//        'answerFiles': FieldValue.arrayUnion(answerToPostToFirebase
//            .returnFileModelList(answerToPostToFirebase.answerFiles)),
          'answerImages': FieldValue.arrayUnion(answerToPostToFirebase
              .returnImageModelList(answerToPostToFirebase.answerImages)),
        });
      }
      if (answerToPostToFirebase.inputMultipleFiles != null) {
        answerToPostToFirebase.answerFiles = await storeMultipleFilesToFirebase(
            answerToPostToFirebase: answerToPostToFirebase,
            inputMultipleFiles: answerToPostToFirebase.inputMultipleFiles,
            userId: answerToPostToFirebase.answerByUID);
        await _firestore
            .collection('answerData')
            .document(answerId)
            .updateData({
          'answerFiles': FieldValue.arrayUnion(answerToPostToFirebase
              .returnFileModelList(answerToPostToFirebase.answerFiles)),
        });
      }
      // post the answer to firebase
      // update the question data
      await _firestore.collection('answerData').document(answerId).updateData({
        'answerText': answerToPostToFirebase.answerText,
        'answerTimeStamp': answerToPostToFirebase.answerTimeStamp,
//        'answerFiles': FieldValue.arrayUnion(answerToPostToFirebase
//            .returnFileModelList(answerToPostToFirebase.answerFiles)),
//        'answerImages': FieldValue.arrayUnion(answerToPostToFirebase
//            .returnImageModelList(answerToPostToFirebase.answerImages)),
      }).catchError((e) {
        throw Exception(e);
      });

//      await _firestore.collection('answerData').document(answerId).updateData({
//        'answerText': answerToPostToFirebase.answerText,
//        'answerTimeStamp': answerToPostToFirebase.answerTimeStamp,
//        'answerFiles': FieldValue.arrayUnion(answerToPostToFirebase
//            .returnFileModelList(answerToPostToFirebase.answerFiles)),
//        'answerImages': FieldValue.arrayUnion(answerToPostToFirebase
//            .returnImageModelList(answerToPostToFirebase.answerImages)),
//      })
////        .add(answerToPostToFirebase.toMap())
//          .then((value) async {
//        print(
//            "AddAnswerToFirestore()''': new answer added success with id: $answerId");
//        // now update latest answer details to tehe question
//        return true;
//      });

      return true;
    } on Exception {
      return false;
    }
  }

  Future<List<FileModel>> storeMultipleFilesToFirebase(
      {Answer answerToPostToFirebase,
      List<File> inputMultipleFiles,
      String userId}) async {
    List<FileModel> toReturn = [];
    for (int i = 0; i < inputMultipleFiles.length; i++) {
      // save each asset to firebase
      // send folder name also
      toReturn.add(await saveFileToFirestore(
          file: inputMultipleFiles[i], userId: userId));
    }
    print(
        "AddAnswerToFirebase()''': storeMultipleFilesToFirebase()''': this function is working fine ${toReturn.toString()}");
    return toReturn;
  }

  Future<FileModel> saveFileToFirestore({File file, String userId}) async {
    //ByteData byteData = await asset.getByteData();
    //List<int> imageData = byteData.buffer.asUint8List();
    var now = DateTime.now().millisecondsSinceEpoch;
    StorageReference ref =
        FirebaseStorage.instance.ref().child("answerFiles/$userId/$now");

    StorageUploadTask uploadTask = ref.putFile(file);
    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      // You can use this to notify yourself or your user in any kind of way.
      // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      // to show your user what the current status is. In that case, you would not need to cancel any
      // subscription as StreamBuilder handles this automatically.

      // Here, every StorageTaskEvent concerning the upload is printed to the logs.
      print(
          "${(event.snapshot.bytesTransferred * 100 / event.snapshot.totalByteCount)}%");
      print('EVENT ${event.type}');
    });
    var storageSnapshot = await uploadTask.onComplete;
// Cancel your subscription when done.
    streamSubscription.cancel();
    var url = await storageSnapshot.ref.getDownloadURL();
    print("images uploaded==================>>>>>");
    // now return the file model with all values
    return FileModel(
        url: '$url',
        name: '${basename(file.path)}',
        type: '',
        size: await file.length());
    //return ImageModel(id: "$now", url: url);
  }

  Future<ImageModel> saveImageToFirestore({Asset asset, String userId}) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    var now = DateTime.now().millisecondsSinceEpoch;
    StorageReference ref =
        FirebaseStorage.instance.ref().child("answerImages/$userId/$now.jpg");
    StorageUploadTask uploadTask = ref.putData(imageData);
    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      // You can use this to notify yourself or your user in any kind of way.
      // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      // to show your user what the current status is. In that case, you would not need to cancel any
      // subscription as StreamBuilder handles this automatically.

      // Here, every StorageTaskEvent concerning the upload is printed to the logs.
      print(
          "${(event.snapshot.bytesTransferred * 100 / event.snapshot.totalByteCount)}%");
      print('EVENT ${event.type}');
    });
    var storageSnapshot = await uploadTask.onComplete;
// Cancel your subscription when done.
    streamSubscription.cancel();
    var url = await storageSnapshot.ref.getDownloadURL();
    print("images uploaded==================>>>>>");
    return ImageModel(id: "$now", url: url);
  }

  Future<List<ImageModel>> storeMultipleImagesToFirebase(
      {Answer answerToPostToFirebase,
      List<Asset> inputMultipleImages,
      String userId}) async {
    List<ImageModel> toReturn = [];
    for (int i = 0; i < inputMultipleImages.length; i++) {
      // save each asset to firebase
      // send folder name also
      toReturn.add(await saveImageToFirestore(
          asset: inputMultipleImages[i], userId: userId));
    }
    print(
        "AddAnswerToFirebase()''': storeMultipleImagesToFirebase()''': this function is working fine ${toReturn.toString()}");
    return toReturn;
  }
}
