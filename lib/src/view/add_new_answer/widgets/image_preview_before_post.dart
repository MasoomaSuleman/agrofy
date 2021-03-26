import 'package:flutter/material.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePreviewBeforePost extends StatefulWidget {
  final Size size;
  final List<Asset> inputMultipleImages;
  ImagePreviewBeforePost({this.inputMultipleImages, this.size});

  @override
  _ImagePreviewBeforePostState createState() => _ImagePreviewBeforePostState();
}

class _ImagePreviewBeforePostState extends State<ImagePreviewBeforePost> {
  @override
  Widget build(BuildContext context) {
    if (widget.inputMultipleImages == null) {
      return Container();
    } else
      return Container(
          width: widget.size.width - 40,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Color(0X1A000000),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(3, 2))
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.inputMultipleImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 2,
                        right: 10,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              widget.inputMultipleImages.removeAt(index);
                            });
                          },
                        ),
                      ),
                      Container(
//            height: 100,
//            width: 200,
                        child: AssetThumb(
                            width: (widget.size.width * 0.6).toInt(),
                            height: 100,
                            asset: widget.inputMultipleImages[index]),
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: ,
//                fit: BoxFit.fill
//              ),
//            ),
                      )
                    ],
                  ),
                );
//
//                  ImagePreviewBeforePost(
//                  size: _size,
//                  assetImage: newAnswerToPost
//                      .inputMultipleImages[index],
//                  removeOneImageFromInputList: () {},
//                );
              },
            ),
          )
//                        Container(
//                          // this is for image preview container
//                          height: 10,
//                          width: 20,
//                          color: Colors.red,
//                        ),
          );
  }
}
