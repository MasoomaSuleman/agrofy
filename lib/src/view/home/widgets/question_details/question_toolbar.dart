import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/core/widgets/loading_dialogs.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/home/widgets/questions_card/bookmark_button.dart';
import 'package:kisaanCorner/src/view/home/widgets/share/share_model.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:kisaanCorner/src/view/add_new_answer/add_new_answer_screen.dart';

class QuestionDetailsToolbar extends StatefulWidget {
  final DocumentSnapshot questionData;
  final pagecontext;
  QuestionDetailsToolbar(
      {@required this.questionData, @required this.pagecontext});
  @override
  _QuestionDetailsToolbarState createState() => _QuestionDetailsToolbarState();
}

class _QuestionDetailsToolbarState extends State<QuestionDetailsToolbar> {
  bool _reportExists = false;

  LoadingDialogs dialogs = LoadingDialogs();
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Container(
            color: Colors.white,
            height: 70,
            padding: EdgeInsets.fromLTRB(8, 0.0, 8, 5.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                    IconButton(
                        padding: EdgeInsets.all(0.0),
                        alignment: Alignment.bottomCenter,
                        icon: Icon(Icons.question_answer,
                            color: Colors.grey, size: 16),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddNewAnswerScreen(widget.questionData)),
                          );
                        }),
                    Text(
                      'Answer',
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 10),
                    )
                  ]),
                  Column(children: <Widget>[
                    /* IconButton(
                  padding: EdgeInsets.all(0.0),
                  alignment: Alignment.bottomCenter,
                  icon: Icon(Icons.bookmark_outline,color: Colors.grey, size: 16),
                  onPressed: (){

                  }
                ),*/
                    BookmarkButton(
                      questionId: widget.questionData.documentID,
                      forDetails: true,
                    ),
                    Text(
                      'Save',
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 10),
                    )
                  ]),
                  Column(children: <Widget>[
                    IconButton(
                        padding: EdgeInsets.all(0.0),
                        alignment: Alignment.bottomCenter,
                        icon: Icon(Icons.share_outlined,
                            color: Colors.grey, size: 16),
                        onPressed: ()async {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>MainScreen()),
                          );*/
                          final RenderBox box = context.findRenderObject();
                         await Share.share("Testing share functionality https://singhanias.page.link/?link=https://www.example.com&apn=com.singhanias.s_gst&st=Hello+World+Dynamic+Link&sd=checking+Taxman+Share+functionality&si=https://images.pexels.com/photos/3841338/pexels-photo-3841338.jpeg?auto%3Dcompress%26cs%3Dtinysrgb%26dpr%3D2%26h%3D750%26w%3D1260");
                        }),
                    Text(
                      'Share',
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 10),
                    )
                  ]),
                  Column(children: <Widget>[
                    IconButton(
                        padding: EdgeInsets.all(0.0),
                        alignment: Alignment.bottomCenter,
                        icon: Icon(Icons.error_outline,
                            color: Colors.grey, size: 16),
                        onPressed: () async {
                          print(widget.questionData.documentID);
                          try {
                            final doc = await Firestore.instance
                                .collection('questionReportData')
                                .document(widget.questionData.documentID)
                                .get();
                            print(doc.data);
                            if (doc.data == null) {
                              Firestore.instance
                                  .collection('questionReportData')
                                  .document(widget.questionData.documentID)
                                  .setData({
                                'questionCardId':
                                    (widget.questionData.documentID).toString(),
                                'reportedByUid': [currentUser.userId]
                              });
                            } else {
                              List reports = doc.data['reportedByUid'].toList();
                              print(reports);
                              if (!reports.contains(currentUser.userId))
                                reports.add(currentUser.userId);
                              else
                                _reportExists = true;
                              Firestore.instance
                                  .collection('questionReportData')
                                  .document(widget.questionData.documentID)
                                  .updateData({
                                'questionCardId':
                                    (widget.questionData.documentID).toString(),
                                'reportedByUid': reports.map((e) => e).toList()
                              });
                            }
                          } catch (e) {
                            print(e);
                            _finalAlertDialog("An error occured, Sorry!");
                          } finally {
                            if (_reportExists)
                              _finalAlertDialog(
                                  "You have already reported this question.\nThank you!");
                            else
                              _finalAlertDialog(
                                  "You have successfully reported this question.\nThank you!");
                          }
                        }),
                    Text(
                      'Report',
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 10),
                    )
                  ])
                ])));
  }

  void _finalAlertDialog(String text) {
    // set up the button
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Text(
                text,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  color: Colors.lightGreen[900],
                  child: Text(
                    "Okay",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                )
              ],
            ));
  }
}
/*https://singhanias.page.link/?link=https://www.example.com&apn=com.singhanias.s_gst&st=Hello+World+Dynamic+Link&sd=checking+Taxman+Share+functionality&si=https://images.pexels.com/photos/3841338/pexels-photo-3841338.jpeg?auto%3Dcompress%26cs%3Dtinysrgb%26dpr%3D2%26h%3D750%26w%3D1260 */