import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput {
//  static Future<File> takeImageInput(BuildContext context) {
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext context) {
//          return Container(
//            height: 150.0,
//            padding: EdgeInsets.all(10.0),
//            child: Column(
//              children: <Widget>[
//                ListTile(
//                  title: Center(
//                    child: Text(
//                      'Camera',
//                      style: TextStyle(
//                          color: Theme.of(context).primaryColor,
//                          fontSize: 20.0),
//                    ),
//                  ),
//                  onTap: () async {
//                    // add camera image functionality here
//                    Navigator.pop(context);
//                    File selected =
//                        await ImagePicker.pickImage(source: ImageSource.camera);
//                    File cropped = await ImageCropper.cropImage(
//                        sourcePath: selected.path,
//                        androidUiSettings: AndroidUiSettings(
//                          toolbarTitle: "Crop Image",
//                        ),
//                        iosUiSettings: IOSUiSettings(
//                          title: "Crop Image",
//                        ));
//                    // now return cropped;
//                    return cropped;
//                  },
//                ),
//                ListTile(
//                  title: Center(
//                    child: Text(
//                      'Gallery',
//                      style: TextStyle(
//                          color: Theme.of(context).primaryColor,
//                          fontSize: 20.0),
//                    ),
//                  ),
//                  onTap: () async {
//                    // add gallery image functionality here
//                    Navigator.pop(context);
//                    //PickedFile selected = await ImagePicker.getImage(source: source);
//                    File selected = await ImagePicker.pickImage(
//                        source: ImageSource.gallery);
//                    File cropped = await ImageCropper.cropImage(
//                        sourcePath: selected.path,
//                        androidUiSettings: AndroidUiSettings(
//                          toolbarTitle: "Crop Image",
//                        ),
//                        iosUiSettings: IOSUiSettings(
//                          title: "Crop Image",
//                        ));
//                    return cropped;
//                  },
//                ),
//              ],
//            ),
//          );
//        });
//  }

  static Future<File> imageFileFromCamera() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.camera);
    File cropped = await ImageCropper.cropImage(
        sourcePath: selected.path,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Crop Image",
        ),
        iosUiSettings: IOSUiSettings(
          title: "Crop Image",
        ));
    return cropped;
  }

  static Future<File> imageFileFromGallery() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    File cropped = await ImageCropper.cropImage(
        sourcePath: selected.path,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Crop Image",
        ),
        iosUiSettings: IOSUiSettings(
          title: "Crop Image",
        ));
    return cropped;
  }
}
