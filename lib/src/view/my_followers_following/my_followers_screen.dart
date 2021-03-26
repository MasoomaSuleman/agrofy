import 'package:flutter/material.dart';

// addded dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/other_user_landing_page.dart';
import 'package:provider/provider.dart';

// app dependencies
import 'widgets/no_followers_widget.dart';

import 'package:kisaanCorner/Models/FollowModel.dart';

class MyFollowersScreen extends StatefulWidget {
  final String userId;
  MyFollowersScreen(this.userId);
  @override
  _MyFollowersScreenState createState() => _MyFollowersScreenState();
}

class _MyFollowersScreenState extends State<MyFollowersScreen> {
  Stream getStream() {
    return Firestore.instance
        .collection('followData')
        .where('uidUserFollowing', isEqualTo: widget.userId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Followers",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Text(
              "Loading",
              style: GoogleFonts.poppins(),
            ));
          }
          if (!snapshot.hasData) {
            return NoFollowersWidget();
          }
          return (snapshot.data.documents.isEmpty)
              ? NoFollowersWidget()
              : Container(
                  width: size.width,
                  height: size.height,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot?.data?.documents?.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        DocumentSnapshot docData =
                            snapshot.data.documents[index];
                        FollowModel temp = FollowModel();
                        temp = FollowModel()
                            .fromMap(snapshot.data.documents[index]);
                        return _FollowerTile(docData.documentID, temp);
                      }));
        },
      ),
    );
  }
}

class _FollowerTile extends StatefulWidget {
  final String followId;
  final FollowModel temp;
  _FollowerTile(this.followId, this.temp);
  @override
  __FollowerTileState createState() => __FollowerTileState(followId, temp);
}

class __FollowerTileState extends State<_FollowerTile> {
  final String followId;
  final FollowModel temp;
  __FollowerTileState(this.followId, this.temp);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
            onTap: () {
              // go to other user profile page
//              Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => OtherUserProfile(
//                            uid: temp.uidUserFollowing,
//                            otherUserUid: temp.uidUserFollower,
//                          )));
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>OtherUsersProfileLandingPage(
                  uid: Provider.of<User>(context, listen: false)
                  .userId,
                  otherUserUid: widget.temp.uidUserFollower,
                  ), ));
            },
            leading: CircularProfileAvatar(
              '${temp.imageUserFollower}',
              radius: 20.0,
              borderWidth: 0,
//                        initialsText: Text("H"),
              backgroundColor: Colors.grey,
              elevation: 0,
            ),
            title: Text(
              "${temp.nameUserFollower}",
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
                "${temp.professionUserFollower}",
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12.0),
              ),
            ),
          ),
          Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
