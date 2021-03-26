import 'package:flutter/material.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';

class AnswersCount extends StatefulWidget {
  int replyCount;
  AnswersCount({this.replyCount});
  @override
  _AnswersCountState createState() => _AnswersCountState();
}

class _AnswersCountState extends State<AnswersCount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            Icons.text_format,
            color: Color(0xFF6F6E6E),
            size: 15,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '${widget.replyCount}',
            style: GoogleFonts.poppins(color: Color(0XFF6F6E6E), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
