import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/Screens/EditAnswer/ui_copmponents/AlertDialogs.dart';
import 'package:kisaanCorner/src/core/widgets/loading_dialogs.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';

import 'package:intl/intl.dart';
import 'package:kisaanCorner/src/model/user/other_details/experience_model.dart';
import 'package:kisaanCorner/src/view/profile/other_details/experience/experience_page.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/widgets/custom_editfield_wrapper.dart';

class AddNewExperience extends StatefulWidget {
  final User currentUser;
  AddNewExperience({@required this.currentUser});
  @override
  _AddNewExperienceState createState() => _AddNewExperienceState();
}

class _AddNewExperienceState extends State<AddNewExperience> {
  final newexp = Experience();
  final _formkey = GlobalKey<FormState>();
  String enumToString(Object o) => o.toString().split('.').last;
  var _types = ['Part time', 'Full time'];
  var _currentItemSelected = 'Full time';
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate;
  bool _currentrole = true;
  final experienceItem = Experience();
  bool _isLoading = false;

  Future<void> _presentDatePicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2021),
    );
    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
    print(_selectedStartDate);
  }

  Future<void> _presentEndDatePicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(1999),
      lastDate: DateTime(2021),
    );
    if (picked != null) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
    print(_selectedEndDate);
  }

  LoadingDialogs _dialog = LoadingDialogs();
  AlertDialogs _alert = AlertDialogs();
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
            "Add Experience",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
      body: _isLoading
          ? _dialog.showPleaseWaitLoading(context: context, globalKey: _formkey)
          : SingleChildScrollView(
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
                            child: ExperiencePage(
                              experienceItem: newexp,
                            )),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: FlatButton(
                          minWidth: MediaQuery.of(context).size.width * 0.65,
                          onPressed: () {
                            _formkey.currentState.save();
                            bool _expIsValid = true;
                            if (newexp.title != null) {
                              // _personalInformationFormKey.currentState.save();

                              _formkey.currentState.save();
                              _expIsValid = _formkey.currentState.validate();

                              // _personalInformationFormKey.currentState.save();
                            }
                            if (_expIsValid && newexp.title != null) {
                              print(newexp.title);
                              setState(() {
                                _isLoading = true;
                              });
                              try{
                                widget.currentUser
                                    .addnewExperience(newexp, context,widget.currentUser)
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
                              
//                      try{
//                        widget.currentUser.experienceList.add(newexp);
//                        widget.currentUser.addExperience(widget.currentUser);
//                      }catch(e){
//                        print(e);
//                      }finally{
//                        setState(() {
//                          _isLoading=false;
//                        });
//                        Navigator.of(context).pop();
//                      }
                            }
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
