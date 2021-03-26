import 'package:flutter/material.dart';
import 'dart:io';

//added dependencies
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:provider/provider.dart';

//app dependencies
import '../provider/user_details.dart';

class AddProfilePicture extends StatefulWidget {
  final double imageRadius;
  final Size size;
  AddProfilePicture({this.size, this.imageRadius});
  @override
  _AddProfilePictureState createState() => _AddProfilePictureState();
}

class _AddProfilePictureState extends State<AddProfilePicture> {
  String _uploadedURL;
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    // add if else statement for image preview
    if (_uploadedURL == null) {
      return FlatButton(
        onPressed: () {
          _imageInputModal(context);
        },
        child: CircularProfileAvatar(
          '',
          radius: (this.widget.size.height * 0.2) * this.widget.imageRadius,
          borderWidth: 0,
          initialsText: Text("Add"),
          elevation: 0,
        ),
      );
    }
    // else for image preview
    else {
      return ChangeNotifierProvider<UserDetails>(
        create: (_) => UserDetails(),
        child: CircularProfileAvatar(
          '',
          radius: (this.widget.size.height * 0.2) * this.widget.imageRadius,
          borderWidth: 0,
          initialsText: Text("Add"),
          elevation: 0,
        ),
      );
    }
  }

  Future<void> _getImage(ImageSource source, BuildContext context) async {
    //PickedFile selected = await ImagePicker.getImage(source: source);
    File selected = await ImagePicker.pickImage(source: source);
    _cropImage();
    _imageFile = selected;
    _cropImage();
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Crop Image", lockAspectRatio: true),
        iosUiSettings:
            IOSUiSettings(title: "Crop Image", aspectRatioLockEnabled: true));
    //store the image to firestore now
    imageUploadToFirebase(cropped).then((value) {
      if (value != null) {
        print("AddProfile{icture()''': image is added");
        setState(() {
          _uploadedURL = value;
        });
      } else {
        print("AddProfile{icture()''': image no added show error here");
      }
    });
  }

  //the function to show below image input method
  void _imageInputModal(context) {
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
                  onTap: () {
                    // add camera image functionality here
                    Navigator.pop(context);
                    _getImage(ImageSource.camera, context);
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
                  onTap: () {
                    // add gallery image functionality here
                    Navigator.pop(context);
                    _getImage(ImageSource.gallery, context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<String> imageUploadToFirebase(File file) async {
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profileImages/${DateTime.now()}.jpg');
    final StorageUploadTask task = firebaseStorageRef.putFile(file);
    var completedTask = await task.onComplete;
    String uplodedImageURL = await completedTask.ref.getDownloadURL();
    if (task.isSuccessful) {
      return uplodedImageURL;
    } else
      return null;
//
//    final FirebaseStorage _storage =
//        FirebaseStorage(storageBucket: 'gs://gst-app-c30b5.appspot.com/');
//    StorageUploadTask _uploadTask = ;
//    String filePath = 'images/${DateTime.now()}.png';
  }
}

// upload to firestore

class ProfileImageUploader extends StatefulWidget {
  final File file;

  ProfileImageUploader({this.file});
  @override
  _ProfileImageUploaderState createState() => _ProfileImageUploaderState();
}

class _ProfileImageUploaderState extends State<ProfileImageUploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://gst-app-c30b5.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return Scaffold(
        body: StreamBuilder<StorageTaskEvent>(
            stream: _uploadTask.events,
            builder: (context, snapshot) {
              var event = snapshot?.data?.snapshot;
              double progressPercent = event != null
                  ? event.bytesTransferred / event.totalByteCount
                  : 0;
              return Column(
                children: [
                  Text('Uploading'),
                  if (_uploadTask.isPaused)
                    FlatButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: _uploadTask.resume,
                    ),
                  if (_uploadTask.isInProgress)
                    FlatButton(
                        onPressed: _uploadTask.pause, child: Icon(Icons.pause)),
                  LinearProgressIndicator(
                    value: progressPercent,
                  ),
                  Text("${(progressPercent * 100).toStringAsFixed(2)}% ")
                ],
              );
            }),
      );
    } else {
      return FlatButton.icon(
        onPressed: _startUpload,
        icon: Icon(Icons.cloud_upload),
      );
    }
  }
}
