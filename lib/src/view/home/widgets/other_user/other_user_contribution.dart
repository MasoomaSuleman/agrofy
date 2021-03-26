import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kisaanCorner/src/view/home/widgets/questions_card/questions_card.dart';
class OtherUserContribution extends StatelessWidget {
  final stream;
  OtherUserContribution({
   @required this.stream,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (!snapshot.hasData) {
          return Text("No Posts by this user");
        }
        return (snapshot.data.documents.isEmpty)
            ? Center(child: Text("No Posts by this user"))
            : Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {

                    DocumentSnapshot questionsData =
                        snapshot.data.documents[index];
                        print(questionsData.data);
                    print(
                        "OtherUserProfile()''': Calling questions tile with ${snapshot.data.documents[index].documentID}");
                    return QuestionsCard(
                    questionData: questionsData);
                  },
                ),
              );
      },
    );
  }
}