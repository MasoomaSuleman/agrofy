import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenStreams {
  static Stream answeredStream = Firestore.instance
      .collection('questionData')
      .where('isAnswered', isEqualTo: true)
      .orderBy('questionTimeStamp', descending: true)
      //.limit(15)
      .snapshots();

  static Stream unAnsweredStream = Firestore.instance
      .collection('questionData')
      .where('isAnswered', isEqualTo: false)
      .orderBy('questionTimeStamp', descending: true)
      // .limit(15)
      .snapshots();

  static Stream _recomemdedStream = Firestore.instance
      .collection('questionData')
      .where('isAnswered', isEqualTo: false)
      .snapshots();
}
