import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/home/widgets/question_details/fullScreenImageViewAnswer.dart';
import 'package:kisaanCorner/src/view/home/widgets/question_details/question_like_unlike.dart';
import 'package:kisaanCorner/src/view/home/widgets/questions_card/question_files.dart';
import 'package:kisaanCorner/src/view/home/widgets/questions_card/question_images.dart';
import 'package:kisaanCorner/src/view/home/widgets/user_profile_image.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:google_fonts/google_fonts.dart';

class AnswerWidget extends StatefulWidget {
  final DocumentSnapshot answerData;
  final index;
  AnswerWidget(this.answerData, this.index);
  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  bool _isExpandedAnswer = false;
  bool _isLikedAnswer = false;
  int likesCount;
  String getNameToDisplay(String name) {
    if (name!=null && name.length >= 15) {
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

  @override
  void didUpdateWidget(AnswerWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(this.widget.answerData.data);
    final _size = MediaQuery.of(context).size;
    User currentUser = Provider.of<User>(context);
    return Container(
      width: _size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18.0,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 16,
                ),
                UserProfileImage(
                    this.widget.answerData['answerByImageURL'], 18.0),
                SizedBox(
                  width: 4.0,
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              '${getNameToDisplay(this.widget.answerData['answerByName'])}' +
                                  //             '${widget.questionData.data['questionByName']} '
                                  ' (${this.widget.answerData['answerByProfession']})',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          /*Text(
                                '${this.widget.answerData['answerByProfession']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                ),
                              ),*/
                          Container(
                              child: RichText(
                                  maxLines: 30,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                      text:
                                          '${this.widget.answerData['answerByProfession']}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 11, color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text:
                                              '  - ${timeago.format(DateTime.parse(this.widget.answerData['answerTimeStamp']))}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey, fontSize: 10),
                                        ),
                                      ]))),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: OnClickLikeOrUnlikeAnswer(
                          answerSnapshot: this.widget.answerData,
                          userId: currentUser.userId,
                          likesCount: this.widget.answerData['likesCount'],
                        ), /*Text("15", style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black
                            ),),*/
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ('${this.widget.answerData['answerText']}'.length < 100 ||
                  widget.index < 3)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        '${this.widget.answerData['answerText']}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if(this.widget.answerData['answerFiles']!=null&&this.widget.answerData['answerFiles']!="null")
                    for(int i=0;i<this.widget.answerData['answerFiles'].length;i++)
                    QuestionFiles(
                      questionFile:this.widget.answerData['answerFiles'][i],
            
                    ),
                    (this.widget.answerData["answerImages"] != null&&this.widget.answerData["answerImages"] != "null")
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenAnswerImageView(
                                              this.widget.answerData)));
                            },
                            child: QuestionImages(
                              questionImagesList:
                                  this.widget.answerData["answerImages"],
                              size: _size,
                            ),
                          )
                        : Container(),
                  ],
                )
              : Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: '${this.widget.answerData['answerText']}'
                          .substring(0, 100),
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                    ),),
                   WidgetSpan(
                      child: (this.widget.answerData['answerFiles']!=null&&this.widget.answerData['answerFiles']!="null")?
                    {for(int i=0;i<this.widget.answerData['answerFiles'].length;i++)
                    QuestionFiles(
                      questionFile:this.widget.answerData['answerFiles'][i],
            
                    )}: Container(),
                    ),
                    WidgetSpan(
                      child: (this.widget.answerData["answerImages"] != null&&this.widget.answerData["answerImages"] != "null")
                        ? GestureDetector(
                      onTap: (){
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FullScreenAnswerImageView(this.widget.answerData)));
                      },
                                child: QuestionImages(
                        questionImagesList: this.widget.answerData["answerImages"],
                        size: _size,
                      ),
                    ): Container(),
                    ),
                    WidgetSpan(
                      child: _isExpandedAnswer
                          ? Container(
                              width: _size.width,
                              child: Text(
                                "${this.widget.answerData['answerText']}"
                                    .substring(100),
                                style: GoogleFonts.poppins(fontSize: 12.0),
                                overflow: TextOverflow.fade,
                              ),
                            )
                          : Container(
                              width: _size.width,
                              child: AutoSizeText(
                                '${this.widget.answerData['answerText']}'
                                    .substring(100),
                                maxLines: 10,
                                style: GoogleFonts.poppins(fontSize: 12.0),
                                minFontSize: 10,
                                overflowReplacement: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        '${this.widget.answerData['answerText']}'
                                            .substring(100),
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.0,
                                        ),
                                        maxLines: 10,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                          onTap: () {
                                            this.setState(() {
                                              _isExpandedAnswer = true;
                                            });
                                          },
                                          child: Container(
                                            width: 105.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                              color: Colors.lightGreen[900],
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "continue reading ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 8,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 8,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              )),
                    ),
                  ])),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              height: 20.0,
              thickness: 1,
              color: Color(0x40707070),
            ),
          )
        ],
      ),
    );
  }
}
