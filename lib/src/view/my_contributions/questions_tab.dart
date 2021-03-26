import 'package:flutter/material.dart';

// added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

// app dependencies
import 'widgets/my_question_tile.dart';
import 'widgets/no_questions.dart';

class QuestionTab extends StatefulWidget {
  final String userId;
  QuestionTab(this.userId);
  @override
  _QuestionTabState createState() => _QuestionTabState();
}

class _QuestionTabState extends State<QuestionTab> {
//
//  Stream _questionStream = Firestore.instance
//      .collection('questionData')
//      .where('questionByUID', isEqualTo: this.widget.userId)
//      .orderBy('questionTimeStamp', descending: true)
//      .snapshots();
//
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('questionData')
          .where('questionByUID', isEqualTo: this.widget.userId)
          .orderBy('questionTimeStamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Text(
            "Loading",
            style: GoogleFonts.poppins(),
          ));
        }
        if (!snapshot.hasData) {
          return NoQuestions();
        } else {
          return (snapshot.data.documents.isEmpty)
              ? NoQuestions()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot questionsData =
                        snapshot.data.documents[index];
                    // return QuestionsTile(
                    //   questionData: questionsData,
                    // );
                    return MyQuestionTile(questionsData);
//                      QuestionCard(
//                      questionData: questionsData,
//                      size: MediaQuery.of(context).size,
//                    );
                  },
                );
        }
      },
    );
    // return a stream builder of the questions asked by this person
  }
}
