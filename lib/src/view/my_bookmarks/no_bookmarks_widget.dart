import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NoBookmarksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/my_account_page_icons/bookmarks_none.svg',
          width: 200,
          height: 200,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'You didnt bookmark anything yet.',
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.lightGreen[900]),
        )
      ],
    ));
  }
}
