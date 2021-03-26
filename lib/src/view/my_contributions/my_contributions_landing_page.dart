import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kisaanCorner/src/view/my_contributions/answers_tab.dart';
import 'widgets/colored_tabbar.dart';
import 'questions_tab.dart';

class MyContributionsLandingPage extends StatefulWidget {
  final String userId;
  MyContributionsLandingPage(this.userId);
  @override
  _MyContributionsLandingPageState createState() =>
      _MyContributionsLandingPageState();
}

class _MyContributionsLandingPageState extends State<MyContributionsLandingPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
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
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "My Contributions",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        ),
        bottom: ColoredTabBar(
            Color(0xFFF8F8F8),
            TabBar(
              indicatorColor: Colors.red,
              indicatorWeight: 4.0,
              controller: _controller,
              tabs: [
                Text(
                  "Questions",
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
                Text(
                  "Answers",
                  style: GoogleFonts.poppins(color: Colors.black),
                )
              ],
            )),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          QuestionTab(
            this.widget.userId,
          ),
          AnswersTab(this.widget.userId)
        ],
      ),
    ));
  }
}
