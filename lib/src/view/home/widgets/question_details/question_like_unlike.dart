import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/Models/LikeDataModel.dart';
import 'package:kisaanCorner/provider/MyLikesAndBookmarks.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/network/like_functionality.dart';
import 'package:provider/provider.dart';

Size _size;
List<String> _myLikedAnswers = [];
MyLikesAnsBookmarks _myLikesAnsBookmarks = MyLikesAnsBookmarks();

Firestore _firestore = Firestore.instance;

class OnClickLikeOrUnlikeAnswer extends StatefulWidget {
  final DocumentSnapshot answerSnapshot;
  final String userId;
  final int likesCount;
  final bool isLiked;
  OnClickLikeOrUnlikeAnswer(
      {this.answerSnapshot, this.userId, this.likesCount, this.isLiked});
  @override
  OnClickLikeOrUnlikeAnswerState createState() =>
      OnClickLikeOrUnlikeAnswerState(answerSnapshot, userId, likesCount);
}

class OnClickLikeOrUnlikeAnswerState extends State<OnClickLikeOrUnlikeAnswer> {
  final DocumentSnapshot answerSnapshot;
  final String userId;
  int likesCount;
  bool callWait=false;
  List<String> myLikeList;
  LikeFunctionality _likeFunctionality = LikeFunctionality();
  OnClickLikeOrUnlikeAnswerState(
      this.answerSnapshot, this.userId, this.likesCount);
  bool getIsLiked() {
    if (myLikeList.contains(widget.answerSnapshot.documentID)) {
      //      print(
      //          "BookmarkButton()''': getIsBookmarked()''': the provider list is ${myBookmarksList.toString()}");
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    myLikeList = Provider.of<User>(context).likeList;
    Like _toPass = Like();
    _toPass.userId = userId;
    _toPass.answerId = answerSnapshot.documentID;
    return callWait?Container(
          height: 15,
         // width: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Icon(
                  Icons.favorite,
                  size: 15,
                  color: Colors.grey,
                ),
              
              SizedBox(
                width: 6.0,
              ),
              Text(
                '$likesCount',
                style: GoogleFonts.poppins(
                  color: Color(0xFF323131),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ) : getIsLiked()
        ? Container(
            height: 15,
           // width: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // like data will have question id, andwer id, user id
                    this.setState(() {
                      likesCount = likesCount - 1;
                      callWait=true;
                    //  _isLiked = false;
                      print(
                          "QuestionDetailsScreen():''' The new likes Count is $likesCount");
                    });
                    _firestore
                        .collection('likesData')
                        .where('answerId', isEqualTo: answerSnapshot.documentID)
                        .where('userId', isEqualTo: userId)
                        .getDocuments()
                        .then((value) {
                      String _toDelete = value.documents[0].documentID;

                      _firestore
                          .collection('likesData')
                          .document(_toDelete)
                          .delete()
                          .then((value) {
                        _firestore
                            .collection('answerData')
                            .document(answerSnapshot.documentID)
                            .updateData({"likesCount": likesCount}).then(
                                (value) {
                          // add that answer id to mylikes list also
                        setState(() {
                          _likeFunctionality.unLikeQuestion(
                              widget.answerSnapshot.documentID, widget.userId, context);
                              callWait=false;
                          // widget.callSetStateOfQuestionCard();
                        });
                         /* _myLikesAnsBookmarks
                              .deleteLike(answerSnapshot.documentID);*/
                        });
                      });
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    size: 15,
                    color: Colors.lightGreen[900],
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                Text(
                  '$likesCount',
                  style: GoogleFonts.poppins(
                    color: Color(0xFF323131),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 15,
           // width: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.favorite_border,
                    size: 15,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    // like data will have question id, andwer id, user id
                    this.setState(() {
                      likesCount = likesCount + 1;
                      callWait=true;
                     // _isLiked = true;
                      print(
                          "QuestionDetailsScreen():''' The new likes Count is $likesCount");
                    });

                    _firestore.collection('likesData').add(_toPass.toMap()).then(
                        (value) {
                      // now add the updated likes count to answers data
                      _firestore
                          .collection('answerData')
                          .document(answerSnapshot.documentID)
                          .updateData({"likesCount": likesCount}).then((value) {
                        // add that answer id to mylikes list also
                      setState(() {
                        _likeFunctionality.likeQuestion(widget.answerSnapshot.documentID, widget.userId, context
                            );
                            callWait=false;
                        //widget.callSetStateOfQuestionCard();
                      });
                       // _myLikesAnsBookmarks.addLike(answerSnapshot.documentID);
                      });
                    }).catchError((e) => print(
                        "QuestionDetailsScreen()''': error while liking the answer $e"));
                  },
                ),
                SizedBox(
                  width: 6.0,
                ),
                Text(
                  //'${ answerData['likesCount']}_likesCount',
                  '$likesCount',
                  style: GoogleFonts.poppins(
                    color: Color(0xFF323131),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
  }
}
