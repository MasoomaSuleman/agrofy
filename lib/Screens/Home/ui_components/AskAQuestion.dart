import 'package:flutter/material.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_svg/flutter_svg.dart';

// app dependencies
import 'package:kisaanCorner/views/ask_question_screen.dart';

class AskAQuestion extends StatelessWidget {
  final Size _size;
  AskAQuestion(this._size);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      child: GestureDetector(
        onTap: () {
          pushNewScreen(
            context,
            screen: AskQuestionScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: Container(
          width: _size.width,
          height: 50,
          decoration: BoxDecoration(
              color: Color(0xfff3f3f3),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10.0,
              ),
              SvgPicture.asset(
                'assets/images/Group 2117.svg',
                width: 25.0,
                height: 25.0,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Ask a question',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              Expanded(child: Container()),
              SvgPicture.asset(
                'assets/images/ic_perm_media_24px.svg',
                color: Colors.grey,
                width: 16,
                height: 16,
              ),
              SizedBox(
                width: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
