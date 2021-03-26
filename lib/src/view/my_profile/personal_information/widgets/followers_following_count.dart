import 'package:flutter/material.dart';

//added dependencies
import 'package:google_fonts/google_fonts.dart';

class FollowersFollowingCount extends StatelessWidget {
  final int followersCount;
  final int followingCount;
  FollowersFollowingCount(this.followersCount, this.followingCount);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text('$followersCount',
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              Text(
                'Followers',
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: VerticalDivider(
              color: Color(0x73707070),
              thickness: 1,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text('$followingCount',
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              Text(
                'Following',
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    );
  }
}
