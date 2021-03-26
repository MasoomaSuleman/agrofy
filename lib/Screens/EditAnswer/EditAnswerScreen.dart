import 'package:flutter/material.dart';

// added dependency
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

//services
import 'services/ImageInput.dart';
import 'services/UpdateAndDeleteToFirestore.dart';

class EditAnswerScreen extends StatefulWidget {
  final DocumentSnapshot answerSnapshot;
  EditAnswerScreen(this.answerSnapshot);
  @override
  _EditAnswerScreenState createState() =>
      _EditAnswerScreenState(answerSnapshot);
}

class _EditAnswerScreenState extends State<EditAnswerScreen> {
  final DocumentSnapshot answerSnapshot;
  _EditAnswerScreenState(this.answerSnapshot);

  final Firestore _firestore = Firestore.instance;
  // key for loading
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  ScrollController _scrollController = ScrollController();
  TextEditingController _answerTextController = TextEditingController();

  String _answerImageURl;
  File _imageInput;

  @override
  void initState() {
    // TODO: implement initState
    _answerTextController.text = answerSnapshot['answerText'];
    _answerImageURl = answerSnapshot.data['answerImageURL'];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    _answerTextController.dispose();
  }

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
                "My Contributions",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      UpdateAndDelete.deleteAnswer(
                          context, _keyLoader, answerSnapshot);
                    })
              ],
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
                      "Answers",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${answerSnapshot['questionText']}",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600),
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
                          child: (_answerImageURl != null ||
                                  _imageInput != null)
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
                                                child: (_imageInput != null)
                                                    ? Image.file(
                                                        _imageInput,
                                                        fit: BoxFit.contain,
                                                      )
                                                    : Image.network(
                                                        '$_answerImageURl',
                                                        fit: BoxFit.contain,
                                                        color: Colors.grey,
                                                      ),
                                              )),
                                          Positioned(
                                              right: 0,
                                              child: IconButton(
                                                icon: Icon(Icons.remove_circle),
                                                onPressed: () {
                                                  // delete this image file and call sets ate
                                                  setState(() {
                                                    _imageInput = null;
                                                    _answerImageURl = null;
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
                                              border: InputBorder.none),
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
                  // show circularprogressindicator;
                  UpdateAndDelete.updateAnswer(
                      context,
                      _keyLoader,
                      answerSnapshot,
                      _answerTextController,
                      _answerImageURl,
                      _imageInput);
                  //  _updateAnswer(context);
                  //_storeAnswerToFirebase(userDetails);
                },
                color: Color(0xFF3d3a3a),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Update Answer',
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
