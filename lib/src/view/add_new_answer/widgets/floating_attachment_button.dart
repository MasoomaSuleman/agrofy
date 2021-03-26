import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math' as math;

// added dependencies
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:file_picker/file_picker.dart';

// app dependencies
import 'package:kisaanCorner/src/model/answer/answer_model.dart';

class FloatingAttachmentButton extends StatefulWidget {
  final Answer newAnswerToPost;
  final Function callSetStateOfAddNewAnswerScreen;
  FloatingAttachmentButton(
      {this.newAnswerToPost, this.callSetStateOfAddNewAnswerScreen});
  @override
  _FloatingAttachmentButtonState createState() =>
      _FloatingAttachmentButtonState();
}

class _FloatingAttachmentButtonState extends State<FloatingAttachmentButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  String _error = 'No Error Dectected';

  static const List<IconData> icons = const [
    Icons.description_outlined,
    Icons.insert_photo_outlined
  ];

  // fuctions for multiple images functionality
  Future<void> loadMultipleImages() async {
    List<Asset> resultList;
    String error =
        "FloatingAttachmentButton()''': No Error while adding multiple images";
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
//        selectedAssets: widget.newAnswerToPost.inputMultipleImages,
//        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//        materialOptions: MaterialOptions(
//            actionBarColor: "#abcdef",
//            actionBarTitle: "Example App",
//            allViewTitle: "All Photos",
//            useDetailsView: false,
//            selectCircleStrokeColor: "#000000"),
      );
    } on Exception catch (e) {
      error = e.toString();
      print(
          "FloatingAttachmentButton()''': Error while adding multiple images" +
              error);
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;

    // remove setstae from here
    if (widget.newAnswerToPost.inputMultipleImages != null) {
      resultList.forEach((element) {
        widget.newAnswerToPost.inputMultipleImages.add(element);
      });
    } else {
      widget.newAnswerToPost.inputMultipleImages = resultList;
    }

    widget.callSetStateOfAddNewAnswerScreen();
  }

  Future<void> loadMultipleFiles() async {
    List<File> files;
    String error =
        "FloatingAttachmentButton()''': No Error while adding multiple files";
    try {
      files = await FilePicker.getMultiFile(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'ppt', 'xlsx', 'docx', 'csv', 'pptx'],
      );
    } on Exception catch (e) {
      error = e.toString();
      print(
          "FloatingAttachmentButton()''': Error while adding multiple images" +
              error);
    }
    if (!mounted) return;
    // set state of previous screen

    // remove setstae from here
    if (widget.newAnswerToPost.inputMultipleFiles != null) {
      files.forEach((element) {
        widget.newAnswerToPost.inputMultipleFiles.add(element);
      });
    } else {
      widget.newAnswerToPost.inputMultipleFiles = files;
    }

    // widget.newAnswerToPost.inputMultipleFiles = files;
    widget.callSetStateOfAddNewAnswerScreen();

//    setState(() {
//      _imageFile = File(filename);
//    });
  }

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(icons.length, (int index) {
        Widget child = new Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Interval(0.0, 1.0 - index / icons.length / 1.0,
                  curve: Curves.easeOut),
            ),
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white,
              mini: true,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(icons[index], color: Colors.black),
              ),
              onPressed: () async {
                if (index == 1) {
                  //await loadAssets();
                  // index one meaning attach photo
                  await loadMultipleImages();
                } else {
                  // await loadAssetsFile();
                  await loadMultipleFiles();
                  // index 0 meaning attach file
                }
              },
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          new FloatingActionButton(
            //backgroundColor: Colors.lightGreen[900],
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform:
                      new Matrix4.rotationZ(_controller.value * 0 * math.pi),
                  alignment: FractionalOffset.center,
                  child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.lightGreen[900], Color(0xFFA62A2A)])),
                      child: Transform.rotate(
                          angle: 45, child: Icon(Icons.attach_file))),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
    );
  }
}
