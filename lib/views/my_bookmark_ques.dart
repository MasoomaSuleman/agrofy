import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBookMarkQues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "My Bookmarksss",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Text("jhkjg"),
          Container(
            child: MyBookMarkQues(),
          ),
        ],
      ),
    );
  }
}
