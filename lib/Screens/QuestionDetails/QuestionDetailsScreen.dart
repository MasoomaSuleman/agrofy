import 'package:flutter/material.dart';

// addded dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;

// app dependencies
import 'ui_components/QuestionDetails.dart';
import 'package:kisaanCorner/provider/user_details.dart';
import 'package:kisaanCorner/Models/LikeDataModel.dart';
import 'package:kisaanCorner/provider/MyLikesAndBookmarks.dart';
//import 'package:kisaanCorner/Screens/AddAnswer/AddAnswerScreen.dart';
import 'ui_components/FullScreenAnswerImageView.dart';

Size _size;
List<String> _myLikedAnswers = [];
MyLikesAnsBookmarks _myLikesAnsBookmarks = MyLikesAnsBookmarks();

Firestore _firestore = Firestore.instance;

class QuestionDetailsScreen extends StatefulWidget {
  final DocumentSnapshot questionData;
  final Function callSetStateHomeScreen;
  QuestionDetailsScreen({this.questionData, this.callSetStateHomeScreen});
  @override
  _QuestionDetailsScreenState createState() =>
      _QuestionDetailsScreenState(questionData);
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  final DocumentSnapshot questionData;
  _QuestionDetailsScreenState(this.questionData);
  Stream _answerStream;
  void getStream() async {
    _answerStream = Firestore.instance
        .collection("answerData")
        .where('questionUID', isEqualTo: questionData.documentID)
        .orderBy('answerTimeStamp', descending: true)
        .snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStream();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff8f8f8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              // Navigator.of(context).pop(true);
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                QuestionDetails(
                    questionData, _size, this.widget.callSetStateHomeScreen),
                StreamBuilder<QuerySnapshot>(
                  stream: _answerStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        !snapshot.hasData) {
                      return Text("Be the first person to answer");
                    }
                    return (snapshot.data.documents.length == 0)
                        ? Text("No answers Yet")
                        : Container(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot answerData =
                                    snapshot.data.documents[index];
                                return _AnswerWidget(answerData);
                              },
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswerWidget extends StatefulWidget {
  final DocumentSnapshot answerData;
  _AnswerWidget(this.answerData);
  @override
  __AnswerWidgetState createState() => __AnswerWidgetState();
}

class __AnswerWidgetState extends State<_AnswerWidget> {
  //final DocumentSnapshot answerData;
  //__AnswerWidgetState(this.answerData);

//  final Shader linearGradient = LinearGradient(
//          colors: <Color>[Colors.black, Colors.red],
//          begin: Alignment.topCenter,
//          end: Alignment.bottomCenter)
//      .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  bool _isExpandedAnswer = false;
  bool _isLikedAnswer = false;
  int likesCount;
  String _userID;

  @override
  void didUpdateWidget(_AnswerWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _userID = Provider.of<UserDetails>(context).user_id;
    likesCount = this.widget.answerData['likesCount'];
    _myLikesAnsBookmarks = Provider.of<MyLikesAnsBookmarks>(context);
    _myLikedAnswers = _myLikesAnsBookmarks.myLikedAnswers;

    // before building each qnswer check if it is liked by this user or not
    if (_myLikedAnswers?.isNotEmpty ?? true) {
      if (_myLikedAnswers.contains(this.widget.answerData.documentID)) {
        print(
            "QuestionDetailsScreen()''': The list of my bookmarks is contains ${this.widget.answerData.documentID}");
        _isLikedAnswer = true;
      }
    } else {
      print("QuestionDetailsScreen()''': The list of my likes is empty");
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      width: _size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _size.width,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProfileAvatar(
                  '${this.widget.answerData['answerByImageURL']}',
                  radius: 12.0,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '${this.widget.answerData['answerByName']}',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: "  - " +
                            '${timeago.format(DateTime.parse(this.widget.answerData['answerTimeStamp']))}',
                        style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      )
                    ])),
                    Text(
                      '${this.widget.answerData['answerByProfession']}',
                      style: GoogleFonts.poppins(
                          color: Colors.black54,
                          fontSize: 8,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  width: 2.0,
                ),
                Expanded(child: Container()),
//                LikeButton(
//                  size: 20,
//                  isLiked: _isLikedAnswer,
//                  likeBuilder: (_isLikedAnswer) {
//                    return Icon(
//                      Icons.thumb_up,
//                      color: _isLikedAnswer ? Color(0xFFE16060) : Colors.grey,
//                      size: 20.0,
//                    );
//                  },
//                  likeCount: answerData['likesCount'],
//                  onTap: onTapLaike,
//                ),
                _OnClickLikeOrUnlikeAnswer(
                  answerSnapshot: this.widget.answerData,
                  userId: _userID,
                  likesCount: this.widget.answerData['likesCount'],
                  isLiked: _isLikedAnswer,
                ),
              ],
            ),
          ),
          ('${this.widget.answerData['answerText']}'.length < 100)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${this.widget.answerData['answerText']}',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    (this.widget.answerData["answerImageURL"] != null)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenAnswerImageView(this
                                              .widget
                                              .answerData["answerImageURL"])));
                            },
                            child: Hero(
                              tag:
                                  '${this.widget.answerData["answerImageURL"]}',
                              child: Container(
                                // show image of the answer here
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                width: _size.width,
                                height: _size.height * 0.2,
                                child: Image.network(
                                  '${this.widget.answerData["answerImageURL"]}',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )
              : RichText(
                  text: TextSpan(children: [
                  TextSpan(
                    text: '${this.widget.answerData['answerText']}'
                        .substring(0, 100),
                    style: GoogleFonts.poppins(
                        fontSize: 12.0, color: Colors.black),
                  ),
                  WidgetSpan(
                    child: (this.widget.answerData["answerImageURL"] != null)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenAnswerImageView(this
                                              .widget
                                              .answerData["answerImageURL"])));
                            },
                            child: Hero(
                              tag:
                                  '${this.widget.answerData["answerImageURL"]}',
                              child: Container(
                                // show image of the answer here
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                width: _size.width,
                                height: _size.height * 0.2,
                                child: Image.network(
                                  '${this.widget.answerData["answerImageURL"]}',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  WidgetSpan(
                    child: _isExpandedAnswer
                        ? Container(
                            width: _size.width,
                            child: Text(
                              "${this.widget.answerData['answerText']}"
                                  .substring(100),
                              style: GoogleFonts.poppins(fontSize: 12.0),
                              overflow: TextOverflow.fade,
                            ),
                          )
                        : Container(
                            width: _size.width,
                            child: AutoSizeText(
                              '${this.widget.answerData['answerText']}'
                                  .substring(100),
                              maxLines: 10,
                              style: GoogleFonts.poppins(fontSize: 12.0),
                              minFontSize: 10,
                              overflowReplacement: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      '${this.widget.answerData['answerText']}'
                                          .substring(100),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.0,
                                      ),
                                      maxLines: 10,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          this.setState(() {
                                            _isExpandedAnswer = true;
                                          });
                                        },
                                        child: Container(
                                          width: 105.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "continue reading ",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 8,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1,
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 8,
                                                  color: Colors.black,
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )),
                  ),
//                TextSpan(
//                  text: '${answerData['answerText']}'.substring(31),
//                  style: GoogleFonts.poppins(
//                      color: Colors.grey,
//                      fontSize: 10,
//                      fontWeight: FontWeight.w400),
//                )
                ])),
          Divider(
            height: 20.0,
            thickness: 1,
            color: Color(0x40707070),
          )
        ],
      ),
    );
  }

//  Future<bool> onTapLaike(_isLikedAnswer) async {
//    bool _like = _isLikedAnswer;
//    Like _toPass = Like();
//    _toPass.userId = _userID;
//    _toPass.answerId = answerData.documentID;
//    (_isLikedAnswer)
//        ? _firestore
//            .collection('likesData')
//            .where('answerId', isEqualTo: answerData.documentID)
//            .where('userId', isEqualTo: _userID)
//            .getDocuments()
//            .then((value) {
//            String _toDelete = value.documents[0].documentID;
//
//            _firestore
//                .collection('likesData')
//                .document(_toDelete)
//                .delete()
//                .then((value) {
//              _firestore
//                  .collection('answerData')
//                  .document(answerData.documentID)
//                  .updateData({"likesCount": likesCount - 1}).then((value) {
//                // add that answer id to mylikes list also
//
//                _myLikesAnsBookmarks.deleteLike(answerData.documentID);
//                print(
//                    "QuestionDetailsScreen():''' The new likes Count is $likesCount");
//              });
//            });
//          })
//        : _firestore.collection('likesData').add(_toPass.toMap()).then((value) {
//            // now add the updated likes count to answers data
//            _firestore
//                .collection('answerData')
//                .document(answerData.documentID)
//                .updateData({"likesCount": likesCount + 1}).then((value) {
//              // add that answer id to mylikes list also
//              _myLikesAnsBookmarks.addLike(answerData.documentID);
//            });
//          }).catchError((e) => print(
//            "QuestionDetailsScreen()''': error while liking the answer $e"));
//    return !_like;
//  }
}

class _OnClickLikeOrUnlikeAnswer extends StatefulWidget {
  final DocumentSnapshot answerSnapshot;
  final String userId;
  final int likesCount;
  final bool isLiked;
  _OnClickLikeOrUnlikeAnswer(
      {this.answerSnapshot, this.userId, this.likesCount, this.isLiked});
  @override
  _OnClickLikeOrUnlikeAnswerState createState() =>
      _OnClickLikeOrUnlikeAnswerState(
          answerSnapshot, userId, likesCount, isLiked);
}

class _OnClickLikeOrUnlikeAnswerState
    extends State<_OnClickLikeOrUnlikeAnswer> {
  final DocumentSnapshot answerSnapshot;
  final String userId;
  int likesCount;
  bool _isLiked;
  _OnClickLikeOrUnlikeAnswerState(
      this.answerSnapshot, this.userId, this.likesCount, this._isLiked);
  @override
  Widget build(BuildContext context) {
    Like _toPass = Like();
    _toPass.userId = userId;
    _toPass.answerId = answerSnapshot.documentID;
    return _isLiked
        ? Container(
            height: 15,
            width: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // like data will have question id, andwer id, user id
                    this.setState(() {
                      likesCount = likesCount - 1;
                      _isLiked = false;
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

                          _myLikesAnsBookmarks
                              .deleteLike(answerSnapshot.documentID);
                        });
                      });
                    });
                  },
                  child: Icon(
                    Icons.thumb_up,
                    size: 15,
                    color: Color(0xFFE16060),
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
            width: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.thumb_up,
                    size: 15,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    // like data will have question id, andwer id, user id
                    this.setState(() {
                      likesCount = likesCount + 1;
                      _isLiked = true;
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
                        _myLikesAnsBookmarks.addLike(answerSnapshot.documentID);
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
