import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'file_model.dart';
import 'image_model.dart';

class Answer {
  // question Details
  String questionByName;
  String questionByUID;
  String questionByProfession;
  String questionByImageURL;
  String questionText;
  String questionTimeStamp;
  String questionUID;
  String questionByOrganization;
  // answer Details
  String answerUID;
  String answerText;
  String answerTimeStamp;
  // can add multiple Images
  String answerImageURL;
  // can add multiple fies
  //
  List<FileModel> answerFiles = [];
  int likesCount;
  //String _answerImage;

  List<ImageModel> answerImages = [];

  // answer udser details
  String answerByUID;
  String answerByName;
  String answerByProfession;
  String answerByOrganization;
  // answer by organization
  //
  String answerByImageURL;

  List<Asset> inputMultipleImages;
  List<File> inputMultipleFiles;

  // fields count = 20 +2

  Answer(
      {this.questionByName,
      this.questionByUID,
      this.questionByProfession,
      this.questionByImageURL,
      this.questionText,
      this.questionTimeStamp,
      this.questionUID,
      this.questionByOrganization,
      this.answerUID,
      this.answerFiles,
      this.answerImages,
      this.answerText,
      this.answerByUID,
      this.answerByName,
      this.answerByProfession,
      this.answerByImageURL,
      this.answerByOrganization,
      this.answerTimeStamp,
      this.answerImageURL,
      this.likesCount,
      this.inputMultipleImages,
      this.inputMultipleFiles}); //

  List returnImageModelList(answerImages) {
    List temp = [];
    if (answerImages == null) return null;
    answerImages.forEach((element) {
      temp.add(element.toMap());
    });
    return temp;
  }

  List returnFileModelList(answerfiles) {
    List temp = [];
    if (answerfiles == null) return null;
    answerfiles.forEach((element) {
      temp.add(element.toJson());
    });
    return temp;
  }

  Map<String, dynamic> toMap() {
    return {
      'questionUID': questionUID,
      'questionByName': questionByName,
      'questionByUID': questionByUID,
      'questionByProfession': questionByProfession,
      'questionByImageURL': questionByImageURL,
      'questionText': questionText,
      'questionByOrganization': questionByOrganization,
//      this.answerUID,
//      this.answerFiles,
//      this.answerImages,
//
      'answerUID': answerUID,
      'answerFiles': returnFileModelList(answerFiles),
      'answerImages': returnImageModelList(answerImages),
      'questionTimeStamp': questionTimeStamp,
      'answerText': answerText,
      'answerTimeStamp': answerTimeStamp,
      'answerByUID': answerByUID,
      'answerByName': answerByName,
      'answerByProfession': answerByProfession,
      'answerByImageURL': answerByImageURL,
      'answerByOrganization': answerByOrganization,
      'answerImageURL': answerImageURL,
      'likesCount': 0
    };
  }

  Answer returnEditAnswerModel(DocumentSnapshot snap) {
    return Answer(
      questionUID: snap.data['questionUID'],
      questionByName: snap.data['questionByName'],
      questionByUID: snap.data['questionByUID'],
      questionText: snap.data['questionText'],
      questionTimeStamp: snap.data['questionTimeStamp'],
      questionByProfession: snap.data['questionByProfession'],
      questionByImageURL: snap.data['questionByImageURL'],
      questionByOrganization: snap.data['questionByOrganization'],
      answerByUID: snap.data['answerByUID'],
      answerUID: snap.data['answerUID'],
      answerTimeStamp: snap.data['answerTimeStamp'],
      answerText: snap.data['answerText'],
      answerByImageURL: snap.data['answerByImageURL'],
      answerByName: snap.data['answerByName'],
      answerByProfession: snap.data['answerByProfession'],
      answerByOrganization: snap.data['answerByOrganization'],
      // answerFiles: getAnswerFiles(snap)
//      List.from(
//        snap.data['answerFiles'].map((e) => FileModel.fromJson(e)),
//      )
      // ,
      //  answerImages: getAnswerImages(snap)
//      List.from(
//        snap.data['answerImages'].map((e) => ImageModel.fromJson(e)),
//      )
      // ,
      inputMultipleImages: [],
      inputMultipleFiles: [],

      answerImageURL: snap.data['answerImageURL'],
      likesCount: snap.data['likesCount'],
    );
  }

  factory Answer.fromSnapshot(DocumentSnapshot snap) {
    List<FileModel> getAnswerFiles(snap) {
      if (snap.data['answerFiles'] == null) {
        return null;
      } else
        return List.from(
          snap.data['answerFiles'].map((e) => FileModel.fromJson(e)),
        );
    }

    List<ImageModel> getAnswerImages(snap) {
      if (snap.data['answerFiles'] == null) {
        return null;
      } else
        return List.from(
          snap.data['answerImages'].map((e) => ImageModel.fromJson(e)),
        );
    }

    return Answer(
      questionUID: snap.data['questionUID'],
      questionByName: snap.data['questionByName'],
      questionByUID: snap.data['questionByUID'],
      questionText: snap.data['questionText'],
      questionTimeStamp: snap.data['questionTimeStamp'],
      questionByProfession: snap.data['questionByProfession'],
      questionByImageURL: snap.data['questionByImageURL'],
      questionByOrganization: snap.data['questionByOrganization'],
      answerByUID: snap.data['answerByUID'],
      answerUID: snap.data['answerUID'],
      answerTimeStamp: snap.data['answerTimeStamp'],
      answerText: snap.data['answerText'],
      answerByImageURL: snap.data['answerByImageURL'],
      answerByName: snap.data['answerByName'],
      answerByProfession: snap.data['answerByProfession'],
      answerByOrganization: snap.data['answerByOrganization'],
      answerFiles: getAnswerFiles(snap)
//      List.from(
//        snap.data['answerFiles'].map((e) => FileModel.fromJson(e)),
//      )
      ,
      answerImages: getAnswerImages(snap)
//      List.from(
//        snap.data['answerImages'].map((e) => ImageModel.fromJson(e)),
//      )
      ,
      answerImageURL: snap.data['answerImageURL'],
      likesCount: snap.data['likesCount'],
    );
  }

//  List<ImageModel> listOfImagesFromMultiImagePicker(
//      {List<Asset> selectedImages}) {
//    List<ImageModel> _listToReturn = [];
//    for (int i = 0; i < selectedImages.length; i++) {}
//    return _listToReturn;
//  }

//  factory Answer.fromJson(Map<String, dynamic> json) {
//    return Answer(
//      questionUID: json['questionUID'],
//      questionByName: json['questionByName'],
//      questionByUID: json['questionByUID'],
//      questionByProfession: json['questionByProfession'],
//      questionByImageURL: json['questionByImageURL'],
//      questionText: json['questionText'],
//      questionTimeStamp: json['questionTimeStamp'],
//      answerText: json['answerText'],
//      answerTimeStamp: json['answerTimeStamp'],
//      answerByUID: json['answerByUID'],
//      answerByName: json['answerByName'],
//      answerByProfession: json['answerByProfession'],
//      answerByImageURL: json['answerByImageURL'],
//      answerImageURL: json['answerImageURL'],
//      likesCount: json['likesCount'],
//    );
//  }
}
