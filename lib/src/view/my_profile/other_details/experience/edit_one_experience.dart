import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/Screens/EditAnswer/ui_copmponents/AlertDialogs.dart';
import 'package:kisaanCorner/src/core/widgets/loading_dialogs.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:kisaanCorner/src/model/user/other_details/experience_model.dart';
import 'package:kisaanCorner/src/view/profile/other_details/experience/experience_page.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/widgets/custom_editfield_wrapper.dart';
class EditExperience extends StatefulWidget {
  final Experience exp;
  final int index;
    EditExperience({
    @required this.exp,
    @required this.index,
  });
  @override
  _EditExperienceState createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  
  final _formkey = GlobalKey<FormState>();
  String enumToString(Object o) => o.toString().split('.').last;
  Experience oldexp;
  var _isLoading=false;
  bool delete = false;
  @override
   void initState(){
     super.initState();
     oldexp=widget.exp;
    }  
  LoadingDialogs _dialog = LoadingDialogs();
  AlertDialogs _alert = AlertDialogs();
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    return Scaffold(
     backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.lightGreen[900],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          // go to previous page
          Navigator.pop(context);
        },
      ),
      title: Center(
        child: Text(
          "Edit Experience",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    ),
    body:_isLoading? _dialog.showPleaseWaitLoading(
          context: context, globalKey: _formkey): SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
               Container(
                child: Form(
                  key: _formkey,
                  child:ExperiencePage( experienceItem: widget.exp,)),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: FlatButton(
                  minWidth: MediaQuery.of(context).size.width * 0.65,
                  onPressed: (){
                     _formkey.currentState.save();
                    bool _expIsValid =
                       _formkey.currentState.validate();

                      // _personalInformationFormKey.currentState.save();
                    
                    if (_expIsValid ) {
                      print(widget.exp.title);
                      setState(() {
                        _isLoading = true;
                      });
                      try{
                        currentUser
                            .editExperience(widget.exp,context,currentUser,widget.index,oldexp)
                            .then((value) {
                          if (value) {
                            // new experince succefully added
                          } else {
                            // error while adding new experience
                          }
                        });
                      }catch(e){
                        print(e);
                      }finally{
                        setState(() {
                      _isLoading=false;
                      });
                         Navigator.of(context).pop();
                      }
                    }          
                  },
                  child: Text(
                    'Edit',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  color: Colors.black,
                ),
              ),
              Divider(color: Colors.transparent),
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: FlatButton(
                  minWidth: MediaQuery.of(context).size.width * 0.65,
                  onPressed: (){
                    _confirmDeleteAlertDialog(currentUser);
                    print(delete);
                    
                  },
                  child: Text(
                    'Delete',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  color: Colors.lightGreen[900],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
   

  void _confirmDeleteAlertDialog(User currentUser) {
    // set up the button
    Widget  yesButton = FlatButton(
    color: Colors.lightGreen[900],
    child: Text("Yes",style: TextStyle(color: Colors.white, fontSize: 14.0),),
    onPressed: () {
      setState((){
        delete=true;
      });

       Navigator.pop(context);
      if (delete) {
        print(widget.exp.title);
        setState(() {
          _isLoading = true;
        });
        try{
          currentUser
              .deleteExperience(context,currentUser,widget.index,oldexp)
              .then((value) {
            if (value) {
              // new experince succefully added
            } else {
              // error while adding new experience
            }
          });
        }catch(e){
          print(e);
        }finally{
          setState(() {
        _isLoading=false;
        });
           Navigator.of(context).pop();
        }
      }
    },
    );
    Widget  cancelButton = FlatButton(
    color: Colors.black,
    child: Text("cancel",style: TextStyle(color: Colors.white, fontSize: 14.0),),
    onPressed: () {
      setState((){
        delete=false;
      });
      Navigator.pop(context);
    },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure you want to delete this experience? "),
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


