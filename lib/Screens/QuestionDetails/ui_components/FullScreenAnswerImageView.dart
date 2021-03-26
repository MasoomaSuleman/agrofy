import 'package:flutter/material.dart';

class FullScreenAnswerImageView extends StatelessWidget {
  final String answerImageURL;
  FullScreenAnswerImageView(this.answerImageURL);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Hero(
          tag: '${this.answerImageURL}',
          child: Center(
            child: Image.network(
              '${this.answerImageURL}',
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
              errorBuilder: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
