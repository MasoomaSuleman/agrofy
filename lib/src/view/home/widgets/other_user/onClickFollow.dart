import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/Models/FollowModel.dart';
class OnClickFollow extends StatefulWidget {
  final String imageUserFollower;
  final String nameUserFollower;
  final String professionUserFollower;
  final String professionUserFollowing;
  final String nameUserFollowing;
  final String uidUserFollower;
  final String uidUserFollowing;
  final String imageUserFollowing;
  final Function action;
  final Size size;
   OnClickFollow({
    @required this.imageUserFollower,
    @required this.nameUserFollower,
      @required this.professionUserFollower,
    @required  this.professionUserFollowing,
      @required this.nameUserFollowing,
      @required  this.uidUserFollower,
      @required   this.uidUserFollowing, 
        @required   this.imageUserFollowing,
        @required    this.size,
    @required    this.action
   });
  @override
  _OnClickFollowState createState() => _OnClickFollowState();
}

class _OnClickFollowState extends State<OnClickFollow> {
  FollowModel _toPass = FollowModel();
  // create a model class for follow request
  @override
  void initState() {
    // TODO: implement initState
    _toPass.uidUserFollower = widget.uidUserFollower;
    _toPass.nameUserFollower = widget.nameUserFollower;
    _toPass.imageUserFollower = widget.imageUserFollower;
    _toPass.professionUserFollower = widget.professionUserFollower;
    _toPass.uidUserFollowing = widget.uidUserFollowing;
    _toPass.nameUserFollowing = widget.nameUserFollowing;
    _toPass.imageUserFollowing = widget.imageUserFollowing;
    _toPass.professionUserFollowing = widget.professionUserFollowing;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.8,
      height: 40.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: RaisedButton(
          onPressed: () {
            // add a follow request data here
            Firestore.instance
                .collection("followData")
                .add(_toPass.toMapFollowing())
                .then((value) {
              // call the function to setstate and udate the button
              setState(() {
                //_followId = value.documentID;
                widget.action(value.documentID);
              });
            });
          },
          child: Text(
            "Follow",
            style: GoogleFonts.poppins(color: Colors.white,
            fontWeight: FontWeight.w500),
          ),
          color: Colors.black,
        ),
      ),
    );
  }
} 
  
  
