import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'EditAnswer/services/UpdateAndDeleteToFirestore.dart';

//app dependencies
final _firestore = Firestore.instance;

class QuestionEditScreen extends StatefulWidget {
  final DocumentSnapshot questionData;

  QuestionEditScreen({this.questionData});
  @override
  _QuestionEditScreenState createState() =>
      _QuestionEditScreenState(questionData: questionData);
}

class _QuestionEditScreenState extends State<QuestionEditScreen> {
  final DocumentSnapshot questionData;
  _QuestionEditScreenState({this.questionData});
  TextEditingController questionText = TextEditingController();
  GlobalKey _keyLoader = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    questionText.text = questionData['questionText'];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    questionText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "My Contributions",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      //setstate to loading
                      UpdateAndDelete.deleteMyQuestion(
                          context, _keyLoader, questionData);
                    })
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Text(
                      "Question",
                      style: GoogleFonts.poppins(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: size.width - 50,
                          height: size.height * 0.75,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: TextFormField(
                              //TODO: The question class passed is different
                              // to give initial question value here
                              controller: questionText,
                              //initialValue: this.widget.questionData['_question'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 14),
                              decoration: InputDecoration(),
                              scrollPadding: EdgeInsets.all(10.0),
                              keyboardType: TextInputType.multiline,
                              maxLines: 100,
                              autofocus: true,
                            ),
                          )),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Color(0xfff3f3f3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/ic_perm_media_24px.svg',
                            color: Colors.grey,
                            width: 16,
                            height: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 4,
                onPressed: () {
                  // TODO Post Answer
                  // show circularprogressindicator;
                  _firestore
                      .collection('questionData')
                      .document('${this.widget.questionData.documentID}')
                      .updateData(
                          {'_question': "${questionText.text.toString()}"});
                  //  _updateAnswer(context);
                  //_storeAnswerToFirebase(userDetails);
                },
                color: Color(0xFF3d3a3a),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Post Your Question',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 10),
                  ),
                ))));
  }
}
