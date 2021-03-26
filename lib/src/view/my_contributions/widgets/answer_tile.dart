import 'package:flutter/material.dart';

// added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/Screens/EditAnswer/ui_copmponents/AlertDialogs.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

// app depedndencies
import 'package:kisaanCorner/src/view/my_contributions/edit_my_answer/edit_my_answer_screen.dart';

class AnswerTile extends StatefulWidget {
  final DocumentSnapshot answerSnap;
  AnswerTile(this.answerSnap);
  @override
  _AnswerTileState createState() => _AnswerTileState();
}

class _AnswerTileState extends State<AnswerTile> {
  bool toDelete=false;
  @override
  Widget build(BuildContext context) {
//    print(widget.repliesCount);
    // Answer toBuild = Answer.fromSnapshot(widget.answerSnap);
    //MyAnswersModel toBuild = MyAnswersModel().fromMap(answerData);
    //  Answer toBuild = Answer.fromJson(answerData.data);
    //return Container();
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Container(
//          width: _size.width * 0.90,
//          height: _size.height * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // right now it is the image of the user but it should be iamge of the question user
              Padding(
                  padding: const EdgeInsets.all(4),
                  child: CircularProfileAvatar(
                    '${widget.answerSnap.data['questionByImageURL']}',
                    radius: 15,
                    borderWidth: 0,
//                        initialsText: Text("H"),
                    backgroundColor: Colors.grey,
                    elevation: 0,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.answerSnap.data['questionByName']}',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${widget.answerSnap.data['questionByProfession']}',
                      style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListTile(
          //contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
          contentPadding: EdgeInsets.fromLTRB(14, 4, 14, 4),
          dense: true,
          title: Text(
            "${widget.answerSnap.data['questionText']}",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xFFF3F3F3),
                ),
                child: IconButton(
                  color: Colors.lightGreen[900],
                  iconSize: 16.0,
                  icon: Icon(
                    Icons.delete,
                  ),
                  onPressed: () {
                    _confirmDeleteAlertDialog();
                    print(toDelete);
                  },
                ),
              ),
               SizedBox(
                 width: 4,
               ),
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xFFF3F3F3),
                ),
                child: IconButton(
                  color: Colors.black,
                  iconSize: 16.0,
                  icon: Icon(
                    Icons.text_format,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditMyAnswerScreen(widget.answerSnap)));
                  },
                ),
              ),
            ]
          )

            
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "${widget.answerSnap.data['answerText']}",
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${timeago.format(DateTime.parse(widget.answerSnap.data['answerTimeStamp']))}",
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 10.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        " ",
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 10.0),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }
  void _confirmDeleteAlertDialog() {
    // set up the button
    Widget  yesButton = FlatButton(
    color: Colors.lightGreen[900],
    child: Text("Yes",style: TextStyle(color: Colors.white, fontSize: 14.0),),
    onPressed: () {
      setState((){
        toDelete=true;
      });

       Navigator.pop(context);
      if (toDelete) {
        try{
          Firestore _firestore = Firestore.instance;
          //LoadingDialogs.showPLeaseWaitLoading(context, _keyLoader);
          _firestore
              .collection('answerData')
              .document(widget.answerSnap.documentID)
              .delete()
              .then((value)async {
           // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            //AlertDialogs.showAlertDialogWithOKbutton(
            //    context, 'Answer deleted Succesfully');
            await _firestore
                .collection("questionData")
                .document(widget.answerSnap['questionUID'])
                .updateData({
              "replyCount": FieldValue.increment(-1)
            }).catchError((e) {
              throw Exception(e);
            });
          }).catchError((e) {
           // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            AlertDialogs.showAlertDialogWithOKbutton(
                context, 'Something went wrong try again later');
          });
        }catch(e){
          print(e);
        }finally{
          toDelete=false;
        }
      }
    },
    );
    Widget  cancelButton = FlatButton(
    color: Colors.black,
    child: Text("cancel",style: TextStyle(color: Colors.white, fontSize: 14.0),),
    onPressed: () {
      setState((){
        toDelete=false;
      });
      Navigator.pop(context);
    },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure you want to delete this answer? "),
      actions: [
        
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
        return alert;});
      },
    );
  }
}
