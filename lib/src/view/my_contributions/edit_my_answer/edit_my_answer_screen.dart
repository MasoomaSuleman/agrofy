import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// added dependencies
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// app dependencies
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/model/answer/answer_model.dart';

import 'package:kisaanCorner/src/view/add_new_answer/widgets/question_details.dart';
import 'package:kisaanCorner/src/network/edit_answer_in_firebase.dart';
import 'package:kisaanCorner/src/view/add_new_answer/widgets/file_preview_before_post.dart';
import 'package:kisaanCorner/src/view/add_new_answer/widgets/image_preview_before_post.dart';
import 'package:kisaanCorner/src/view/add_new_answer/widgets/floating_attachment_button.dart';
import 'widgets/posted_files_preview.dart';
import 'widgets/posted_images_preview.dart';
import 'package:kisaanCorner/src/core/widgets/alert_dialogs.dart';

class EditMyAnswerScreen extends StatefulWidget {
  final DocumentSnapshot answerSnap;
  EditMyAnswerScreen(this.answerSnap);
  @override
  _EditMyAnswerScreenState createState() => _EditMyAnswerScreenState();
}

class _EditMyAnswerScreenState extends State<EditMyAnswerScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _answerTextController = TextEditingController();

  Answer answerToEdit;
  bool isUpdating = false;
  bool isUploading = false;
  bool questionDetailsLoading = true;
  DocumentSnapshot questionSnapshot;

  void getQuestionDetails(String questionId) async {
    //questionSnapshot = await
    Firestore.instance
        .collection('questionData')
        .document(questionId)
        .get()
        .then((value) {
      questionSnapshot = value;
      setState(() {
        questionDetailsLoading = false;
      });
    });
  }

  void callSetStateOfEditAnswerScreen() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    answerToEdit = Answer.fromSnapshot(widget.answerSnap);
    _answerTextController.text = answerToEdit.answerText;
    getQuestionDetails(answerToEdit.questionUID);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    User userDetails = Provider.of<User>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFF8F8F8),
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[900],
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: (isUpdating)
                  ? Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          )),
                    )
                  : InkWell(
                      onTap: () async {
                        setState(() {
                          isUpdating = true;
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        });
                        EditAnswerInFirebase _addAnswerToFirebase =
                            EditAnswerInFirebase();
                        //save this answer to firebase
                        // current character limit to 10 in answer
                        String _answerString =
                            _answerTextController.text.toString().trim();
                        if (_answerString == null ||
                            _answerString == "" ||
                            _answerString.length < 10) {
                          AlertDialogs _alert = AlertDialogs();
                          _alert.showAlertDialogWithoutButton(
                              context: context,
                              text:
                                  'Answer text cannot be less than 10 characters',
                              popCount: 1);
                          setState(() {
                            isUploading = false;
                          });
                        } else {
                          // valid answer can upload
                          // get user details and time
                          answerToEdit.answerByUID = userDetails.userId;
                          answerToEdit.answerByImageURL =
                              userDetails.personalInformation.profileImageUrl;
                          answerToEdit.answerByProfession =
                              userDetails.personalInformation.profession;
                          answerToEdit.answerByName =
                              userDetails.personalInformation.fullName;
                          answerToEdit.answerByOrganization =
                              userDetails.getOrganizationForQuestionPost();
//                    answerToEdit.questionByName =
//                    widget.questionSnapshot.data['questionByName'];
//                    answerToEdit.questionByUID =
//                    widget.questionSnapshot.data['questionByUID'];
//                    answerToEdit.questionByProfession = widget
//                        .questionSnapshot.data['questionByProfession'];
//                    answerToEdit.questionByImageURL = widget
//                        .questionSnapshot.data['questionByImageURL'];
//                    answerToEdit.questionText =
//                    widget.questionSnapshot.data['questionText'];
//                    answerToEdit.questionTimeStamp =
//                    widget.questionSnapshot.data['questionTimeStamp'];
//                    answerToEdit.questionUID =
//                        widget.questionSnapshot.documentID;
                          // question By organization

                          answerToEdit.answerText =
                              _answerTextController.text.toString().trim();
                          answerToEdit.answerTimeStamp =
                              DateTime.now().toString();
                          answerToEdit.likesCount = 0;

                          bool isSuccess;
                          isSuccess =
                              await _addAnswerToFirebase.editAnswerInFirebase(
                                  answerToPostToFirebase: answerToEdit,
                                  answerId: widget.answerSnap.documentID);
                          if (isSuccess) {
                            // addded new answer go to home Screen
                            // show dialog also
                            AlertDialogs _alert = AlertDialogs();
                            _alert.showAlertDialogWithOKbutton(context,
                                'Your answer has been updated successfully', 2);
                          } else {
                            // answer not added
                            AlertDialogs _alert = AlertDialogs();
                            _alert.showAlertDialogWithoutButton(
                                context: context,
                                text: 'Error while adding answer',
                                popCount: 1);

                            // show dialog
                            setState(() {
                              isUpdating = false;
                            });
                          }
                        }
                      },
                      child: Center(
                        child: Text(
                          "REPOST",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
            )
          ],
        ),
        body: (questionDetailsLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: _size.width,
                height: _size.height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
                  child: (answerToEdit.inputMultipleImages != null ||
                          answerToEdit.inputMultipleFiles != null ||
                          answerToEdit.answerFiles != null ||
                          answerToEdit.answerImages != null)
                      ? LayoutBuilder(builder: (BuildContext context,
                          BoxConstraints viewportConstraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: viewportConstraints.maxHeight),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  QuestionDetails(questionSnapshot),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0X1A000000),
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                              offset: Offset(3, 2))
                                        ]),
                                    child: TextField(
                                      scrollController: _scrollController,
                                      controller: _answerTextController,
                                      //initialValue: "${answerSnapshot['answerText']}",

                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      //scrollPadding: EdgeInsets.all(10.0),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      autofocus: false,
                                    ),
                                  ),
                                  PostedImagesPreview(
                                    postedImages: answerToEdit.answerImages,
                                    size: _size,
                                    answerId: widget.answerSnap.documentID,
                                  ),
                                  ImagePreviewBeforePost(
                                    inputMultipleImages:
                                        answerToEdit.inputMultipleImages,
                                    size: _size,
                                  ),
                                  PostedFilesPreview(
                                    postedFiles: answerToEdit.answerFiles,
                                    size: _size,
                                    answerId: widget.answerSnap.documentID,
                                  ),
                                  FilePreviewBeforePost(
                                    size: _size,
                                    inputMultipleFiles:
                                        answerToEdit.inputMultipleFiles,
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white,
//                              borderRadius: BorderRadius.only(
//                                  topLeft: Radius.circular(10),
//                                  topRight: Radius.circular(10)),
                                              boxShadow: [
                                            BoxShadow(
                                                color: Color(0X1A000000),
                                                blurRadius: 1,
                                                spreadRadius: 1,
                                                offset: Offset(3, 2))
                                          ]),
                                    ),
                                  ),
//                              Expanded(
//                                child: Container(
//                                  decoration: BoxDecoration(color: Colors.white,
////                              borderRadius: BorderRadius.only(
////                                  topLeft: Radius.circular(10),
////                                  topRight: Radius.circular(10)),
//                                      boxShadow: [
//                                        BoxShadow(
//                                            color: Color(0X1A000000),
//                                            blurRadius: 1,
//                                            spreadRadius: 1,
//                                            offset: Offset(3, 2))
//                                      ]),
//                                ),
//                              )
                                ],
                              ),
                            ),
                          );
                        })
                      : Column(
                          children: [
                            QuestionDetails(questionSnapshot),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0X1A000000),
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          offset: Offset(3, 2))
                                    ]),
                                child: TextField(
                                  scrollController: _scrollController,
                                  controller: _answerTextController,
                                  //initialValue: "${answerSnapshot['answerText']}",

                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
//                      decoration: InputDecoration(
//
//                          border: InputBorder.none,
//                          filled: true,
//                          fillColor: Colors.white),
                                  //scrollPadding: EdgeInsets.all(10.0),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 200,
                                  autofocus: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
        floatingActionButton: FloatingAttachmentButton(
          newAnswerToPost: answerToEdit,
          callSetStateOfAddNewAnswerScreen: callSetStateOfEditAnswerScreen,
        ),
      ),
    );
  }
}
