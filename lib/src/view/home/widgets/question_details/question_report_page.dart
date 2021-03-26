import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as fileUtil;
import 'dart:math' as math;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/Models/images_model.dart';
import 'package:kisaanCorner/Models/pdf_model.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:provider/provider.dart';
class ReportQuestion extends StatefulWidget {
  final DocumentSnapshot questionData;
  ReportQuestion({
  @required  this.questionData});
  @override
  _ReportQuestionState createState() => _ReportQuestionState();
}

class _ReportQuestionState extends State<ReportQuestion>with TickerProviderStateMixin {
  AnimationController _controller;
  List<Asset> images = List<Asset>();
  int category;
  String subcategory;
  static const List<IconData> icons = const [Icons.file_copy, Icons.image];
  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // TODO: implement initState
    super.initState();
  }
    Widget _buildPreviewImage() {
      if (_imageFile == null) {
        return Container();
      } else {
        var ext = fileUtil.extension(_imageFile.path);
        print(ext);
        print(fileUtil.basename(_imageFile.path));
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFF5F5F5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "${fileUtil.basename(_imageFile.path)}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _imageFile = null;
                    });
                  })
            ],
          ),
        );
      }
    }

    Widget buildCarousel() {
      if (images != null)
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (context, index) {
            Asset asset = images[index];

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: <Widget>[
                  AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  ),
                  Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: Container(
                        height: 30,
                        width: 30,
                        color: Colors.white,
                        child: Center(
                          child: GestureDetector(
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                              onTap: () {
                                setState(() {
                                  images = images
                                      .where((element) =>
                                          element.identifier != asset.identifier)
                                      .toList();
                                });
                              }),
                        ),
                      ))
                ],
              ),
            );
          },
        );
      else
        return Container(
          child: Center(
            child: Icon(
              Icons.image,
              size: 50,
              color: Colors.black,
            ),
          ),
        );
    }
    Widget buildGridView() {
      if (images != null)
        return GridView.count(
          crossAxisCount: 3,
          children: List.generate(images.length, (index) {
            Asset asset = images[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: <Widget>[
                  AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  ),
                  Positioned(
                      child: Container(
                    height: 30,
                    width: 30,
                    color: Colors.black.withOpacity(.5),
                    child: Center(
                      child: GestureDetector(
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              images = images
                                  .where((element) =>
                                      element.identifier != asset.identifier)
                                  .toList();
                            });
                          }),
                    ),
                  ))
                ],
              ),
            );
          }),
        );
      else
        return Container(
          child: Center(
            child: Icon(
              Icons.image,
              size: 50,
              color: Colors.black,
            ),
          ),
        );
    }

    Future<void> loadAssets() async {
      List<Asset> resultList;
      String error;

      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 300,
          enableCamera: true,
        );
      } on Exception catch (e) {
        error = e.toString();
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;
      if (resultList != null) {
        setState(() {
          resultList.addAll(images);
          images = resultList;
        });
      }
    }

    int check;
    File _imageFile;
    Future<void> loadAssetsFile() async {
      var filename;
      String error;

      try {
        filename = await FilePicker.getFilePath(
            type: FileType.custom,
            allowedExtensions: [
              'pdf',
              'doc',
              'ppt',
              'xlsx',
              'docx',
              'csv',
              'pptx'
            ]);
      } on Exception catch (e) {
        error = e.toString();
      }
      if (!mounted) return;
      setState(() {
        _imageFile = File(filename);
      });
    }

    Future<PdfModel> saveFile(File file) async {
      List<int> asset = file.readAsBytesSync();
      var ext = fileUtil.extension(file.path);
      print(file.path);
      print(ext);
      var now = DateTime.now().millisecondsSinceEpoch;
      StorageReference reference =
          FirebaseStorage.instance.ref().child('$now.pdf');
      StorageUploadTask uploadTask = reference.putData(asset);
      final StreamSubscription<StorageTaskEvent> streamSubscription =
          uploadTask.events.listen((event) {
        // You can use this to notify yourself or your user in any kind of way.
        // For example: you could use the uploadTask.events stream in a StreamBuilder instead
        // to show your user what the current status is. In that case, you would not need to cancel any
        // subscription as StreamBuilder handles this automatically.

        // Here, every StorageTaskEvent concerning the upload is printed to the logs.
        print(
            "${(event.snapshot.bytesTransferred * 100 / event.snapshot.totalByteCount)}%");
        print('EVENT ${event.type}');
      });
      var storageSnapshot = await uploadTask.onComplete;
      // Cancel your subscription when done.
      streamSubscription.cancel();
      var url = await storageSnapshot.ref.getDownloadURL();
      print("images uploaded==================>>>>>");
      return PdfModel(
          url: url,
          type: ext,
          name: fileUtil.basename(_imageFile.path),
          size: file.lengthSync());
    }

    Future<ImagesModel> saveImage(Asset asset) async {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      var now = DateTime.now().millisecondsSinceEpoch;
      StorageReference ref = FirebaseStorage.instance.ref().child("$now.jpg");
      StorageUploadTask uploadTask = ref.putData(imageData);
      final StreamSubscription<StorageTaskEvent> streamSubscription =
          uploadTask.events.listen((event) {
        // You can use this to notify yourself or your user in any kind of way.
        // For example: you could use the uploadTask.events stream in a StreamBuilder instead
        // to show your user what the current status is. In that case, you would not need to cancel any
        // subscription as StreamBuilder handles this automatically.

        // Here, every StorageTaskEvent concerning the upload is printed to the logs.
        print(
            "${(event.snapshot.bytesTransferred * 100 / event.snapshot.totalByteCount)}%");
        print('EVENT ${event.type}');
      });
      var storageSnapshot = await uploadTask.onComplete;
  // Cancel your subscription when done.
      streamSubscription.cancel();
      var url = await storageSnapshot.ref.getDownloadURL();
      print("images uploaded==================>>>>>");
      return ImagesModel(id: "$now", url: url);
    }
  @override
  Widget build(BuildContext context) {
    User _currentUser = Provider.of<User>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(true);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_back,
              color: CupertinoColors.white,
            ),
          ),
        ),
        
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () async {
               
              },
              child: Center(
                child: Text(
                  "Post",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          // add name, profession and the image url here
          SizedBox(
            height: 18.0,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              Text("REPORT",
              style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.lightGreen[900],
              ),),
              
              
            ],
          ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0,MediaQuery.of(context).size.width*0.70, 1.0),
            child: Divider(
              color: Colors.lightGreen[900],
              thickness: 1,
            )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 15.0, 15, 0),
            child: RichText(
              maxLines: 30,
              overflow: TextOverflow.ellipsis,
              text:
              TextSpan(
                text:  '${widget.questionData.data['questionText']}',
                 style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              )
            ) 
          ),

          Padding(
              padding: const EdgeInsets.all(8.0), child: _buildPreviewImage()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildCarousel(),
            // child: buildGridView(),
          ),
        ],
      ),
      floatingActionButton: Column(
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
                    /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainUpload()));*/
                    // await openImagePicker();
                    await loadAssets();
                  } else {
                    await loadAssetsFile();
                  }
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            new FloatingActionButton(
              backgroundColor: Colors.lightGreen[900],
              heroTag: null,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Transform(
                    transform:
                        new Matrix4.rotationZ(_controller.value * 0 * math.pi),
                    alignment: FractionalOffset.center,
                    child: Icon(Icons.attach_file),
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
      ),
      
    );
  }
}