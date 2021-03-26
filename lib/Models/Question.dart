import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisaanCorner/Models/images_model.dart';
import 'package:kisaanCorner/Models/pdf_model.dart';

class Question {
  // question by detils
  String questionByName;
  String questionByUID;
  String questionByProfession;
  String questionByImageURL;
  String questionByOrganization;
  // question details
  String questionText;
  String questionTimeStamp;
  String latestAnswerText;
  int replyCount;
  bool isAnswered;
  bool containsImage;
  List questionImages;
  var questionPdf;
  int category;
  String subcategory;
  // List<dynamic> bookmarks;
  String questionCardId;
  bool isQBookmarked;
  Question(
      {this.questionByName,
      this.questionByUID,
      this.questionByProfession,
      this.questionByImageURL,
      this.questionByOrganization,
      this.questionText,
      this.questionTimeStamp,
      this.latestAnswerText,
      this.replyCount,
      this.containsImage,
      this.questionImages,
      // this.bookmarks,
      this.questionCardId,
      this.isQBookmarked,
      this.questionPdf,
      this.category,
      this.subcategory});

  Map<String, dynamic> toMap() {
    return {
      'questionByName': questionByName,
      'questionByUID': questionByUID,
      'questionByProfession': questionByProfession,
      'questionByImageURL': questionByImageURL,
      'questionByOrganization': questionByOrganization,
      'questionText': questionText,
      'questionTimeStamp': questionTimeStamp,
      'latestAnswerText': '',
      'replyCount': 0,
      'containsImage': false,
      'isAnswered': false,
      'questionImages': questionImages,
      // 'bookmarks': bookmarks,
      'isQBookmarked': false,
      'questionPdf': questionPdf,
      'category': category,
      'subcategory': subcategory
    };
  }

  factory Question.fromSnapshot(DocumentSnapshot snap) {
    return Question(
      questionByName: snap.data["questionByName"],
      questionByUID: snap.data["questionByUID"],
      questionByProfession: snap.data["questionByProfession"],
      questionByImageURL: snap.data["questionByImageURL"] ?? '',
      questionByOrganization: snap.data["questionByOrganization"] ?? null,
      questionText: snap.data["questionText"],
      questionTimeStamp: snap.data["questionTimeStamp"],
      latestAnswerText: snap.data["latestAnswerText"],
      replyCount: snap.data["replyCount"],
      containsImage: snap.data["containsImage"],
      questionImages: List.from(
        snap.data['questionImages'].map((e) => ImagesModel.fromJson(e)),
      ),
      // bookmarks: snap.data['bookmarks'] ?? [],
      questionCardId: snap.documentID,
      isQBookmarked: snap['isQBookmarked'] ?? false,
      questionPdf: PdfModel.fromJson(snap.data['questionPdf']),
      category: snap.data['category'],
      subcategory: snap.data['subcategory'],
    );
  }
}
