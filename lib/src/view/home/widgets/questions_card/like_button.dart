import 'package:flutter/material.dart';

//added dependencies
import 'package:google_fonts/google_fonts.dart';

class LikeButton extends StatefulWidget {
  int likesCount;
  LikeButton({this.likesCount});
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return _isLiked
        ? GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Color(0xFFFA5B5B),
                    size: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${(widget.likesCount == null) ? 00 : widget.likesCount}',
                    style: GoogleFonts.poppins(
                        color: Color(0XFF6F6E6E), fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Color(0xFF6F6E6E),
                    size: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${(widget.likesCount == null) ? 00 : widget.likesCount}',
                    style: GoogleFonts.poppins(
                        color: Color(0XFF6F6E6E), fontSize: 12),
                  ),
                ],
              ),
            ),
          );
  }
}
