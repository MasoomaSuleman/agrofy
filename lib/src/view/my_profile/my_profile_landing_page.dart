import 'package:flutter/material.dart';

//added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';

// app dependencies
import 'package:kisaanCorner/src/view/my_profile/personal_information/my_personal_information.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/achievement/my_achievement.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/experience/my_experience.dart';
import 'package:provider/provider.dart';

class MyProfileLandingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    User _currentUser = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
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
          title: Text(
            "Profile",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyPersonalInformation(),
              Container(color: Color(0xFFF8F8F8), child: MyExperience()),
              Container(color: Color(0xFFF8F8F8), child: MyAchievement())
            ],
          ),
        ),
      ),
    );
  }
}
