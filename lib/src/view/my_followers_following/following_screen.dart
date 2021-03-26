import 'package:flutter/material.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// app dependencies
import 'package:kisaanCorner/Models/FollowModel.dart';
import 'widgets/following_tile.dart';
import 'widgets/following_none.dart';

class FollowingScreen extends StatefulWidget {
  final String userId;
  FollowingScreen(this.userId);
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  Stream getStream() {
    return Firestore.instance
        .collection('followData')
        .where('uidUserFollower', isEqualTo: widget.userId)
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
          "Following",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Text(
              "Loading",
              style: GoogleFonts.poppins(),
            ));
          }
          if (!snapshot.hasData) {
            return FollowingNone();
          }
          return (snapshot.data.documents.isEmpty)
              ? FollowingNone()
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
                        return FollowingTile(temp, docData.documentID);
                      }));
        },
      ),
    );
  }
}
