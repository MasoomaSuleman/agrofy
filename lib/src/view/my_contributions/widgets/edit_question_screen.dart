import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:kisaanCorner/Models/pdf_model.dart';
import 'package:kisaanCorner/src/constants.dart';
import 'package:kisaanCorner/src/core/widgets/alert_dialogs.dart';
import 'package:path/path.dart' as fileUtil;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
//added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/Models/images_model.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/my_account_screen/widgets/custom_circular_profile_avatar.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
// app dependencies
import 'package:kisaanCorner/Models/Question.dart';
import 'package:kisaanCorner/utils/SizeConfig.dart';

var _count = 0;
var _imagesCount = 0;
// For multiple image picker
List<File> _multipleImagesFiles = new List();
String _path;
Map<String, String> _paths;
String _extension;
FileType _pickType;
List<String> questionImageUrls = new List();
int _selectedRadio;

List<File> questionImagesList = new List();

class EditQuestionScreen extends StatefulWidget {
  final DocumentSnapshot questionSnapshot;
  EditQuestionScreen({
    @required this.questionSnapshot
    });
  @override
  EditQuestionScreenState createState() => EditQuestionScreenState();
}

class EditQuestionScreenState extends State<EditQuestionScreen>
    with TickerProviderStateMixin {
  List<Asset> images = List<Asset>();
  List<ImagesModel> questionImagesList = List<ImagesModel>();
  bool _notsure = false;
  final Firestore _firestore = Firestore.instance;
  TextEditingController _questionTextEditingController ;
  AnimationController _controller;
  AlertDialogs _alertDialogs = AlertDialogs();
  int category;
  String subcategory;
  var questionPdf;
  List questionUploadedImages;
  static const List<IconData> icons = const [Icons.file_copy, Icons.image];
  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _questionTextEditingController =TextEditingController(text: widget.questionSnapshot.data['questionText']);
    check = widget.questionSnapshot.data['category'];
    category =widget.questionSnapshot.data['category'];
    _selectedRadio = check;
    subcategory =widget.questionSnapshot.data['subcategory'];
    questionPdf = widget.questionSnapshot.data['questionPdf'];
    questionUploadedImages = widget.questionSnapshot.data['questionImages'];
    // TODO: implement initState
    super.initState();
  }

  Widget buildMainCategory(String name, Function action, bool ac, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text('$name',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          Radio(
              value: index,
              groupValue: _selectedRadio,
              activeColor: Colors.lightGreen[900],
              onChanged: action),
        ],
      ),
    );
  }

  Widget buildSubCategory(String name, Function action, bool ac, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8.0, 8.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text('$name',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          Radio(
              //activeColor: Colors.white,

              value: index,
              groupValue: _selectedRadio,
              activeColor: Colors.lightGreen[900],
              onChanged: action),
        ],
      ),
    );
  }

  Widget buildMainSubCategory(String name, Function action, bool ac) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text('$name ',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          IconButton(
            icon: Icon(ac
                ? Icons.arrow_drop_up_outlined
                : Icons.arrow_drop_down_outlined),
            onPressed: action,
          )
        ],
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

  Widget _buildPreviewFile() {
    if (_imageFile == null) {
      return Container();
    } else {
      var ext = fileUtil.extension(_imageFile.path);
      questionPdf=null;
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
  Widget _buildUploadedPreviewFile() {
    if (questionPdf == null) {
      return Container();
    } else {
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
                  "${questionPdf['name']}",
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
                    questionPdf = null;
                  });
                })
          ],
        ),
      );
    }
  }

  Widget buildUploadedImageCarousel() {
    if (questionUploadedImages!=null&& questionUploadedImages.isNotEmpty)
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: questionUploadedImages.length,
        itemBuilder: (context, index) {
          print("showing");
          String asset = questionUploadedImages[index]['url'];

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: <Widget>[
                Image(
                  image:NetworkImage(
                  asset,
                ),
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
                                questionUploadedImages.removeAt(index);
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
        
      );
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

  @override
  Widget build(BuildContext context) {
    
    print(questionUploadedImages);
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
        title: Text(
          "Edit Question",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () async {
                String questionString =
                    _questionTextEditingController.text.toString().trim();
                if (questionString == null || questionString == "") {
                  qEmptyAlertDialog();
                } else if (questionString.length < 10) {
                  lessWordsAlertDialog();
                } else if (check == null || _selectedRadio == null) {
                  noCategorySelectedDialog();
                } else {
                  _onQUpLoading(context);
                  // TODO Post Question
                  int timeInSeconds = DateTime.now().minute;
                  // String questionString =
                  //     _questionTextEditingController.text.toString();
                  print("Question String: " + questionString);
                  await postAQuestion(
                      questionString: questionString,
                      );
                  //postQuestion(questionString, "", timeInSeconds);
                  // if (isQuploading) {
                  //   Center(child: SpinKitChasingDots());
                  // } else {
                  //   _showQuestionAddedAlertDialog();
                  // }
                  // Navigator.pop(context);
                }
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
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListTile(
              leading: CustomCircularProfileAvatar(25),
              title: Text(
                "${widget.questionSnapshot.data['questionByName']}",
                style: GoogleFonts.poppins(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                "${widget.questionSnapshot.data['questionByProfession']}",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
          ),
          check != null && check == -1
              ? Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                    trailing: IconButton(
                      iconSize: 11,
                      color: Colors.black,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          check = null;
                          category = null;
                          _selectedRadio = null;
                        });
                      },
                    ),
                    title: Text(
                      'Not sure',
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 16),
                    ),
                  ),
                )
              : check != null && check != -1
                  ? Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        trailing: IconButton(
                          iconSize: 11,
                          color: Colors.black,
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              check = null;
                              category = null;
                              _selectedRadio = null;
                            });
                          },
                        ),
                        title: Text(
                          categories[category].name,
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 16),
                        ),
                        subtitle: subcategory != null
                            ? Text(
                                subcategory,
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 12),
                              )
                            : null,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        trailing: IconButton(
                          iconSize: 18,
                          color: Colors.lightGreen[900],
                          icon: Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                        scrollable: true,
                                        titlePadding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 0.0),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 0.0),
                                        backgroundColor: Colors.white,
                                        title: Container(
                                            height: 63,
                                            width: double.infinity,
                                            color: Color(0xFFF5F5F5),
                                            child: ListTile(
                                                leading: Icon(Icons.search),
                                                trailing: IconButton(
                                                    icon: Icon(Icons.close,
                                                        color: Colors.black,
                                                        size: 16),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    }),
                                                title: Text(
                                                  'Search',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ))),
                                        content: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 8, 10, 8),
                                          child: SingleChildScrollView(
                                              child: Column(children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('Select tag',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('Not sure ',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .error_outline_rounded,
                                                              color: Colors.red,
                                                              size: 6),
                                                        ],
                                                      )),
                                                  Radio(
                                                      value: -1,
                                                      groupValue:
                                                          _selectedRadio,
                                                      activeColor:
                                                          Colors.lightGreen[900],
                                                      onChanged: (val) {
                                                        setState(() {
                                                          _selectedRadio = val;
                                                          category = val;
                                                        });
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      }),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child:
                                                  Divider(color: Colors.grey),
                                            ),
                                            for (int i = 0;
                                                i < categories.length;
                                                i++)
                                              if (categories[i].subcategory ==
                                                  null)
                                                buildMainCategory(
                                                    categories[i].name, (val) {
                                                  setState(() {
                                                    categories[i].isChecked =
                                                        !categories[i]
                                                            .isChecked;
                                                    _selectedRadio = val;
                                                    category = i;
                                                    subcategory = null;
                                                  });

                                                  print(_selectedRadio);
                                                  Navigator.of(context)
                                                      .pop(true);
                                                }, categories[i].isChecked, i)
                                              else if (!categories[i].isChecked)
                                                buildMainSubCategory(
                                                    categories[i].name,
                                                    () => setState(() {
                                                          categories[i]
                                                                  .isChecked =
                                                              !categories[i]
                                                                  .isChecked;
                                                        }),
                                                    categories[i].isChecked)
                                              else
                                                for (int j = -1;
                                                    j <
                                                        categories[i]
                                                            .subcategory
                                                            .length;
                                                    j++)
                                                  if (j == -1)
                                                    buildMainSubCategory(
                                                        categories[i].name,
                                                        () => setState(() {
                                                              categories[i]
                                                                      .isChecked =
                                                                  !categories[i]
                                                                      .isChecked;
                                                            }),
                                                        categories[i].isChecked)
                                                  else
                                                    buildSubCategory(
                                                        categories[i]
                                                            .subcategory[j]
                                                            .name, (val) {
                                                      setState(() {
                                                        categories[i]
                                                                .subcategory[j]
                                                                .isChecked =
                                                            !categories[i]
                                                                .subcategory[j]
                                                                .isChecked;
                                                        _selectedRadio = val;
                                                        category = i;
                                                        subcategory =
                                                            categories[i]
                                                                .subcategory[j]
                                                                .name;
                                                      });

                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                        categories[i]
                                                            .subcategory[j]
                                                            .isChecked,
                                                        i * (j + 2) * 4),
                                          ])),
                                        ));
                                  });
                                }).then((value) => setState(() {
                                  check = _selectedRadio;
                                }));
                          },
                        ),
                        title: Text(
                          "Add  Category",
                          style: GoogleFonts.poppins(color: Colors.black),
                        ),
                      ),
                    ),
          // TODO: add image preview here if iamge if uploaded

          Padding(
            padding: EdgeInsets.all(1.0),
            child: Divider(color: Colors.grey),
          ),

          askQuestionWidget(),
          if(questionPdf!=null&&_imageFile==null)
          Padding(
          padding: const EdgeInsets.all(8.0), child: _buildUploadedPreviewFile()),
          
          Padding(
              padding: const EdgeInsets.all(8.0), child: _buildPreviewFile()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildUploadedImageCarousel()
            // child: buildGridView(),
          ),
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

  void _onQUpLoading(context) {
    // if (isQuploading) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("UpLoading"),
            ],
          ),
        );
      },
    );
    // }
    // else {
    //   Navigator.pop(context);
    // }
    // new Future.delayed(new Duration(seconds: 3), () {
    //   Navigator.pop(context); //pop dialog
    //   // _login();
    // });
  }

  Widget askQuestionWidget() {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 100,
      // height: SizeConfig.blockSizeVertical * 75,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: _questionTextEditingController,
                
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff202020),
                    fontSize: 16),
                    
                decoration: InputDecoration(
                
                  border: InputBorder.none,
                 // hintText: "Have any question ? Ask here.",
                ),
                scrollPadding: EdgeInsets.all(10.0),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: false,
              ),
            ),
           
          ],
        ),
      ),
    );
  }

  bool isQuploading = false;
 
  PdfModel file;
  Future postAQuestion({String questionString}) async {
    // setState(() {
    //   isQuploading = true;
    // });
    if (_imageFile != null) {
      var f = await saveFile(_imageFile);
      file = f;
      print(file);
    }
    for (var i = 0; i < images.length; i++) {
      var img = await saveImage(images[i]);
      questionImagesList.add(img);
    }
    Question _questionToPass = Question();
     if(questionPdf!=null)
    _questionToPass.questionPdf =questionPdf;
    _questionToPass.questionByName = widget.questionSnapshot.data['questionByName'];
    _questionToPass.questionByUID = widget.questionSnapshot.data['questionByUID'];
    _questionToPass.questionByProfession =
    widget.questionSnapshot.data['questionByProfession'];
    _questionToPass.questionByImageURL =
    widget.questionSnapshot.data['questionByImageURL'];
    _questionToPass.questionByOrganization =
    widget.questionSnapshot.data['questionByOrganization'];
    _questionToPass.questionText = questionString;
    _questionToPass.questionTimeStamp = DateTime.now().toString();
    List newList =questionImagesList.map((e) => e.toJson()).toList();
    if(questionUploadedImages!=null&&questionUploadedImages.isNotEmpty)
    newList.addAll(questionUploadedImages);
      _questionToPass.questionImages =newList.toList();
    _questionToPass.category = category;
    _questionToPass.subcategory = subcategory;
    //TODO: add images functionaity
    if (file != null) _questionToPass.questionPdf = file.toJson();
    print("Posting question...");
    await _firestore
        .collection('questionData')
        .document(widget.questionSnapshot.documentID).updateData(_questionToPass.toMap())
        .then((value) {
      print(
          "AskQuestionScreen()''': New question Is updated successfully id: ${widget.questionSnapshot.documentID}");
      // for (var i = 0; i < images.length; i++) {
      //   var img = await saveImage(images[i]);
      //   questionImagesList.add(img);
      // }
      // addQuestionImages(value.documentID, questionImagesList);

      _showQuestionAddedAlertDialog();
    }).catchError((e) => print(
            "AskQuestionScreen()''': Error while addidng a new question $e"));
    // setState(() {
    //   isQuploading = false;
    // });
  }

  // addQuestionImages(String id, List<ImagesModel> images) {
  //   Firestore.instance.collection("questionData").document(id).setData(
  //     {
  //       "questionImages": images.map((e) => e.toJson()).toList(),
  //     },
  //   );
  // }

  Future<void> openImagePicker() async {
    try {
      _multipleImagesFiles = null;
      _paths = await FilePicker.getMultiFilePath(
          type: FileType.custom,
          allowedExtensions: ['jpeg', 'jpg', 'png'],
          allowCompression: true);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    print(_multipleImagesFiles.length);
    if (!mounted) return;
  }

  uploadToFirebase(String questionID) {
    _paths.forEach(
        (fileName, filePath) => {upload(fileName, filePath, questionID)});
    _imagesCount = _paths.length;
  }

  upload(String fileName, String filePath, String questionID) async {
    questionImageUrls.clear();
    _extension = fileName.toString().split('.').last;
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child("questionImages").child(fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
    );

    var completedTask = await uploadTask.onComplete;
    String uplodedImageURL = await completedTask.ref.getDownloadURL();
    questionImageUrls.add(uplodedImageURL);
    Firestore.instance.collection("questionData").document(questionID).setData(
        {"_questionImages": FieldValue.arrayUnion(questionImageUrls)},
        merge: true).whenComplete(() {
      _count++;

      if (_imagesCount == 1) {
        _paths.clear();
        questionImageUrls.clear();
        Navigator.of(context).pop();
      } else if (_imagesCount == _count) {
        _paths.clear();
        questionImageUrls.clear();
        Navigator.of(context).pop();
      }
    }).catchError((error) {
      print("Error: $error");
    });
  }

  void noCategorySelectedDialog() {
    _alertDialogs.showAlertDialogWithOKbutton(context, "Please select a valid category", 1);
    
  }

  void _showQuestionAddedAlertDialog() {
    
    _alertDialogs.showAlertDialogWithOKbutton(context, "Your Question is successfully updated ", 3);
  }

  void qEmptyAlertDialog() {
    _alertDialogs.showAlertDialogWithOKbutton(context, "Question can't be empty", 1);
    
  }

  void lessWordsAlertDialog() {
    _alertDialogs.showAlertDialogWithOKbutton(context, "Question is too short. Min characters required : 10", 1);
    
  }
}
