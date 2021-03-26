import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingDialogs {
  static Future<void> showPLeaseWaitLoading(
      BuildContext context, GlobalKey key) async {
    // the following statement is to use this loading dialog
    // initilize a global key from where the loading widget will be called
    //LoadingDialogs.showLoadingDialog(context, _keyLoader);
    // the following satement is to remove the loading dialog
    //Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
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
