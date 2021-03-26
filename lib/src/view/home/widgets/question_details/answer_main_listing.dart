import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kisaanCorner/src/view/home/widgets/question_details/answer_widget.dart';

class AnswerMainListing extends StatefulWidget {
  final DocumentSnapshot questionData;
  final bool relevant;
  final bool latest;
  AnswerMainListing({this.questionData, this.relevant, this.latest});
  @override
  _AnswerMainListingState createState() => _AnswerMainListingState();
}

class _AnswerMainListingState extends State<AnswerMainListing> {
  Stream _answerStream;
  Stream getStream() {
    if (widget.latest && !widget.relevant) {
      return Firestore.instance
          .collection("answerData")
          .where('questionUID', isEqualTo: widget.questionData.documentID)
          .orderBy('answerTimeStamp', descending: true)
          .snapshots();
    } else if (!widget.latest && widget.relevant) {
      return Firestore.instance
          .collection("answerData")
          .where('questionUID', isEqualTo: widget.questionData.documentID)
          .orderBy('likesCount', descending: true)
          .snapshots();
    } else if (widget.latest && widget.relevant) {
      return Firestore.instance
          .collection("answerData")
          .where('questionUID', isEqualTo: widget.questionData.documentID)
          .orderBy('likesCount', descending: true)
          .orderBy('answerTimeStamp', descending: true)
          .snapshots();
    } else {
      return Firestore.instance
          .collection("answerData")
          .where('questionUID', isEqualTo: widget.questionData.documentID)
          .orderBy('answerTimeStamp', descending: true)
          .snapshots();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getStream();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.relevant);
    print(widget.latest);
    return StreamBuilder<QuerySnapshot>(
      stream: getStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Loading"));
        }
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasData) {
          return Text("Be the first person to answer");
        }
        return (snapshot.data.documents.length == 0)
            ? Center(child: Text("No answers Yet"))
            : Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot answerData =
                        snapshot.data.documents[index];
                    print(answerData.data);
                    return AnswerWidget(answerData, index);
                  },
                ),
              );
      },
    );
  }
}
