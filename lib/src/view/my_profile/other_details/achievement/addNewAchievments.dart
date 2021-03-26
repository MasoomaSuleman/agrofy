import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/model/user/other_details/achievment_model.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/profile/other_details/achievement/achievements_page.dart';

class AddNewAchievments extends StatefulWidget {
  final User currentUser;
  AddNewAchievments({
    @required this.currentUser
  });
  @override
  _AddNewAchievmentsState createState() => _AddNewAchievmentsState();
}

class _AddNewAchievmentsState extends State<AddNewAchievments> {
   final newach = Achievements();
  final _formkey = GlobalKey<FormState>();
  String enumToString(Object o) => o.toString().split('.').last;
  var _isLoading=false;
  
  @override
  Widget build(BuildContext context) {
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
          "Add Achievment",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    ),
    body: SingleChildScrollView(
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
                child:AchievmentsPage(achievmentsItem: newach),
            )),
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: FlatButton(
                minWidth: MediaQuery.of(context).size.width * 0.65,
                onPressed: (){
                  bool _achIsValid=true;
                  _formkey.currentState.save();

                  if (newach.title != null) {
                    // _personalInformationFormKey.currentState.save();

                    _formkey.currentState.save();
                    _achIsValid = _formkey.currentState.validate();

                    // _personalInformationFormKey.currentState.save();
                  }
                  if (_achIsValid && newach.title != null) {
                    print(newach.title);
                    setState(() {
                      _isLoading = true;
                    });
                    try{
                      widget.currentUser
                          .addnewAchievment(newach, context,widget.currentUser)
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
                    }}
                  /*bool _expIsValid = true;
                  if (newexp.title != null) {
                    // _personalInformationFormKey.currentState.save();

                    _formkey.currentState.save();
                    _expIsValid= _formkey.currentState.validate();

                    // _personalInformationFormKey.currentState.save();
                  }
                  if(_expIsValid && newexp.title!=null){
                    setState(() {
                      _isLoading=true;
                    });
                    try{
                      widget.currentUser.achievementList.add(newexp);
                      widget.currentUser.addAchievments(widget.currentUser);
                    }catch(e){
                      print(e);
                    }finally{
                      setState(() {
                        _isLoading=false;
                      });
                      Navigator.of(context).pop();
                    }
                  }*/
                },
                child: Text(
                  'ADD',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
    ),
    );

  }
}