import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class QuestionFiles extends StatelessWidget {
  final Map<String, dynamic> questionFile;

  QuestionFiles({
    this.questionFile,
  });

  String formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }

  @override
  Widget build(BuildContext context) {
    return (questionFile == null)
        ? Container()
        : Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
            child: GestureDetector(
              onTap: () async {
                // final status = await Permission.storage.request();
                final status = await Permission.storage.request();
                if (status.isGranted) {
                  final externalDir = await getExternalStorageDirectory();

                  final id = await FlutterDownloader.enqueue(
                    url: questionFile['url'],
                    savedDir: externalDir.path,
                    fileName: "download",
                    showNotification: true,
                    openFileFromNotification: true,
                  );
                } else {
                  print("Permission deined");
                }
                /* final path =
                    await ExtStorage.getExternalStoragePublicDirectory(
                        ExtStorage.DIRECTORY_DOWNLOADS);
                String fullPath = "$path/${questionFile['name']}.${questionFile['type'].substring(1)}";
                // download this file to local storage
                // automatically open
              FlutterDownloader.enqueue(
                url: questionFile['url'],
                savedDir: fullPath,
                showNotification:true,
                openFileFromNotification:true,
              );
              // await mainDownload(questionFile['url'],questionFile['name'],questionFile['type']);
              */
              },
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
                      (questionFile['name'] != null)
                          ? Expanded(
                              child: Container(
                                child: Text(
                                  '${questionFile['name']}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                child: Text(
                                  'FileName.ext',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                      (questionFile['size'] != null)
                          ? Text(
                              '${formatBytes(questionFile['size'])}',
                              style: GoogleFonts.poppins(fontSize: 11),
                            )
                          : Text(
                              '000kb',
                              style: GoogleFonts.poppins(fontSize: 11),
                            ),
                      SizedBox(
                        width: 15.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
