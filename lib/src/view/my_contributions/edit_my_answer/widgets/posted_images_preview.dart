import 'package:flutter/material.dart';

import 'package:kisaanCorner/src/core/widgets/alert_dialogs.dart';
import 'package:kisaanCorner/src/model/answer/image_model.dart';
import 'package:kisaanCorner/src/network/edit_answer_in_firebase.dart';

class PostedImagesPreview extends StatefulWidget {
  final List<ImageModel> postedImages;
  final Size size;
  final String answerId;
  PostedImagesPreview({this.postedImages, this.size, this.answerId});
  @override
  _PostedImagesPreviewState createState() => _PostedImagesPreviewState();
}

class _PostedImagesPreviewState extends State<PostedImagesPreview> {
  @override
  Widget build(BuildContext context) {
    if (widget.postedImages == null) {
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
              itemCount: widget.postedImages.length,
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
                            EditAnswerInFirebase _editAnswer =
                                EditAnswerInFirebase();
                            _editAnswer.deleteAnswerImageFromList(
                                widget.answerId, widget.postedImages[index]);
                            setState(() {
                              widget.postedImages.removeAt(index);

                              // call firebase function also
                              // remove at array
                            });
                            AlertDialogs _alert = AlertDialogs();
                            _alert.showAlertDialogWithoutButton(
                                context: context,
                                text: 'Image deleted from this answer.',
                                popCount: 1);
                          },
                        ),
                      ),
                      Container(
//            height: 100,
//            width: 200,
                        child: Image(
                          width: (widget.size.width * 0.6),
                          height: 100,
                          image:
                              NetworkImage('${widget.postedImages[index].url}'),
                        ),
//                        AssetThumb(
//                            width: (widget.size.width * 0.6).toInt(),
//                            height: 100,
//                            asset: widget.inputMultipleImages[index]),

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
