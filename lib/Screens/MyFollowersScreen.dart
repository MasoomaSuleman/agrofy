//import 'package:circular_profile_avatar/circular_profile_avatar.dart';
//import 'package:flutter/material.dart';
//
////added dependencies
//import 'package:google_fonts/google_fonts.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//// app dependencies
//import '../Models/FollowModel.dart';
//import 'otherUserProfile.dart';
//
//final Firestore _firestore = Firestore.instance;
//
//class MyFollowersScreen extends StatefulWidget {
//  final String uid;
//  MyFollowersScreen({this.uid});
//  @override
//  _MyFollowersScreenState createState() => _MyFollowersScreenState(uid);
//}
//
//class _MyFollowersScreenState extends State<MyFollowersScreen> {
//  final String uid;
//  _MyFollowersScreenState(this.uid);
//
//  Stream _stream;
//  Future<void> getStream() async {
//    _stream = _firestore
//        .collection('followData')
//        .where('uidUserFollowing', isEqualTo: uid)
//        .snapshots();
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    getStream();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//    return Scaffold(
//      backgroundColor: Color(0xFFF8F8F8),
//      appBar: AppBar(
//        backgroundColor: Colors.lightGreen[900],
//        leading: IconButton(
//          icon: Icon(
//            Icons.arrow_back,
//            color: Colors.white,
//          ),
//          onPressed: () {
//            Navigator.pop(context);
//          },
//        ),
//        centerTitle: true,
//        title: Text(
//          "My Followers",
//          style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
//        ),
//      ),
//      body: StreamBuilder<QuerySnapshot>(
//        stream: _stream,
//        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasError) {
//            return Text('Something went wrong');
//          }
//
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return Text("Loading");
//          }
//          if (!snapshot.hasData) {
//            return Text("Currently following no one");
//          }
//          return (snapshot.data.documents.isEmpty)
//              ? Center(child: Text("Currently no Followers"))
//              : Container(
//                  width: size.width,
//                  height: size.height,
//                  child: ListView.builder(
//                      shrinkWrap: true,
//                      itemCount: snapshot?.data?.documents?.length,
//                      scrollDirection: Axis.vertical,
//                      itemBuilder: (context, index) {
//                        DocumentSnapshot docData =
//                            snapshot.data.documents[index];
//                        FollowModel temp = FollowModel();
//                        temp = FollowModel()
//                            .fromMap(snapshot.data.documents[index]);
//                        return _FollowerTile(docData.documentID, temp);
//                      }));
//        },
//      ),
//    );
//  }
//}
//
//class _FollowerTile extends StatefulWidget {
//  final String followId;
//  final FollowModel temp;
//  _FollowerTile(this.followId, this.temp);
//  @override
//  __FollowerTileState createState() => __FollowerTileState(followId, temp);
//}
//
//class __FollowerTileState extends State<_FollowerTile> {
//  final String followId;
//  final FollowModel temp;
//  __FollowerTileState(this.followId, this.temp);
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Column(
//        children: [
//          ListTile(
//            dense: true,
//            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
//            onTap: () {
//              // go to other user profile page
//              Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => OtherUserProfile(
//                            uid: temp.uidUserFollowing,
//                            otherUserUid: temp.uidUserFollower,
//                          )));
//            },
//            leading: CircularProfileAvatar(
//              '${temp.imageUserFollower}',
//              radius: 20.0,
//              borderWidth: 0,
////                        initialsText: Text("H"),
//              backgroundColor: Colors.grey,
//              elevation: 0,
//            ),
//            title: Text(
//              "${temp.nameUserFollower}",
//              style: GoogleFonts.poppins(
//                  color: Colors.black,
//                  fontSize: 14,
//                  fontWeight: FontWeight.w400),
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
//            ),
//            subtitle: Padding(
//              padding: const EdgeInsets.symmetric(vertical: 4.0),
//              child: Text(
//                "${temp.professionUserFollower}",
//                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12.0),
//              ),
//            ),
//          ),
//          Divider(
//            height: 0,
//          )
//        ],
//      ),
//    );
//  }
//}
