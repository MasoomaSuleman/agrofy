import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionFilesPreviewFullScreen extends StatefulWidget {
  final DocumentSnapshot questionSnapshot;
  QuestionFilesPreviewFullScreen(this.questionSnapshot);
  @override
  _QuestionFilesPreviewFullScreenState createState() =>
      _QuestionFilesPreviewFullScreenState();
}

class _QuestionFilesPreviewFullScreenState
    extends State<QuestionFilesPreviewFullScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0X66000000),
          centerTitle: true,
          title: Text(
            'Photos & Files',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          )),
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: _size.height,
          width: _size.width,
          color: Color(0X66000000),
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              addAutomaticKeepAlives: true,
              cacheExtent: 20,
              itemCount: widget.questionSnapshot['questionImages'].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int i) {
//                            print(
//                                "questionImages=========>>>: ${i.toString()}");
                return Container(
                  height: _size.height,
                  width: _size.width,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: CachedNetworkImage(
                      imageUrl: widget.questionSnapshot["questionImages"][i]
                          ['url'],
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
