import 'package:flutter/material.dart';
import 'dart:io';

//added dependencies
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

//app dependencies
import '../provider/user_details.dart';

class UpdateProfilePicture extends StatefulWidget {
  final double imageRadius;
  final Size size;
  final String userImageURL;
  final String uid;
  final Function func;
  final GlobalKey keyLoader;
  UpdateProfilePicture(
      {this.size,
      this.imageRadius,
      this.userImageURL,
      this.uid,
      this.func,
      this.keyLoader});
  @override
  _UpdateProfilePictureState createState() =>
      _UpdateProfilePictureState(userImageURL, keyLoader);
}

class _UpdateProfilePictureState extends State<UpdateProfilePicture> {
  final _firestore = Firestore.instance;
  File _imageFile;
  String userImageURL;
  final GlobalKey _keyLoader;

  _UpdateProfilePictureState(this.userImageURL, this._keyLoader);

  void callSetSetate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // add if else statement for image preview
    //var imgaeURL = Provider.of<Userdetails>(context);
    // var userDetails = Provider.of<Userdetails>(context);
    var userDetails = Provider.of<UserDetails>(context);
    if (userDetails != null) {
      // print("userDetails not null!");
      String userImageURL = userDetails.user_image_url;
      // print("userImage: $userImageURL");
    } else {
      //print("userDetails Null!");
    }
    print("UpdateProfilePicture()''': image =${userDetails.user_image_url}");
    if (userImageURL == null) {
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
    } else {
      return FlatButton(
        onPressed: () {
          _imageInputModal(context);
        },
        child: CircularProfileAvatar(
          '$userImageURL',
          radius: (this.widget.size.height * 0.2) * this.widget.imageRadius,
          borderWidth: 0,
          initialsText: Text(
            "Loading",
            style: TextStyle(fontSize: 8.0),
          ),
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
    imageUploadToFirebase(cropped).whenComplete(() =>
        print("UpdateProfile{icture()''': image is added yo firestore DONE"));
  }

  Future<void> imageUploadToFirebase(File file) async {
    LoadingDialogs.showPLeaseWaitLoading(context, _keyLoader);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child(
            'profileImages/${DateTime.now().millisecondsSinceEpoch.toString()}');
    final StorageUploadTask task = firebaseStorageRef.putFile(file);
    var completedTask = await task.onComplete;
    String uplodedImageURL = await completedTask.ref.getDownloadURL();
    if (task.isSuccessful) {
//      print(
//          "//////////////////////////////////////////////////////////////////////////////////////");
//      print("UpdateProfilePicture()''': UID id ${this.widget.uid}");
//      print("UpdateProfilePicture()''': image URl is  $uplodedImageURL");

      _firestore
          .collection('userData')
          .document('${this.widget.uid}')
          .updateData({"profileImageURl": uplodedImageURL}).then((newValue) {
        UserDetails().setUserDetails(
          imageUrl: userImageURL,
        );
        callSetSetate();
        this.widget.func();
        print("UpadetProfilePicture()''':updating user profile image");
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        print("UpdateProfilePicture()''': update answer with image complete");
        AlertDialogs.showAlertDialogWithOKbutton(
            context, 'Profile Image Updated Updated Succesfully');
      }).catchError((e) {
        print("UpdateProfilePicture()''':updating user profile image failed");
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        AlertDialogs.showAlertDialogWithOKbutton(
            context, 'Something went Wrong');
      });
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      AlertDialogs.showAlertDialogWithOKbutton(context, 'Something went Wrong');
    }
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
}

class AlertDialogs {
  static void showAlertDialogWithOKbutton(BuildContext context, String text) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('$text'),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class LoadingDialogs {
  static Future<void> showPLeaseWaitLoading(
      BuildContext context, GlobalKey key) async {
    // the following statement is to use this loading dialog
    // initilize a global key from where the loading widget will be called
    //LoadingDialogs.showLoadingDialog(context, _keyLoader);
    // the following satement is to remove the loading dialog
    //Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Please Wait....",
                          style: GoogleFonts.poppins(color: Colors.white),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
