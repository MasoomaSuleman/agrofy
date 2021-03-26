import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kisaanCorner/src/model/answer/file_model.dart';

import 'package:kisaanCorner/src/network/edit_answer_in_firebase.dart';
import 'package:kisaanCorner/src/core/widgets/alert_dialogs.dart';

class PostedFilesPreview extends StatefulWidget {
  final List<FileModel> postedFiles;
  final Size size;
  final String answerId;
  PostedFilesPreview({this.postedFiles, this.size, this.answerId});
  @override
  _PostedFilesPreviewState createState() => _PostedFilesPreviewState();
}

class _PostedFilesPreviewState extends State<PostedFilesPreview> {
  @override
  Widget build(BuildContext context) {
    if (widget.postedFiles == null) {
      return Container();
    } else
      return Container(
          width: widget.size.width - 40,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Color(0X1A000000),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(3, 2))
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.postedFiles.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Container(
                      height: 45,
                      color: Color(0xFFEEEEEE),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20.0,
                          ),
                          Icon(
                            Icons.save_alt,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                '${widget.postedFiles[index].name}',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              EditAnswerInFirebase _editAnswer =
                                  EditAnswerInFirebase();
                              _editAnswer.deleteAnswerFileFromList(
                                  widget.answerId, widget.postedFiles[index]);
                              setState(() {
                                widget.postedFiles.removeAt(index);

                                // call firebase function also
                                // remove at array
                              });
                              AlertDialogs _alert = AlertDialogs();
                              _alert.showAlertDialogWithoutButton(
                                  context: context,
                                  text: 'File deleted from this answer.',
                                  popCount: 1);
                            },
                          ),
                          SizedBox(
                            width: 15.0,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ));
  }
}
