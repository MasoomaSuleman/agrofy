import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisaanCorner/Models/images_model.dart';
import 'package:kisaanCorner/Models/pdf_model.dart';

class ReportQuestion {
  // question by detils
  
  List reportQuestionByUid;
  String questionCardId;
  bool isQBookmarked;
      ReportQuestion(
      {
      this.questionCardId,
      this.reportQuestionByUid,
      });

  Map<String, dynamic> toMap() {
    return {
      'reportQuestionByUid': reportQuestionByUid.map((e) => e.toJson()).toList(),
      'questionCardId': questionCardId
    };
  }

  factory ReportQuestion.fromSnapshot(DocumentSnapshot snap) {
    return ReportQuestion(
      reportQuestionByUid: snap.data['reportQuestionByUid'],
      questionCardId: snap.data['questionCardId']
    );
  }
}
