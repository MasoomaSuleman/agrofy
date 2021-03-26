import 'package:flutter/material.dart';
// aded dependencies
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// app dependencies
import 'package:kisaanCorner/src/model/user/user_model.dart';

class LikeFunctionality {
  Firestore _firestore = Firestore.instance;

  void likeQuestion(
      String answerId, String userId, BuildContext context) {
    // add this question id to the list of bookmarks in userData
    _firestore.collection('userData').document(userId).updateData({
      'likeList': FieldValue.arrayUnion(['$answerId'])
    });
    // update the provider list
    Provider.of<User>(context, listen: false).addLikeToProvider(answerId);
  }

  void unLikeQuestion(
      String answerId, String userId, BuildContext context) {
    // remove this quesrio from firebase
    _firestore.collection('userData').document(userId).updateData({
      'likeList': FieldValue.arrayRemove(['$answerId'])
    });
    // update the provider list
    Provider.of<User>(context, listen: false)
        .removeLikeFromProvider(answerId);
  }
}
