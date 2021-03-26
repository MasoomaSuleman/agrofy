import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageInput {
  static File _selected;
  static File cropped;
  static Future<File> imageFileFromCamera(BuildContext context) async {
    _selected = await ImagePicker.pickImage(source: ImageSource.camera);
    cropped = await ImageCropper.cropImage(
        sourcePath: _selected.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Crop Image",
        ),
        iosUiSettings: IOSUiSettings(
          title: "Crop Image",
        ));
    return cropped;
  }

  static Future<File> imageFileFromGallery(BuildContext context) async {
    _selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    cropped = await ImageCropper.cropImage(
        sourcePath: _selected.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Crop Image",
        ),
        iosUiSettings: IOSUiSettings(
          title: "Crop Image",
        ));
    return cropped;
  }
// make a static function to uplaod that image to firebase

}
