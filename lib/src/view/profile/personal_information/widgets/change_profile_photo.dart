import 'package:flutter/material.dart';
import 'dart:io';

// added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// app dependencies
import 'package:kisaanCorner/utils/SizeConfig.dart';
import 'package:kisaanCorner/src/model/user/personal_information/personal_information_model.dart';

class ChangeProfilePhoto extends StatefulWidget {
  PersonalInformationModel personalInformationModel;
  String defaultProfileImageUrl;
  ChangeProfilePhoto(
      {this.defaultProfileImageUrl, this.personalInformationModel});
  @override
  _ChangeProfilePhotoState createState() => _ChangeProfilePhotoState();
}

class _ChangeProfilePhotoState extends State<ChangeProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: SizeConfig.screenWidth * 0.8,
          height: 130,
          child: (widget?.personalInformationModel?.profileImageUrl == null)
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (widget.personalInformationModel?.inputProfileImage ==
                              null)
                          ? CircularProfileAvatar(
                              '',
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                              radius: 50,
                              borderWidth: 0,
                              initialsText: Text("Add"),
                              elevation: 0,
                            )
                          : CircularProfileAvatar(
                              '',
                              child: Image.file(
                                widget
                                    .personalInformationModel.inputProfileImage,
                                fit: BoxFit.fill,
                              ),
                              radius: 50,
                              borderWidth: 0,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProfileAvatar(
                        '${widget.personalInformationModel.profileImageUrl}',
                        radius: 50,
                        borderWidth: 0,
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
                )),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 150.0,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Center(
                        child: Text(
                          'Camera',
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.black54),
                        ),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        File _selected = await ImagePicker.pickImage(
                          source: ImageSource.camera,
                        );
                        File _cropped = await ImageCropper.cropImage(
                            sourcePath: _selected.path,
                            aspectRatioPresets: [CropAspectRatioPreset.square],
                            androidUiSettings: AndroidUiSettings(
                                toolbarTitle: "Crop Image",
                                toolbarColor: Colors.lightGreen[900],
                                statusBarColor: Colors.lightGreen[900],
                                toolbarWidgetColor: Colors.white,
                                activeControlsWidgetColor: Colors.lightGreen[900]),
                            iosUiSettings: IOSUiSettings(
                              title: "Crop Image",
                            ));
                        // check if this is working for all cases
                        setState(() {
                          widget.personalInformationModel.inputProfileImage =
                              _cropped;
                          widget.personalInformationModel.profileImageUrl =
                              null;
                        });
                      },
                    ),
                    ListTile(
                      title: Center(
                        child: Text(
                          'Gallery',
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.black54),
                        ),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        File _selected = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        File _cropped = await ImageCropper.cropImage(
                            sourcePath: _selected.path,
                            aspectRatioPresets: [CropAspectRatioPreset.square],
                            androidUiSettings: AndroidUiSettings(
                                toolbarTitle: "Crop Image",
                                toolbarColor: Colors.lightGreen[900],
                                statusBarColor: Colors.lightGreen[900],
                                toolbarWidgetColor: Colors.white,
                                activeControlsWidgetColor: Colors.lightGreen[900]),
                            iosUiSettings: IOSUiSettings(
                              title: "Crop Image",
                            ));
                        setState(() {
                          widget.personalInformationModel.inputProfileImage =
                              _cropped;
                          widget.personalInformationModel.profileImageUrl =
                              null;
                        });
                      },
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
