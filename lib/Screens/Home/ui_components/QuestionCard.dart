import 'package:flutter/material.dart';

//added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

//app dependencies
import 'Images.dart';
import 'package:kisaanCorner/provider/user_details.dart';
import 'package:kisaanCorner/Screens/otherUserProfile.dart';
import 'package:kisaanCorner/Screens/AddAnswer/AddAnswerScreen.dart';
import 'package:kisaanCorner/Screens/QuestionDetails/QuestionDetailsScreen.dart';

class QuestionCard extends StatefulWidget {
  final DocumentSnapshot questionData;
  final Size size;
  final Function callsetStateHome;

  QuestionCard({this.questionData, this.size, this.callsetStateHome});
  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
//  final DocumentSnapshot questionData;
//  final Size _size;
//  _QuestionCardState(this.questionData, this._size);
  int maxLines = 4;
  void bookmarkQuestion(DocumentSnapshot questionData) async {
    print(
        "--------------------------Question BookMarked------------------------------");
    await Firestore.instance
        .collection("questionData")
        .document(questionData.documentID)
        .updateData(
      {"bookmarks": myBookMarkedQ, "isQBookmarked": true},
    );
  }

  void unbookmarkQuestion(DocumentSnapshot questionData, String uid) async {
    // setState(() {});
    print(
        "------------------------Question unBookMarked---------------------------------");
    await Firestore.instance
        .collection("questionData")
        .document(questionData.documentID)
        .updateData(
      // {"bookmarks": myBookMarkedQ, "isQBookmarked": false},
      {
        "bookmarks": FieldValue.arrayRemove([uid])
      },
    );
  }

  var myBookMarkedQ;

  bool isQuestionBookmarked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBookMarkedQ = widget.questionData['bookmarks'] ?? [];
  }

  @override
  void didUpdateWidget(QuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<UserDetails>(context).user_id;
    // UserDetails userDetails = Provider.of<UserDetails>(context);
    (widget.questionData.data['questionImages'] != null)
        ? maxLines = 2
        : maxLines = 4;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 2, 20, 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GestureDetector(
          onTap: () {
            pushNewScreen(
              context,
              screen: QuestionDetailsScreen(
                questionData: widget.questionData,
                callSetStateHomeScreen: this.widget.callsetStateHome,
              ),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: OtherUserProfile(
                                  uid: uid,
                                  otherUserUid:
                                      widget.questionData['questionByUID'],
                                ),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircularProfileAvatar(
                                  '${widget.questionData['questionByImageURL'] ?? ''}',
                                  radius: 15.0,
                                  borderWidth: 0,
                                  elevation: 0,
                                  backgroundColor: Colors.grey,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '${widget.questionData.data['questionByName']}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: "  - " +
                                            '${timeago.format(DateTime.parse(widget.questionData['questionTimeStamp']))}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ])),
                                    Text(
                                      '${widget.questionData.data['questionByProfession']}',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black54,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: widget.size.width - 112,
                            child: Text(
                              '${widget.questionData['questionText']}',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xfff3f3f3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // unbookmarkQuestion(questionData, uid);

                                    if (myBookMarkedQ.contains(uid)) {
                                      // print('')
                                      myBookMarkedQ.remove(uid);
                                      unbookmarkQuestion(
                                          widget.questionData, uid);
                                      isQuestionBookmarked = false;
                                      print(
                                          "inside if:::::::::::::::::::::::$isQuestionBookmarked::::::::::::");
                                      // Icon(
                                      //   Icons.bookmark,
                                      //   size: 20,
                                      // );
                                    } else {
                                      myBookMarkedQ.add(uid);
                                      bookmarkQuestion(widget.questionData);
                                      isQuestionBookmarked = true;
                                      print(
                                          ":::::::::::::::::::::::$isQuestionBookmarked::::::::::::");

                                      // Icon(
                                      //   Icons.bookmark_border,
                                      //   size: 20,
                                      // );
                                    }

                                    print(
                                        "=========Bookmarked value is: $isQuestionBookmarked=========");
                                  });
                                },
                                child: myBookMarkedQ.contains(uid)
                                    ? Center(
                                        child: Icon(
                                          Icons.bookmark,
                                          size: 20,
                                          color: Color(0xff707070),
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                        Icons.bookmark_border,
                                        size: 20.0,
                                        color: Color(0xff707070),
                                      )),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              child: GestureDetector(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: AddAnswerScreen(
                                      widget.questionData,
                                    ),
                                    withNavBar:
                                        false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Color(0xfff3f3f3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  child: Center(
                                      child: Icon(
                                    Icons.text_format,
                                    size: 20.0,
                                    color: Color(0xff707070),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
//              Container(
//                width: _size.width - 100,
//                child: Text(
//                  '${questionData['questionText']}',
//                  style: GoogleFonts.poppins(
//                      fontWeight: FontWeight.w500,
//                      fontSize: 14,
//                      color: Colors.black),
//                  maxLines: 3,
//                  overflow: TextOverflow.ellipsis,
//                ),
//              ),
                SizedBox(
                  height: 4,
                ),
                Images(widget.questionData.data['questionImages'], widget.size),
                SizedBox(
                  height: 4,
                ),
                (widget.questionData['isAnswered'])
                    ? Container(
                        width: widget.size.width - 60,
                        child: Text(
                          '${widget.questionData['latestAnswerText']}',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.black),
                          maxLines: maxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
