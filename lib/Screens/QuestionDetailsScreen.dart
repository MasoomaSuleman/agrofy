import 'package:flutter/material.dart';

// added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

// app dependencies
import '../provider/user_details.dart';
import '../Models/LikeDataModel.dart';
import '../provider/MyLikesAndBookmarks.dart';
import 'package:kisaanCorner/Screens/AddAnswer/AddAnswerScreen.dart';

Size _size;
List<String> _myLikedAnswers = [];
MyLikesAnsBookmarks _myLikesAnsBookmarks;

Firestore _firestore = Firestore.instance;

class QuestionDetailsScreen extends StatefulWidget {
  final DocumentSnapshot questionData;
  // List<String> myLikedAnswers;
  QuestionDetailsScreen(this.questionData);
  @override
  _QuestionDetailsScreenState createState() =>
      _QuestionDetailsScreenState(questionData);
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  final DocumentSnapshot questionData;
  //List<String> myLikedAnswers;
  _QuestionDetailsScreenState(this.questionData);
  Stream _answerStream;

  void getStream() async {
    _answerStream = Firestore.instance
        .collection("answerData")
        .where('questionUID', isEqualTo: questionData.documentID)
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
    UserDetails userDetails = Provider.of<UserDetails>(context);
    _myLikesAnsBookmarks = Provider.of<MyLikesAnsBookmarks>(context);
    _myLikedAnswers = _myLikesAnsBookmarks.myLikedAnswers;
    //getAllMyLikedAnswersString(userDetails.user_id);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(
              children: [
                questionDetailsWidget(),
                answersWidget(),
              ],
            ))));
  }

  Widget questionDetailsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          width: _size.width,
          height: _size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircularProfileAvatar(
                '${questionData.data['questionByImageURL']}',
                radius: 20.0,
                backgroundColor: Colors.grey,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.0),
                  Text(
                    '${questionData.data['questionByName']}',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    '${questionData.data['questionByProfession']}',
                    style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                width: 2.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  '- Recommended for you',
                  style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 8,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '${questionData.data['questionText']}',
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600),
        ),
        questionData['containsImage'] ? questionImagesWidget() : Container(),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 40.0,
          child: TextField(
            showCursor: true,
//          readOnly: true,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddAnswerScreen(
                        questionData,
                      )));
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.translate,
                  size: 15,
                ),
                suffixIcon: Icon(Icons.filter, size: 15),
                disabledBorder: InputBorder.none,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none),
                filled: true,
                hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                hintText: "Share you answer...",
                fillColor: new Color(0xffFFFFFF)),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Container(
                  width: 80.0,
                  height: 30.0,
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      '${questionData["replyCount"]} replies',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            ),
            Expanded(child: Container())
          ],
        ),
        SizedBox(
          height: 5.0,
        )
      ],
    );
  }

  Widget questionImagesWidget() {
    // traverse throufght the array of images
    List<dynamic> _questionImagesList = [];
    _questionImagesList = questionData.data['questionImages'];
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
        width: _size.width,
        height: _size.height * 0.20,
        child: Center(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _questionImagesList.length,
              itemBuilder: (context, index) {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: CachedNetworkImage(
                    imageUrl: _questionImagesList[index],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ));
              }),
        ),
      ),
    );
  }

  Widget answersWidget() {
    // var _likesCount;
    return StreamBuilder<QuerySnapshot>(
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
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot answerData = snapshot.data.documents[index];
              return _AnswerWidget(answerData);
            },
          ),
        );
      },
    );
  }
}

class _AnswerWidget extends StatefulWidget {
  final DocumentSnapshot answerSnapshot;
  _AnswerWidget(this.answerSnapshot);
  @override
  __AnswerWidgetState createState() => __AnswerWidgetState(answerSnapshot);
}

class __AnswerWidgetState extends State<_AnswerWidget> {
  final DocumentSnapshot answerData;
  __AnswerWidgetState(this.answerData);

  bool _isExpandedAnswer = false;
  bool _isLikedAnswer = false;
  int likesCount;

  @override
  Widget build(BuildContext context) {
    String _userID = Provider.of<UserDetails>(context).user_id;
    likesCount = answerData['likesCount'];

    // before building each qnswer check if it is liked by this user or not
    if (_myLikedAnswers?.isNotEmpty ?? true) {
      if (_myLikedAnswers.contains(answerData.documentID)) {
        print(
            "QuestionDetailsScreen()''': The list of my bookmarks is contains ${answerData.documentID}");
        _isLikedAnswer = true;
      }
    } else {
      print("QuestionDetailsScreen()''': The list of my likes is empty");
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      width: _size.width,
      child: Column(
        children: [
          Container(
            width: _size.width,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircularProfileAvatar(
                  '${answerData['answerByImageURL']}',
                  radius: 20.0,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.0),
                    Text(
                      '${answerData['answerByName']}',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      '${answerData['answerByProfession']}',
                      style: GoogleFonts.poppins(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  width: 2.0,
                ),
                Expanded(child: Container()),
                _OnClickLikeOrUnlikeAnswer(
                  answerSnapshot: answerData,
                  userId: _userID,
                  likesCount: answerData['likesCount'],
                  isLiked: _isLikedAnswer,
                ),
              ],
            ),
          ),
          (answerData["answerImageURL"] != null)
              ? Container(
                  // show image of the answer here
                  width: _size.width,
                  height: _size.height * 0.2,
                  child: Image.network(
                    '${answerData["answerImageURL"]}',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, url, error) => Icon(Icons.error),
                  ),
                )
              : Container(),
          _isExpandedAnswer
              ? Container(
                  width: _size.width,
                  child: Text(
                    "${answerData['answerText']}",
                    style: GoogleFonts.poppins(fontSize: 12.0),
                    overflow: TextOverflow.fade,
                  ),
                )
              : Container(
                  width: _size.width,
                  child: AutoSizeText(
                    answerData['answerText'],
                    maxLines: 10,
                    style: GoogleFonts.poppins(fontSize: 12.0),
                    minFontSize: 10,
                    overflowReplacement: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${answerData['answerText']}",
                          style: GoogleFonts.poppins(fontSize: 12.0),
                          maxLines: 10,
                          overflow: TextOverflow.fade,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              this.setState(() {
                                _isExpandedAnswer = true;
                              });
                            },
                            child: Text(
                              "Read Full Answer",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
          Divider(
            height: 10.0,
            thickness: 1.0,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
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
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 2.0,
              ),
              Text(
                '$likesCount',
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    size: 20,
                    color: Color(0xFFE16060),
                  ),
                  onPressed: () {
                    // like data will have question id, andwer id, user id
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
                            .updateData({"likesCount": likesCount - 1}).then(
                                (value) {
                          // add that answer id to mylikes list also

                          _myLikesAnsBookmarks
                              .deleteLike(answerSnapshot.documentID);
                          this.setState(() {
                            likesCount = likesCount - 1;
                            _isLiked = false;
                            print(
                                "QuestionDetailsScreen():''' The new likes Count is $likesCount");
                          });
                        });
                      });
                    });
                  }),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 2.0,
              ),
              Text(
                //'${ answerData['likesCount']}_likesCount',
                '$likesCount',
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // like data will have question id, andwer id, user id

                    _firestore.collection('likesData').add(_toPass.toMap()).then(
                        (value) {
                      // now add the updated likes count to answers data
                      _firestore
                          .collection('answerData')
                          .document(answerSnapshot.documentID)
                          .updateData({"likesCount": likesCount + 1}).then(
                              (value) {
                        // add that answer id to mylikes list also
                        _myLikesAnsBookmarks.addLike(answerSnapshot.documentID);
                        this.setState(() {
                          likesCount = likesCount + 1;
                          _isLiked = true;
                          print(
                              "QuestionDetailsScreen():''' The new likes Count is $likesCount");
                        });
                      });
                    }).catchError((e) => print(
                        "QuestionDetailsScreen()''': error while liking the answer $e"));
                  }),
            ],
          );
  }
}
