import 'package:flutter/material.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

// app dependencies
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/home/widgets/questions_card/questions_card.dart';
import 'no_bookmarks_widget.dart';

class MyBookmarksScreen extends StatefulWidget {
  @override
  _MyBookmarksScreenState createState() => _MyBookmarksScreenState();
}

class _MyBookmarksScreenState extends State<MyBookmarksScreen> {
  Stream getBookmarksStream() {
    return Firestore.instance
        .collection('questionData')
        //.where('category', isEqualTo: check)
        .orderBy('questionTimeStamp', descending: true)
        // .limit(15)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> bookmarksList = Provider.of<User>(context).bookmarkList;
    return SafeArea(
      child: Scaffold(
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
            "My Bookmarks",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: getBookmarksStream(),
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
              return NoBookmarksWidget();
            }
            return (snapshot.data.documents.isEmpty)
                ? NoBookmarksWidget()
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
                          return (bookmarksList.contains(docData.documentID))
                              ? QuestionsCard(questionData: docData)
                              : Container();
                        }));
          },
        ),
      ),
    );
  }
}
