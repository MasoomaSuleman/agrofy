import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function _onTap;
  final String assetImageUrl;
  final String trailingText;
  CustomListTile(this.icon, this.title, this._onTap, this.assetImageUrl,
      this.trailingText);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: false,
          leading: SvgPicture.asset(
            '$assetImageUrl',
            width: 36,
            height: 36,
          ),
//          Icon(
//            icon,
//            color: Colors.black,
//          ),
          title: Text(
            "$title",
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          trailing: (trailingText != null)
              ? Text(
                  '$trailingText',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w400),
                )
              : null,
          onTap: _onTap,
        ),

//        Divider(
//          height: 0,
//        )
      ],
    );
  }
}
