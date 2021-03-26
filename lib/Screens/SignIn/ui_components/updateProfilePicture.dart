import 'package:flutter/material.dart';
import 'dart:io';

// added dependencies
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:google_fonts/google_fonts.dart';

// app dependencies
import 'package:kisaanCorner/Screens/SignIn/services/ProfileImageInput.dart';

class UpdateProfilePicture extends StatefulWidget {
  final double imageRadius;
  final Size size;
  final String userImageURL;
  final String uid;
  final GlobalKey keyLoader;
  UpdateProfilePicture(
      this.size, this.imageRadius, this.userImageURL, this.uid, this.keyLoader);
  @override
  _UpdateProfilePictureState createState() =>
      _UpdateProfilePictureState(userImageURL);
}

class _UpdateProfilePictureState extends State<UpdateProfilePicture> {
  String userImageURL;
  _UpdateProfilePictureState(this.userImageURL);
  File _profileImageInput;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _imageInputModal();
      },
      child: Container(
          width: this.widget.size.height * 0.4,
          height: this.widget.size.height * 0.2,
          child: (userImageURL == null)
              ? Center(
                  child: Column(
                    children: [
                      (_profileImageInput == null)
                          ? CircularProfileAvatar(
                              '',
                              child: Icon(
                                Icons.person,
                                size: ((this.widget.size.height * 0.2) * 0.40),
                                color: Colors.grey,
                              ),
                              radius: ((this.widget.size.height * 0.2) * 0.40),
                              borderWidth: 0,
                              initialsText: Text("Add"),
                              elevation: 0,
                            )
                          : CircularProfileAvatar(
                              '',
                              child: Image.file(
                                _profileImageInput,
                                fit: BoxFit.fill,
                              ),
                              radius: ((this.widget.size.height * 0.2) * 0.40),
                              borderWidth: 0,
                              initialsText: Text("Add"),
                              elevation: 0,
                            ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "Change Profile Image",
                        style: GoogleFonts.poppins(color: Colors.grey),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      CircularProfileAvatar(
                        '$userImageURL',
                        radius: ((this.widget.size.height * 0.2) * 0.40),
                        borderWidth: 0,
                        initialsText: Text(
                          "Loading",
                          style: TextStyle(fontSize: 8.0),
                        ),
                        elevation: 0,
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      GestureDetector(
                        child: Text(
                          "ChangeProfile Image",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                        onTap: () {
                          _imageInputModal();
                        },
                      )
                    ],
                  ),
                )),
    );
  }

  Widget _imageInputModal() {
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
                    ProfileImageInput.imageFileFromCamera(context)
                        .then((value) => setState(() {
                              _profileImageInput = value;
                              userImageURL = null;
                            }));
                    //_getImage(ImageSource.camera, context);
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
                    // get the image file here
                    ProfileImageInput.imageFileFromGallery(context)
                        .then((value) => setState(() {
                              _profileImageInput = value;
                              userImageURL = null;
                            }));
                    //_getImage(ImageSource.gallery, context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
