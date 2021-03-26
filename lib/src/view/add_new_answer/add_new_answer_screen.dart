import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisaanCorner/src/core/widgets/alert_dialogs.dart';
import 'package:kisaanCorner/src/model/answer/answer_model.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/network/add_answer_to_firebase.dart';
import 'package:provider/provider.dart';

// app dependencies
import 'widgets/floating_attachment_button.dart';
import 'widgets/question_details.dart';
import 'widgets/image_preview_before_post.dart';
import 'widgets/file_preview_before_post.dart';

class AddNewAnswerScreen extends StatefulWidget {
  final DocumentSnapshot questionSnapshot;
  AddNewAnswerScreen(this.questionSnapshot);
  //final DocumentSnapshot questionSnapshot;
  @override
  _AddNewAnswerScreenState createState() => _AddNewAnswerScreenState();
}

class _AddNewAnswerScreenState extends State<AddNewAnswerScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _answerTextController = TextEditingController();
  bool isUploading = false;

  // answer model
  Answer newAnswerToPost = Answer();

  void callSetStateOfAddNewAnswerScreen() {
    setState(() {});
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
              child: (isUploading)
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
                          isUploading = true;
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        });
                        AddAnswerToFirebase _addAnswerToFirebase =
                            AddAnswerToFirebase();
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
                          newAnswerToPost.answerByUID = userDetails.userId;
                          newAnswerToPost.answerByImageURL =
                              userDetails.personalInformation.profileImageUrl;
                          newAnswerToPost.answerByProfession =
                              userDetails.personalInformation.profession;
                          newAnswerToPost.answerByName =
                              userDetails.personalInformation.fullName;
                          newAnswerToPost.answerByOrganization =
                              userDetails.getOrganizationForQuestionPost();
                          newAnswerToPost.questionByName =
                              widget.questionSnapshot.data['questionByName'];
                          newAnswerToPost.questionByUID =
                              widget.questionSnapshot.data['questionByUID'];
                          newAnswerToPost.questionByProfession = widget
                              .questionSnapshot.data['questionByProfession'];
                          newAnswerToPost.questionByImageURL = widget
                              .questionSnapshot.data['questionByImageURL'];
                          newAnswerToPost.questionText =
                              widget.questionSnapshot.data['questionText'];
                          newAnswerToPost.questionTimeStamp =
                              widget.questionSnapshot.data['questionTimeStamp'];
                          newAnswerToPost.questionUID =
                              widget.questionSnapshot.documentID;
                          // question By organization

                          newAnswerToPost.answerText =
                              _answerTextController.text.toString().trim();
                          newAnswerToPost.answerTimeStamp =
                              DateTime.now().toString();
                          newAnswerToPost.likesCount = 0;

                          bool isSuccess;
                          isSuccess =
                              await _addAnswerToFirebase.postAnswerToFirebase(
                                  answerToPostToFirebase: newAnswerToPost,
                                  previousReplyCount:
                                      widget.questionSnapshot['replyCount']);
                          if (isSuccess) {
                            // addded new answer go to home Screen
                            // show dialog also
                            AlertDialogs _alert = AlertDialogs();
                            _alert.showAlertDialogWithOKbutton(context,
                                'Your answer has been posted successfully', 2);
                            //  Navigator.pop(context, true);
                          } else {
                            // answer not added
                            AlertDialogs _alert = AlertDialogs();
                            _alert.showAlertDialogWithoutButton(
                                context: context,
                                text: 'Error while adding answer',
                                popCount: 1);

                            // show dialog
                            setState(() {
                              isUploading = false;
                            });
                          }
                        }
                      },
                      child: Center(
                        child: Text(
                          "POST",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
            )
          ],
        ),
        body: Container(
          width: _size.width,
          height: _size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
            child: (newAnswerToPost.inputMultipleImages != null ||
                    newAnswerToPost.inputMultipleFiles != null)
                ? LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            QuestionDetails(widget.questionSnapshot),
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
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
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
                                  scrollPadding: EdgeInsets.all(10.0),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  autofocus: false,
                                ),
                              ),
                            ),
                            ImagePreviewBeforePost(
                              inputMultipleImages:
                                  newAnswerToPost.inputMultipleImages,
                              size: _size,
                            ),
                            FilePreviewBeforePost(
                              size: _size,
                              inputMultipleFiles:
                                  newAnswerToPost.inputMultipleFiles,
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white,
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
                      QuestionDetails(widget.questionSnapshot),
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
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Place your answer here ...',
                                hintStyle:
                                    TextStyle(fontStyle: FontStyle.italic),
                                filled: true,
                                fillColor: Colors.white),
                            scrollPadding: EdgeInsets.all(10.0),
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
          newAnswerToPost: newAnswerToPost,
          callSetStateOfAddNewAnswerScreen: callSetStateOfAddNewAnswerScreen,
        ),
      ),
    );
  }
}
