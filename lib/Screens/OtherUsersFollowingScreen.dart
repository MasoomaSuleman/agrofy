import 'package:flutter/material.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:kisaanCorner/Models/FollowModel.dart';

// app dependencies
import 'otherUserProfile.dart';
import '../constants.dart';

final Firestore _firestore = Firestore.instance;
//Function callSetStateOfFollowingScreen;

class OtherUsersFollowingScreen extends StatefulWidget {
  final String uid;
  OtherUsersFollowingScreen({this.uid});
  @override
  _OtherUsersFollowingScreenState createState() => _OtherUsersFollowingScreenState(uid: uid);
}

class _OtherUsersFollowingScreenState extends State<OtherUsersFollowingScreen> {
  final String uid;
  Stream _stream;
  _OtherUsersFollowingScreenState({this.uid});

  Future<void> getStream() async {
    _stream = _firestore
        .collection('followData')
        .where('uidUserFollower', isEqualTo: uid)
        .snapshots();
  }

  void callSetStateOfFollowingScreen() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getStream();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
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
          "My Followers",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('followData')
            .where('uidUserFollower', isEqualTo: uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (!snapshot.hasData) {
            return Text("Currently following no one");
          }
          return (snapshot.data.documents.isEmpty)
              ? Center(child: Text("Following No one currently"))
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
  __FollowerTileState createState() => __FollowerTileState();
}

class __FollowerTileState extends State<_FollowerTile> {
  @override
  void didUpdateWidget(_FollowerTile oldWidget) {
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
              // go to other user profile page
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtherUserProfile(
                            uid: widget.temp.uidUserFollower,
                            otherUserUid: widget.temp.uidUserFollowing,
                          )));
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
          /*  trailing: Container(
              width: 80,
              height: 30.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: RaisedButton(
                  onPressed: () {
                    // add a follow request data here
                    _firestore
                        .collection("followData")
                        .document(widget.followId)
                        .delete()
                        .then((value) {
                      //_FollowingScreenState.callSetStateOfFollowingScreen();
                      this.setState(() {});
                    });
                  },
                  child: Center(
                    child: Text(
                      "Unfollow",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 10),
                    ),
                  ),
                  color: kPrimaryButton,
                ),
              ),
            ),*/
          ),
          Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
