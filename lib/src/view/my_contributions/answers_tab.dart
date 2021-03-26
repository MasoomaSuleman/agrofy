import 'package:flutter/material.dart';

// added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

// app dependencies
import 'widgets/answer_tile.dart';
import 'widgets/no_answers.dart';

class AnswersTab extends StatefulWidget {
  final String userId;
  AnswersTab(this.userId);
  @override
  _AnswersTabState createState() => _AnswersTabState();
}

class _AnswersTabState extends State<AnswersTab> {
//  Stream  _answerStream = Firestore.instance
//      .collection('answerData')
//      .where('answerByUID', isEqualTo: uid)
//      .orderBy('answerTimeStamp', descending: true)
//      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('answerData')
            .where('answerByUID', isEqualTo: widget.userId)
            .orderBy('answerTimeStamp', descending: true)
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
            return NoAnswers();
          }
          return (snapshot.data.documents.isEmpty)
              ? NoAnswers()
              : Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot answerData =
                          snapshot.data.documents[index];
                      return AnswerTile(answerData);
                    },
                  ),
                );
        },
      ),
    );
  }
}
