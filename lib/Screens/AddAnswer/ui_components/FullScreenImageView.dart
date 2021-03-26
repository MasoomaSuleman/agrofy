import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FullScreenImageView extends StatelessWidget {
  final DocumentSnapshot questionSnapshot;
  FullScreenImageView(this.questionSnapshot);
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        child: Hero(
          tag: 'questionImages_tag',
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              addAutomaticKeepAlives: true,
              cacheExtent: 20,
              itemCount: questionSnapshot['questionImages'].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int i) {
//                            print(
//                                "questionImages=========>>>: ${i.toString()}");
                return Container(
                  width: _size.width,
                  height: _size.height * 0.15,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: CachedNetworkImage(
                      imageUrl: questionSnapshot["questionImages"][i]['url'],
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
