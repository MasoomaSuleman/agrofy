import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LoadingDialogs {
  Future<void> showPleaseWaitLoading(
      {BuildContext context, GlobalKey globalKey}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: globalKey,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Please Wait....",
                          style: GoogleFonts.poppins(color: Colors.white),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
