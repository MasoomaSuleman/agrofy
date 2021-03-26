import 'package:flutter/material.dart';

//addded dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'question_files_preview_full_screen.dart';

class QuestionDetails extends StatelessWidget {
  final DocumentSnapshot questionSnapshot;
  QuestionDetails(this.questionSnapshot);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${questionSnapshot.data['questionText']}",
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              // show full screen view of photos
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    // fullscreenDialog: true,
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        QuestionFilesPreviewFullScreen(questionSnapshot),
//                      pageBuilder:
//                          (context) =>
//                          QuestionFilesPreviewFullScreen(questionSnapshot)
                  ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Container(
                height: 40,
                color: Color(0xFFE7E7E7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      '${(questionSnapshot.data['questionImages'] != null) ? questionSnapshot.data['questionImages'].length : 0} photo(s), ${(questionSnapshot.data['questionPdf'] != null) ? questionSnapshot.data['questionPdf'].length : 0} file(s)',
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Color(0x80323232)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
