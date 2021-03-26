import 'package:flutter/material.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/other_user_landing_page.dart';
import 'package:timeago/timeago.dart' as timeago;

// app dependencies
import '../user_profile_image.dart';
import 'question_images.dart';
import 'question_files.dart';
import 'bookmark_button.dart';
import 'answers_count.dart';
import 'package:kisaanCorner/src/view/home/widgets/question_details/question_details_landing_page.dart';
import 'package:kisaanCorner/src/model/question/category_model.dart';
import 'package:kisaanCorner/src/constants.dart';

// temporary
import 'package:provider/provider.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';

class QuestionsCard extends StatefulWidget {
  final DocumentSnapshot questionData;

  QuestionsCard({this.questionData});

  @override
  _QuestionsCardState createState() => _QuestionsCardState();
}

class _QuestionsCardState extends State<QuestionsCard> {
  // functions to display details

  String getNameToDisplay(String name) {
    if (name.length >= 15) {
      // split the name by spaces
      List nameTemp = name.split(" ");
      String second = nameTemp[1];
      String nameToReturn = '${nameTemp[0]}' + ' ${second[0]}';
      // print the first name
      return nameToReturn;
      // print the initials of the remaining name

    } else
      return name;
  }

  String getCategoryToDisplay(int categoryNumber) {
    if (categoryNumber == null) {
      return 'Not Sure';
    } else if (categoryNumber == -1) {
      return 'Not Sure';
    } else {
      CategoryModel displayCategory = categories[categoryNumber];
      return displayCategory.name;
    }
  }

  String getOrganizationToDisplay() {}

  void callSetStateOfQuestionCard() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 8),
        child: GestureDetector(
          onTap: () {
            // details of question
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionDetailsLandingScreen(
                    questionData: widget.questionData,
                  ),
                ));
            /* pushNewScreen(
              context,
              screen: QuestionDetailsLandingScreen(
                questionData: widget.questionData,
              ),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );*/
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // row for user details then bookmark option
                  SizedBox(
                    height: 18.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      UserProfileImage(
                          widget.questionData['questionByImageURL'], 18.0),
                      SizedBox(
                        width: 4.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OtherUsersProfileLandingPage(
                                    uid: Provider.of<User>(context,
                                            listen: false)
                                        .userId,
                                    otherUserUid:
                                        widget.questionData['questionByUID'],
                                  ),
                                ));
                            /*pushNewScreen(
                              context,
                              screen: OtherUserProfile(
                                uid: Provider.of<User>(context, listen: false)
                                    .userId,
                                otherUserUid:
                                    widget.questionData['questionByUID'],
                              ),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );*/
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    '${getNameToDisplay(widget.questionData.data['questionByName'])}' +
                                        //             '${widget.questionData.data['questionByName']} '
                                        ' (${widget.questionData['questionByProfession']})',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  '${(widget.questionData.data['questionByOrganization'] != null) ? widget.questionData.data['questionByOrganization'] : ''}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BookmarkButton(
                        questionId: widget.questionData.documentID,
                        forDetails: false,
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    color: Color(0xFFFBE7E7),
                    child: Text(
                      '${getCategoryToDisplay(widget.questionData.data['category'])}',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      '${widget.questionData.data['questionText']}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  QuestionImages(
                    questionImagesList: widget.questionData['questionImages'],
                    size: _size,
                  ),
                  QuestionFiles(
                    questionFile: widget.questionData['questionPdf'],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  (widget.questionData['isAnswered'])
                      ? Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Text(
                            '${widget.questionData['latestAnswerText']}',
                            style: GoogleFonts.poppins(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Text(
                            'No Answers Yet',
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                        ),
//                SizedBox(
//                  height: 15,
//                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
//                    LikeButton(
//                      likesCount: widget.questionData['likesCount'],
//                    ),
//                    SizedBox(
//                      width: 20.0,
//                    ),
                      AnswersCount(
                        replyCount: widget.questionData['replyCount'],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        '${timeago.format(DateTime.parse(widget.questionData['questionTimeStamp']))}',
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 11),
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
