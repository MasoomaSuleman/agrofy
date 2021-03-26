//import 'package:flutter/material.dart';
//
////added dependencies
//import 'package:google_fonts/google_fonts.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:circular_profile_avatar/circular_profile_avatar.dart';
//import 'package:timeago/timeago.dart' as timeago;
//
//// other screens
//import 'QuestionEditScreen.dart';
//import 'package:gst_application/Screens/EditAnswer/EditAnswerScreen.dart';
//import 'package:gst_application/Screens/QuestionDetails/QuestionDetailsScreen.dart';
//import 'package:gst_application/src/view/my_contributions/widgets/my_question_tile.dart';
//import 'package:gst_application/src/view/my_contributions/questions_tab.dart';
//// data models
//import '../Models/Answer.dart';
//
//import 'package:gst_application/src/view/my_contributions/widgets/colored_tabbar.dart';
//
//Stream _questionStream;
//Stream _answerStream;
//Size _size;
//
//class MyContributionsScreen extends StatefulWidget {
//  final String userID;
//  MyContributionsScreen({this.userID});
//
//  @override
//  _MyContributionsScreenState createState() =>
//      _MyContributionsScreenState(userID);
//}
//
//class _MyContributionsScreenState extends State<MyContributionsScreen>
//    with SingleTickerProviderStateMixin {
//  //Tabs Controller
//  TabController _controller;
//  final String uid;
//  _MyContributionsScreenState(this.uid);
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _controller = TabController(length: 2, vsync: this);
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    _controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    _size = MediaQuery.of(context).size;
//    _questionStream = Firestore.instance
//        .collection('questionData')
//        .where('questionByUID', isEqualTo: uid)
//        .orderBy('questionTimeStamp', descending: true)
//        .snapshots();
//    _answerStream = Firestore.instance
//        .collection('answerData')
//        .where('answerByUID', isEqualTo: uid)
//        .orderBy('answerTimeStamp', descending: true)
//        .snapshots();
//    return SafeArea(
//        child: Scaffold(
//      backgroundColor: Color(0xFFF8F8F8),
//      appBar: AppBar(
//        backgroundColor: Colors.lightGreen[900],
//        leading: IconButton(
//          icon: Icon(
//            Icons.arrow_back,
//            color: Colors.white,
//          ),
//          onPressed: () {
//            Navigator.pop(context);
//          },
//        ),
//        centerTitle: true,
//        title: Text(
//          "My Contributions",
//          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
//        ),
//        bottom: ColoredTabBar(
//            Color(0xFFF8F8F8),
//            TabBar(
//              indicatorColor: Colors.red,
//              indicatorWeight: 4.0,
//              controller: _controller,
//              tabs: [
//                Text(
//                  "Questions",
//                  style: GoogleFonts.poppins(color: Colors.black),
//                ),
//                Text(
//                  "Answers",
//                  style: GoogleFonts.poppins(color: Colors.black),
//                )
//              ],
//            )),
//      ),
//      body: TabBarView(
//        controller: _controller,
//        children: [
//          QuestionTab(
//            this.widget.userID,
//          ),
//          AnswersTab()
//        ],
//      ),
//    ));
//  }
//}
//
////class AnswersTab extends StatefulWidget {
////  @override
////  _AnswersTabState createState() => _AnswersTabState();
////}
////
////class _AnswersTabState extends State<AnswersTab> {
////  @override
////  Widget build(BuildContext context) {
////    return Padding(
////      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
////      child: StreamBuilder<QuerySnapshot>(
////        stream: _answerStream,
////        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
////          if (snapshot.hasError) {
////            return Text('Something went wrong');
////          }
////
////          if (snapshot.connectionState == ConnectionState.waiting) {
////            return Text("Loading");
////          }
////          if (!snapshot.hasData) {
////            return Center(
////                child: Text(
////              "No Answers Yet",
////              style: GoogleFonts.poppins(),
////            ));
////          }
////          return (snapshot.data.documents.isEmpty)
////              ? Center(child: Text("No Answers Yet"))
////              : Container(
////                  child: ListView.builder(
////                    shrinkWrap: true,
////                    itemCount: snapshot.data.documents.length,
////                    itemBuilder: (context, index) {
////                      DocumentSnapshot answerData =
////                          snapshot.data.documents[index];
////                      return FutureBuilder(
////                          future: Firestore.instance
////                              .collection('questionData')
////                              .document(answerData['questionUID'])
////                              .get(),
////                          builder: (context, futureSnapshot) {
////                            if (futureSnapshot.hasError) {
////                              return Text('Something went wrong');
////                            }
////
////                            if (futureSnapshot.connectionState ==
////                                ConnectionState.waiting) {
////                              return Text("Loading");
////                            }
////                            return _AnswerTile(
////                                answerData, futureSnapshot.data['replyCount']);
////                          });
////                    },
////                  ),
////                );
////        },
////      ),
////    );
////  }
////}
//
//class _AnswerTile extends StatefulWidget {
//  final DocumentSnapshot answerData;
//  final repliesCount;
//  _AnswerTile(this.answerData, this.repliesCount);
//  @override
//  __AnswerTileState createState() => __AnswerTileState(answerData);
//}
//
//class __AnswerTileState extends State<_AnswerTile> {
//  final DocumentSnapshot answerData;
//  __AnswerTileState(this.answerData);
//  @override
//  Widget build(BuildContext context) {
//    print(widget.repliesCount);
//    //MyAnswersModel toBuild = MyAnswersModel().fromMap(answerData);
//    Answer toBuild = Answer.fromJson(answerData.data);
//    return Column(
//      children: [
//        SizedBox(
//          height: 5,
//        ),
//        Container(
//          width: _size.width * 0.90,
//          height: _size.height * 0.07,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              // right now it is the image of the user but it should be iamge of the question user
//              Padding(
//                  padding: const EdgeInsets.all(4),
//                  child: CircularProfileAvatar(
//                    '${answerData['questionByImageURL']}',
//                    radius: 15,
//                    borderWidth: 0,
////                        initialsText: Text("H"),
//                    backgroundColor: Colors.grey,
//                    elevation: 0,
//                  )),
//              Padding(
//                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Text(
//                      '${toBuild.questionByName}',
//                      style: GoogleFonts.poppins(
//                          color: Colors.black,
//                          fontSize: 12,
//                          fontWeight: FontWeight.w400),
//                    ),
//                    Text(
//                      '${toBuild.questionByProfession}',
//                      style: GoogleFonts.poppins(
//                          color: Colors.grey,
//                          fontSize: 10,
//                          fontWeight: FontWeight.w400),
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//        ListTile(
//          //contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
//          contentPadding: EdgeInsets.fromLTRB(14, 4, 14, 4),
//          dense: true,
//          title: Text(
//            "${toBuild.questionText}",
//            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//            maxLines: 3,
//            overflow: TextOverflow.ellipsis,
//          ),
//          trailing: Container(
//            width: 40.0,
//            height: 40.0,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(5.0),
//              color: Color(0xFFF3F3F3),
//            ),
//            child: IconButton(
//              color: Colors.black,
//              iconSize: 16.0,
//              icon: Icon(
//                Icons.text_format,
//              ),
//              onPressed: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => EditAnswerScreen(answerData)));
//              },
//            ),
//          ),
//        ),
//        Padding(
//          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              SizedBox(
//                height: 10,
//              ),
//              Text(
//                "${toBuild.answerText}",
//                style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
//                maxLines: 4,
//                overflow: TextOverflow.ellipsis,
//              ),
//              Padding(
//                padding: const EdgeInsets.symmetric(vertical: 6.0),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Expanded(
//                      flex: 2,
//                      child: Text(
//                        "${timeago.format(DateTime.parse(toBuild.answerTimeStamp))}",
//                        style: GoogleFonts.poppins(
//                            color: Colors.black,
//                            fontSize: 10.0,
//                            fontWeight: FontWeight.w400),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(4.0),
//                      child: Text(
//                        "${widget.repliesCount - 1} more replies",
//                        style: GoogleFonts.poppins(
//                            color: Colors.black,
//                            fontSize: 10.0,
//                            fontWeight: FontWeight.w400),
//                      ),
//                    )
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//        SizedBox(
//          height: 5,
//        ),
//        Divider(
//          height: 0,
//        ),
//      ],
//    );
//  }
//}
//
////
////class QuestionsTab extends StatefulWidget {
////  final String uid;
////
////  QuestionsTab({this.uid});
////  @override
////  _QuestionsTabState createState() => _QuestionsTabState();
////}
////
////class _QuestionsTabState extends State<QuestionsTab> {
////  @override
////  void initState() {
////    // TODO: implement initState
////    super.initState();
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    return StreamBuilder<QuerySnapshot>(
////      stream: _questionStream,
////      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
////        if (snapshot.hasError) {
////          return Center(child: Text('Something went wrong'));
////        }
////
////        if (snapshot.connectionState == ConnectionState.waiting) {
////          return Center(child: Text("Loading"));
////        }
////        if (!snapshot.hasData) {
////          return Center(child: Text("No Questions Yet"));
////        } else {
////          return (snapshot.data.documents.isEmpty)
////              ? Center(child: Text("No Questions Yet"))
////              : ListView.builder(
////                  shrinkWrap: true,
////                  itemCount: snapshot.data.documents.length,
////                  itemBuilder: (context, index) {
////                    DocumentSnapshot questionsData =
////                        snapshot.data.documents[index];
////                    // return QuestionsTile(
////                    //   questionData: questionsData,
////                    // );
////                    return MyQuestionTile(questionsData);
//////                      QuestionCard(
//////                      questionData: questionsData,
//////                      size: MediaQuery.of(context).size,
//////                    );
////                  },
////                );
////        }
////      },
////    );
////    // return a stream builder of the questions asked by this person
////  }
////}
//
////class ColoredTabBar extends Container implements PreferredSize {
////  ColoredTabBar(this.color, this.tabBar);
////  final Color color;
////  final TabBar tabBar;
////
////  @override
////  // TODO: implement preferredSize
////  Size get preferredSize => tabBar.preferredSize;
////  @override
////  Widget build(BuildContext context) {
////    // TODO: implement build
////    return Container(
////      height: 50.0,
////      color: color,
////      child: tabBar,
////    );
////  }
////}
//
////class QuestionsTile extends StatefulWidget {
////  final DocumentSnapshot questionData;
////  QuestionsTile({this.questionData});
//////  final int replyCount;
//////  final String qID;
//////  final Question2 question;
////
////  @override
////  _QuestionsTileState createState() => _QuestionsTileState(questionData);
////}
////
////class _QuestionsTileState extends State<QuestionsTile> {
////  final DocumentSnapshot questionData;
////  _QuestionsTileState(this.questionData);
////  @override
////  Widget build(BuildContext context) {
////    return Column(
////      children: [
////        ListTile(
////          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
////          dense: true,
////          title: Text(
////            "${questionData["questionText"]}",
////            style: GoogleFonts.poppins(),
////            maxLines: 3,
////            overflow: TextOverflow.ellipsis,
////          ),
////          onTap: () {
////            // go to question details page
////            Navigator.push(
////                context,
////                MaterialPageRoute(
////                    builder: (context) =>
////                        QuestionDetailsScreen(questionData: questionData)));
////          },
////          trailing: questionData['isAnswered']
////              ? Container(
////                  width: 40.0,
////                  height: 40.0,
////                  decoration: BoxDecoration(
////                    borderRadius: BorderRadius.circular(5.0),
////                    color: Color(0xFFF3F3F3),
////                  ),
////                  child: Center(
////                      child: Text(
////                    "Cannot Edit",
////                    style: GoogleFonts.poppins(fontSize: 8, color: Colors.red),
////                    textAlign: TextAlign.center,
////                  )))
////              : Container(
////                  width: 40.0,
////                  height: 40.0,
////                  decoration: BoxDecoration(
////                    borderRadius: BorderRadius.circular(5.0),
////                    color: Color(0xFFF3F3F3),
////                  ),
////                  child: IconButton(
////                    color: Colors.black,
////                    iconSize: 20.0,
////                    icon: Icon(Icons.edit),
////                    onPressed: () {
////                      //Navigate to Question Edit Button pass the question class here
////                      Navigator.push(
////                          context,
////                          MaterialPageRoute(
////                              builder: (context) => QuestionEditScreen(
////                                    questionData: questionData,
////                                  )));
////                    },
////                  ),
////                ),
////          subtitle: Padding(
////            padding: const EdgeInsets.symmetric(vertical: 6.0),
////            child: Row(
////              mainAxisAlignment: MainAxisAlignment.spaceBetween,
////              children: [
////                Text(
////                  "${timeago.format(DateTime.parse(questionData['questionTimeStamp']))}",
////                  style:
////                      GoogleFonts.poppins(color: Colors.grey, fontSize: 10.0),
////                ),
////                Text(
////                  "${questionData['replyCount']} replies",
////                  style:
////                      GoogleFonts.poppins(color: Colors.grey, fontSize: 10.0),
////                )
////              ],
////            ),
////          ),
////        ),
////        Divider(
////          height: 0,
////        )
////      ],
////    );
////  }
////}
