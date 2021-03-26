import 'package:flutter/material.dart';

// added dependencies
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionImages extends StatelessWidget {
  final List<dynamic> _questionImagesList;
  final Size _size;
  QuestionImages(this._questionImagesList, this._size);
  @override
  Widget build(BuildContext context) {
    if (_questionImagesList.length == 0) {
      return Container();
    } else if (_questionImagesList.length == 1) {
      // return only one image
      return Container(
        height: _size.height * 0.2,
        width: _size.width - 20.0,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: _questionImagesList[0]['url'],
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      );
    } else if (_questionImagesList.length == 2) {
      // return the two images at once
      return Container(
        height: _size.height * 0.2,
        width: _size.width - 20.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: CachedNetworkImage(
                width: (_size.width - 22.0) / 2,
                height: _size.height * 0.2,
                imageUrl: _questionImagesList[0]['url'],
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              width: (_size.width - 22.0) / 2,
              height: _size.height * 0.2,
              child: CachedNetworkImage(
                imageUrl: _questionImagesList[1]['url'],
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ],
        ),
      );
    } else if (_questionImagesList.length == 3) {
      // return the three images in a column and a row
      return Container(
        height: _size.height * 0.2,
        width: _size.width - 20.0,
        child: Row(
          children: [
            Container(
                width: (_size.width - 20.0) / 2,
                height: _size.height * 0.2,
                child: Column(
                  children: [
                    Container(
                      height: _size.height * 0.2 * 0.5,
                      child: CachedNetworkImage(
                        imageUrl: _questionImagesList[0]['url'],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Container(
                      height: _size.height * 0.2 * 0.5,
                      child: CachedNetworkImage(
                        imageUrl: _questionImagesList[1]['url'],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
                  ],
                )),
            Container(
              height: _size.height * 0.2,
              width: (_size.width - 20.0) / 2,
              child: CachedNetworkImage(
                imageUrl: _questionImagesList[2]['url'],
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )
          ],
        ),
      );
    } else
      return Container(
        height: _size.height * 0.2,
        width: _size.width - 20.0,
        child: Row(
          children: [
            Container(
              height: _size.height * 0.2,
              width: ((_size.width - 20) / 3) - 4,
              child: CachedNetworkImage(
                imageUrl: _questionImagesList[0]['url'],
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              height: _size.height * 0.2,
              width: ((_size.width - 20) / 3) - 4,
              child: CachedNetworkImage(
                imageUrl: _questionImagesList[1]['url'],
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              height: _size.height * 0.2,
              width: ((_size.width - 20) / 3) - 4,
              child: Stack(
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: _questionImagesList[2]['url'],
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: Container(
                      height: _size.height * 0.2,
                      width: ((_size.width - 20) / 3) - 4,
                      color: Colors.black54,
                      child: Center(
                        child: Text(
                          "+ ${_questionImagesList.length - 3}",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }
}
