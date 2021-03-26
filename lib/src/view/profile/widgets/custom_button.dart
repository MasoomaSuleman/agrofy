import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// app dependencies
import 'package:kisaanCorner/utils/SizeConfig.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final String text;
  final Function press;
  CustomButton({@required this.text, @required this.press, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width != null) ? width : SizeConfig.screenWidth * 0.8,
      height: 48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FlatButton(
          onPressed: press,
          child: Text(
            text,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          color: Colors.lightGreen[900],
        ),
      ),
    );
  }
}
