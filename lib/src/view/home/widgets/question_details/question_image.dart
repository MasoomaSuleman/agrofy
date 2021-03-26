import 'package:flutter/material.dart';

// added dependencies
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kisaanCorner/Screens/QuestionDetails/ui_components/FullScreenAnswerImageView.dart';

// app dependencies

class QuestionImage extends StatelessWidget {
  final List questionImagesList;
  final Size size;
  final int index;
  QuestionImage({this.questionImagesList, this.size,this.index});
  @override
  Widget build(BuildContext context) {
   
      return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
        child: GestureDetector(
          onTap: (){
             Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FullScreenAnswerImageView(questionImagesList[index]['url'])));
          },
                  child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child:CachedNetworkImage(
            width:double.infinity,
            height:170,
            imageUrl: questionImagesList[index]['url'],
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit:  BoxFit.fill ,
          ),
          ),
        )
      );
  }
}
