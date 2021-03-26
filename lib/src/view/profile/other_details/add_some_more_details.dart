import 'package:flutter/material.dart';

import 'package:kisaanCorner/src/model/user/user_model.dart';

// addded dependencies
import 'package:kisaanCorner/src/view/profile/other_details/achievement/achievements_page.dart';
import 'package:kisaanCorner/src/view/profile/other_details/experience/experience_page.dart';
import 'package:google_fonts/google_fonts.dart';

// app depencdencies
import 'package:kisaanCorner/utils/SizeConfig.dart';
import '../stepper/stepper_flow.dart';

class AddSomeMoreDetailsPage extends StatefulWidget {
 
 final expkey;
 final achkey;
 final Function(bool) callbackExp;
 final Function(bool) callbackAch;
 final User userModel;
 AddSomeMoreDetailsPage(
   {
     @required this.expkey,
     @required this.achkey,
     @required this.callbackAch,
     @required this.callbackExp,
     this.userModel,
   }
 );
  @override
  _AddSomeMoreDetailsPageState createState() => _AddSomeMoreDetailsPageState();
}

class _AddSomeMoreDetailsPageState extends State<AddSomeMoreDetailsPage> {
  var _expanded2 = false;
  var _expanded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            StepperTwo(),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                        top: BorderSide(
                            color: _expanded
                                ? Colors.lightGreen[900]
                                : Color(0x40707070)),
                        bottom: BorderSide(
                            color: _expanded
                                ? Colors.lightGreen[900]
                                : Color(0x40707070)),
                        left: BorderSide(
                            color: _expanded
                                ? Colors.lightGreen[900]
                                : Color(0x40707070)),
                        right: BorderSide(
                            color: _expanded
                                ? Colors.lightGreen[900]
                                : Color(0x40707070)))),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Experience",
                        style: GoogleFonts.poppins(
                            color: _expanded ? Colors.lightGreen[900] : Colors.black,
                            fontSize: 16),
                      ),
                      trailing: IconButton(
                          iconSize: 20,
                          icon: Icon(
                              _expanded ? Icons.arrow_drop_down : Icons.add),
                          color: Colors.lightGreen[900],
                          onPressed: () {
                            
                            setState(() {
                              _expanded = !_expanded;
                              widget.callbackExp(_expanded);
                            });
                          }),
                    ),
                    if (_expanded) Container(
                      child: Form(
                      key: widget.expkey,
                        child:ExperiencePage( experienceItem:widget.userModel.experienceList[0],)),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                        top: BorderSide(
                            color: _expanded2
                                ? Colors.lightGreen[900]
                                : Color(0x40707070)),
                        bottom: BorderSide(
                            color: _expanded2
                                ? Colors.lightGreen[900]
                                : Color(0x40707070)),
                        left: BorderSide(
                            color: _expanded2
                                ? Colors.lightGreen[900]
                                : Color(0x40707070)),
                        right: BorderSide(
                            color: _expanded2
                                ? Colors.lightGreen[900]
                                : Color(0x40707070)))),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Achievements",
                        style: GoogleFonts.poppins(
                            color:
                                _expanded2 ? Colors.lightGreen[900] : Colors.black,
                            fontSize: 16),
                      ),
                      trailing: IconButton(
                          iconSize: 20,
                          icon: Icon(
                              _expanded2 ? Icons.arrow_drop_down : Icons.add),
                          color: Colors.lightGreen[900],
                          onPressed: () {
                            
                            setState(() {
                              _expanded2 = !_expanded2;
                              widget.callbackAch(_expanded2);
                            });
                          }),
                    ),
                    if (_expanded2) Container(
                      margin: EdgeInsets.only(bottom: 1.0),
                    child: Form(
                        key: widget.achkey,
                        child:AchievmentsPage(achievmentsItem: widget.userModel.achievementList[0],)))
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
