import 'package:flutter/material.dart';

// added dependencies
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

// app dependencies

class QuestionImages extends StatelessWidget {
  final List questionImagesList;
  final Size size;
  QuestionImages({this.questionImagesList, this.size});
  @override
  Widget build(BuildContext context) {
    if (questionImagesList.length == 0) {
      return Container();
    } else if (questionImagesList.length == 1) {
      // return only one image
      return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
        child: Container(
          padding: EdgeInsets.all(0.5),
          height: 134,
          width: size.width - 60.0,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0x26707070), width: 0.5)),
          child: Center(
            child: CachedNetworkImage(
              width: size.width - 61.0,
              height: 134,
              imageUrl: questionImagesList[0]['url'],
              placeholder: (context, url) => Center(child:CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    } else if (questionImagesList.length == 2) {
      // return the two images at once
      return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
        child: Container(
          padding: EdgeInsets.all(0.5),
          height: 135,
          width: size.width - 60.0,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0x26707070), width: 0.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: ((size.width - 60.0) / 2) - 2,
                height: 133,
                child: CachedNetworkImage(
                  imageUrl: questionImagesList[0]['url'],
                  placeholder: (context, url) => Center(child:CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 1,
              ),
              Container(
                width: ((size.width - 60.0) / 2) - 9,
                height: 134,
                child: CachedNetworkImage(
                    imageUrl: questionImagesList[1]['url'],
                    placeholder: (context, url) => Center(child:CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fill),
              ),
            ],
          ),
        ),
      );
    } else if (questionImagesList.length == 3) {
      // return the three images in a column and a row
      return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
        child: Container(
          padding: EdgeInsets.all(0.5),
          height: 135,
          width: size.width - 60.0,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0x26707070), width: 0.5)),
          child: Row(
            children: [
              Container(
                  width: ((size.width - 60.0) / 2) - 2,
                  height: 133,
                  child: Column(
                    children: [
                      Container(
                        height: 133 * 0.5,
                        child: CachedNetworkImage(
                          imageUrl: questionImagesList[0]['url'],
                          placeholder: (context, url) =>
                              Center(child:CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        height: 133 * 0.5,
                        child: CachedNetworkImage(
                          imageUrl: questionImagesList[1]['url'],
                          placeholder: (context, url) =>
                              Center(child:CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  )),
              SizedBox(
                width: 1,
              ),
              Container(
                height: 134,
                width: ((size.width - 60.0) / 2) - 9,
                child: CachedNetworkImage(
                  imageUrl: questionImagesList[2]['url'],
                  placeholder: (context, url) => Center(child:CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
        child: Container(
          height: 135,
          width: size.width - 60.0,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0x26707070), width: 0.5)),
          child: Row(
            children: [
              Container(
                height: 135,
                width: ((size.width - 60) / 3) - 4,
                child: CachedNetworkImage(
                  imageUrl: questionImagesList[0]['url'],
                  placeholder: (context, url) => Center(child:CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Container(
                height: 135,
                width: ((size.width - 60) / 3) - 4,
                child: CachedNetworkImage(
                  imageUrl: questionImagesList[1]['url'],
                  placeholder: (context, url) => Center(child:CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Container(
                height: 135,
                width: ((size.width - 60) / 3) - 5,
                child: Stack(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: questionImagesList[2]['url'],
                        placeholder: (context, url) =>
                            Center(child:CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: Container(
                        height: 135,
                        width: ((size.width - 60) / 3) - 5,
                        color: Colors.black54,
                        child: Center(
                          child: Text(
                            "+ ${questionImagesList.length - 3}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 135,
                      width: ((size.width - 60) / 3) - 5,
                      child: Center(
                        child: Text(
                          "+ ${questionImagesList.length - 3}",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
