import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigButton extends StatelessWidget {
  const BigButton(
      {Key key,
      @required this.size,
      @required this.height,
      @required this.text,
      @required this.press})
      : super(key: key);

  final Size size;
  final String text;
  final Function press;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      height: height,

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
