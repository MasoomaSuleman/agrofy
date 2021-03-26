import 'package:flutter/material.dart';
// aded dependencies
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// app dependencies
import 'package:kisaanCorner/src/model/user/user_model.dart';

class BookmarkFunctionality {
  Firestore _firestore = Firestore.instance;

  void bookmarkQuestion(
      String questionId, String userId, BuildContext context) {
    // add this question id to the list of bookmarks in userData
    _firestore.collection('userData').document(userId).updateData({
      'bookmarkList': FieldValue.arrayUnion(['$questionId'])
    });
    // update the provider list
    Provider.of<User>(context, listen: false).addBookmarkToProvider(questionId);
  }

  void unBookmarkQuestion(
      String questionId, String userId, BuildContext context) {
    // remove this quesrio from firebase
    _firestore.collection('userData').document(userId).updateData({
      'bookmarkList': FieldValue.arrayRemove(['$questionId'])
    });
    // update the provider list
    Provider.of<User>(context, listen: false)
        .removeBookmarkFromProvider(questionId);
  }
}
