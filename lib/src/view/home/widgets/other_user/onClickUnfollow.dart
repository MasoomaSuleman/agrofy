import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OnCLickUnfollow extends StatefulWidget {
  final String followId;
  final Size size;
  final Function action;
  OnCLickUnfollow({
   @required this.followId,
   @required this.size,
   @required this.action
   });
  @override
  _OnCLickUnfollowState createState() => _OnCLickUnfollowState();
}

class _OnCLickUnfollowState extends State<OnCLickUnfollow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.8,
      height: 40.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid
          ) ),
          onPressed: () {
            // add a follow request data here
            Firestore.instance
                .collection("followData")
                .document(widget.followId)
                .delete()
                .then((value) {
               widget.action();
              // call the function to setstate and udate the button
              setState(() {
                //_followId = null;
               
              });
            });
          },
          child: Text(
            "Unfollow",
            style: GoogleFonts.poppins(color: Colors.black,
            fontWeight: FontWeight.w500),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
