import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';

class AlertDialogs {
  void showAlertDialogWithoutButton(
      {@required BuildContext context,
      @required String text,
      @required int popCount}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)), //this right here
            child: Container(
              height: 122,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.lightGreen[900],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    height: 50,
                    child: Center(
                      child: Text(
                        "Taxman's Ask on GST",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        '$text',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showAlertDialogWithOKbutton(
      BuildContext context, String text, int popCount) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.lightGreen[900],
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        for (int i = 0; i < popCount; i++) {
          Navigator.pop(context);
        }
      },
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)), //this right here
            child: Container(
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.lightGreen[900],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    //color: Colors.lightGreen[900],
                    height: 50,
                    child: Center(
                      child: Text(
                        "Taxman's Ask on GST",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        '$text',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      okButton,
                      SizedBox(
                        width: 5,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
