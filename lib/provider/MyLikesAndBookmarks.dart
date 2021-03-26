import 'package:flutter/material.dart';

class MyLikesAnsBookmarks with ChangeNotifier {
  List<String> myLikedAnswers;
  List<String> myBookmarks;

  MyLikesAnsBookmarks({this.myLikedAnswers, this.myBookmarks});

  void storeMyLikesAnswers(List<String> value) {
    myLikedAnswers = value;
    // notifyListeners();/
  }

  void storeMyBookmarks(List<String> value) {
    myLikedAnswers = value;
    notifyListeners();
  }

  void deleteLike(String answerId) {
    myLikedAnswers.remove(answerId);
  }

  void addLike(String answerId) {
    myLikedAnswers.add(answerId);
  }

//  List<String> get myLikedAnswers => _myLikedAnswers;
//
//  set myLikedAnswers(List<String> value) {
//    _myLikedAnswers = value;
//  }
//
//  List<String> get myBookmarks => _myBookmarks;
//
//  set myBookmarks(List<String> value) {
//    _myBookmarks = value;
//  }
}
