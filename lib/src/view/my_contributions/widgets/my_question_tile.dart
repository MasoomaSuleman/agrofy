import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/view/my_contributions/widgets/edit_question_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyQuestionTile extends StatelessWidget {
  final DocumentSnapshot questionSnapshot;
  MyQuestionTile(this.questionSnapshot);
  @override
  Widget build(BuildContext context) {
    //MyAnswersModel toBuild = MyAnswersModel().fromMap(answerData);
    // Answer toBuild = Answer.fromJson(answerData.data);
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
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
        ListTile(
          //contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
          contentPadding: EdgeInsets.fromLTRB(14, 4, 14, 4),
          dense: true,
          title: Text(
            "${questionSnapshot.data['questionText']}",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Color(0xFFF3F3F3),
            ),
            child: (questionSnapshot.data['replyCount'] != 0)
                ? Container()
                : IconButton(
                    color: Colors.black,
                    iconSize: 20.0,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // edit question
                    Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) =>EditQuestionScreen(questionSnapshot:questionSnapshot,)));
                    },
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${timeago.format(DateTime.parse(questionSnapshot.data['questionTimeStamp']))}",
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10.0),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                "${(questionSnapshot.data['replyCount'])} replies",
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10.0),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }
}
