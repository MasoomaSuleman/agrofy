import 'package:flutter/material.dart';
import 'dart:io';

// added dependencies
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/network/save_user_profile_to_firebase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

// app dependencies
import 'package:kisaanCorner/src/model/user/personal_information/personal_information_model.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';

class ProfilePhoto extends StatefulWidget {
  PersonalInformationModel personalInformationModel;
  String defaultProfileImageUrl;
  ProfilePhoto({this.personalInformationModel, this.defaultProfileImageUrl});
  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext Ccontext) {
    String _profileImageUrl =
        Provider.of<User>(Ccontext).personalInformation.profileImageUrl;
    String _userId = Provider.of<User>(Ccontext).userId;
    print("$_profileImageUrl");
    return Container(
      height: 90,
      width: 90,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: (_profileImageUrl == null)
                ? CircularProfileAvatar(
                    '',
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    ),
                    radius: 44,
                    borderWidth: 0,
                    elevation: 0,
                  )
                : CircularProfileAvatar(
                    '$_profileImageUrl' + '&time=${DateTime.now().toString()}',
                    radius: 44,
                    borderWidth: 0,
                    elevation: 0,
                    cacheImage: true,
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/images/edit_icon_profile_photo.svg',
                  width: 24,
                  height: 24,
                ),
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
                                      aspectRatioPresets: [
                                        CropAspectRatioPreset.square
                                      ],
                                      androidUiSettings: AndroidUiSettings(
                                          toolbarTitle: "Crop Image",
                                          toolbarColor: Colors.lightGreen[900],
                                          statusBarColor: Colors.lightGreen[900],
                                          toolbarWidgetColor: Colors.white,
                                          activeControlsWidgetColor:
                                              Colors.lightGreen[900]),
                                      iosUiSettings: IOSUiSettings(
                                        title: "Crop Image",
                                      ));
                                  // check if this is working for all cases
                                  //TODO: call a function to save only the profile photo
                                  widget.personalInformationModel
                                      .inputProfileImage = _cropped;
                                  widget.personalInformationModel
                                      .profileImageUrl = null;
                                  // call function to save the new image to firebase
                                  SaveUserProfileToFirebase _save =
                                      SaveUserProfileToFirebase();
                                  _save
                                      .saveNewProfileImageToFirestoreAndUserDetails(
                                          inputProfileImage: widget
                                              .personalInformationModel
                                              .inputProfileImage,
                                          context: Ccontext,
                                          userId: _userId)
                                      .then((value) {
                                    Provider.of<User>(Ccontext, listen: false)
                                        .setNewProfileImage(value);
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
                                      aspectRatioPresets: [
                                        CropAspectRatioPreset.square
                                      ],
                                      androidUiSettings: AndroidUiSettings(
                                          toolbarTitle: "Crop Image",
                                          toolbarColor: Colors.lightGreen[900],
                                          statusBarColor: Colors.lightGreen[900],
                                          toolbarWidgetColor: Colors.white,
                                          activeControlsWidgetColor:
                                              Colors.lightGreen[900]),
                                      iosUiSettings: IOSUiSettings(
                                        title: "Crop Image",
                                      ));
                                  setState(() {
                                    widget.personalInformationModel
                                        .inputProfileImage = _cropped;
                                    widget.personalInformationModel
                                        .profileImageUrl = null;
                                    SaveUserProfileToFirebase _save =
                                        SaveUserProfileToFirebase();
                                    _save
                                        .saveNewProfileImageToFirestoreAndUserDetails(
                                            inputProfileImage: widget
                                                .personalInformationModel
                                                .inputProfileImage,
                                            context: Ccontext,
                                            userId: _userId)
                                        .then((value) {
                                      // succefully uploaded image
                                      Provider.of<User>(Ccontext, listen: false)
                                          .setNewProfileImage(value);
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
