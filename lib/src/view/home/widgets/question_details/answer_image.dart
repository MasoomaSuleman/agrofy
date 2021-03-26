import 'package:flutter/material.dart';

// added dependencies
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kisaanCorner/Screens/QuestionDetails/ui_components/FullScreenAnswerImageView.dart';

// app dependencies

class AnswerImage extends StatelessWidget {
  final String url;
  final  size;
  AnswerImage({this.url, this.size});
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
                    FullScreenAnswerImageView(url)));
          },
                  child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child:CachedNetworkImage(
            width:double.infinity,
            height:170,
            imageUrl: url,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit:  BoxFit.fill ,
          ),
          ),
        )
      );
  }
}
