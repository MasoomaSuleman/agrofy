import 'package:flutter/material.dart';

// added dependencies
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// app dependencies
import 'package:kisaanCorner/Models/FollowModel.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/other_user_landing_page.dart';
import 'package:provider/provider.dart';

class FollowingTile extends StatefulWidget {
  final String followId;
  final FollowModel temp;
  FollowingTile(this.temp, this.followId);
  @override
  _FollowingTileState createState() => _FollowingTileState();
}

class _FollowingTileState extends State<FollowingTile> {
  void didUpdateWidget(FollowingTile oldWidget) {
    // TODO: implement didUpdateWidget
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
            onTap: () {
//              // go to other user profile page
//              Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => OtherUserProfile(
//                        uid: widget.temp.uidUserFollower,
//                        otherUserUid: widget.temp.uidUserFollowing,
//                      )));
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>OtherUsersProfileLandingPage(
                  uid: Provider.of<User>(context, listen: false)
                  .userId,
                  otherUserUid: widget.temp.uidUserFollowing,
                  ), ));
            },
            leading: CircularProfileAvatar(
              '${widget.temp.imageUserFollowing}',
              radius: 20.0,
              borderWidth: 0,
//                        initialsText: Text("H"),
              backgroundColor: Colors.grey,
              elevation: 0,
            ),
            title: Text(
              "${widget.temp.nameUserFollowing}",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "${widget.temp.professionUserFollowing}",
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12.0),
              ),
            ),
            trailing: Container(
              width: 80,
              height: 30.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: RaisedButton(
                  elevation: 5,
                  onPressed: () async{
                    // add a follow request data here

                  Provider.of<User>(context,listen:false).subFollowingCount();
                   await Firestore.instance
                        .collection("followData")
                        .document(widget.followId)
                        .delete()
                        .then((value) {

                      //_FollowingScreenState.callSetStateOfFollowingScreen();
                      if(this.mounted)
                      this.setState(() {

                      });
                      
                    });
                  },
                  child: Center(
                    child: Text(
                      "Unfollow",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 10),
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
          )
        ],
      ),
    );
  }
}
