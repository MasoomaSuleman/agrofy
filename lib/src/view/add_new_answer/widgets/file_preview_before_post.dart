import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

import 'package:path/path.dart' as fileUtil;

class FilePreviewBeforePost extends StatefulWidget {
  final Size size;
  final List<File> inputMultipleFiles;
  FilePreviewBeforePost({this.inputMultipleFiles, this.size});
  @override
  _FilePreviewBeforePostState createState() => _FilePreviewBeforePostState();
}

class _FilePreviewBeforePostState extends State<FilePreviewBeforePost> {
  @override
  Widget build(BuildContext context) {
    if (widget.inputMultipleFiles == null) {
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
              itemCount: widget.inputMultipleFiles.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Container(
                      height: 45,
                      color: Color(0xFFEEEEEE),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20.0,
                          ),
                          Icon(
                            Icons.save_alt,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                '${fileUtil.basename(widget.inputMultipleFiles[index].path)}',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                widget.inputMultipleFiles.removeAt(index);
                              });
                            },
                          ),
                          SizedBox(
                            width: 15.0,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ));
  }
}
