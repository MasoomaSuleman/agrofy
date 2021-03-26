import 'package:flutter/material.dart';
import 'dart:io';
// added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

// services
import 'services/AddAnswerToFirestore.dart';
import 'package:kisaanCorner/Screens/EditAnswer/services/ImageInput.dart';
import 'ui_components/FullScreenImageView.dart';

class AddAnswerScreen extends StatefulWidget {
  final DocumentSnapshot questionSnapshot;
  AddAnswerScreen(this.questionSnapshot);
  @override
  _AddAnswerScreenState createState() =>
      _AddAnswerScreenState(questionSnapshot);
}

class _AddAnswerScreenState extends State<AddAnswerScreen> {
  final DocumentSnapshot questionSnapshot;
  _AddAnswerScreenState(this.questionSnapshot);

  ScrollController _scrollController = ScrollController();
  TextEditingController _answerTextController = TextEditingController();
  File _imageInput;
  GlobalKey _keyLoader = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
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
                "Add your Answer",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            body: Container(
              width: _size.width,
              height: _size.height,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${questionSnapshot['questionText']}",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600),
                    ),
                    // to ask whether to show image preview or not
                    SizedBox(
                      height: 10.0,
                    ),
                    // add condition also if image is there or not
                    (questionSnapshot['questionImages'].length == 0)
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreenImageView(
                                          questionSnapshot)));
                            },
                            child: Container(
                              width: _size.width,
                              height: _size.height * 0.15,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              child: Hero(
                                tag: 'questionImages_tag',
                                child: Center(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    addAutomaticKeepAlives: true,
                                    cacheExtent: 20,
                                    itemCount:
                                        questionSnapshot['questionImages']
                                            .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int i) {
//                            print(
//                                "questionImages=========>>>: ${i.toString()}");
                                      return Container(
                                        width: _size.width,
                                        height: _size.height * 0.15,
                                        child: Center(
                                            child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5),
                                          child: CachedNetworkImage(
                                            imageUrl: questionSnapshot[
                                                "questionImages"][i]['url'],
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        )),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        width: _size.width,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: (_imageInput != null)
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 100.0,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              left: 0,
                                              child: Container(
                                                  height: _size.height * 0.2,
                                                  width: _size.width,
                                                  child: Image.file(
                                                    _imageInput,
                                                    fit: BoxFit.contain,
                                                  ))),
                                          Positioned(
                                              right: 0,
                                              child: IconButton(
                                                icon: Icon(Icons.remove_circle),
                                                onPressed: () {
                                                  // delete this image file and call sets ate
                                                  setState(() {
                                                    _imageInput = null;
                                                  });
                                                },
                                              ))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        scrollController: _scrollController,
                                        controller: _answerTextController,
                                        //initialValue: "${answerSnapshot['answerText']}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                        //scrollPadding: EdgeInsets.all(10.0),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 200,
                                        autofocus: false,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          scrollController: _scrollController,
                                          controller: _answerTextController,
                                          //initialValue: "${answerSnapshot['answerText']}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'write something here'),
                                          //scrollPadding: EdgeInsets.all(10.0),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 200,
                                          autofocus: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: const Color(0xFFF5F5F5),
                                          ),
                                          child: IconButton(
                                            color: const Color(0xFFB3B3B3),
                                            iconSize: 20.0,
                                            icon: Icon(Icons.image),
                                            onPressed: () async {
                                              takeImageInput(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 4,
                onPressed: () {
                  // TODO Post Answer
                  AddAnswerToFirestore.submitAnswerToFirestore(
                      context,
                      _keyLoader,
                      questionSnapshot,
                      _imageInput,
                      _answerTextController);
                },
                color: Color(0xFF3d3a3a),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Submit your Answer',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 10),
                  ),
                ))));
  }

  Widget takeImageInput(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Center(
                    child: Text(
                      'Camera',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0),
                    ),
                  ),
                  onTap: () async {
                    // add camera image functionality here
                    Navigator.pop(context);
                    ImageInput.imageFileFromCamera().then((value) {
                      setState(() {
                        _imageInput = value;
                      });
                    });
                  },
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0),
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    ImageInput.imageFileFromGallery().then((value) {
                      setState(() {
                        _imageInput = value;
                      });
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
