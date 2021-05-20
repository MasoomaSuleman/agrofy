import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TaxmanInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text(
              "Powered by",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
            Text(
              "AGROFY- smarter way to farm",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    'assets/images/my_account_page_icons/facebook_logo.svg',
                    width: 30,
                    height: 30,
                  ),
                  onTap: () {
                    launch('https://www.facebook.com/taxmannindia');
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: SvgPicture.asset(  
                    'assets/images/my_account_page_icons/twitter_logo.svg',
                    width: 30, 
                    height: 30,
                  ),
                  onTap: () {
                    launch('twitter handle url');
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: SvgPicture.asset(
                    'assets/images/my_account_page_icons/share_logo.svg',
                    width: 30,
                    height: 30,
                  ),
                  onTap: () {
                    launch('https://www.linkedin.com/company/taxmann/');
                  },
                ),
              ],
            )
            // add icons also
          ],
        ),
      ),
    );
  }
}
