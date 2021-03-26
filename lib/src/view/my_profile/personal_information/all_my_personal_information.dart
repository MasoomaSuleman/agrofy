import 'package:flutter/material.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// app dependencies
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'edit_personal_information/edit_my_personal_information.dart';
import 'widgets/custom_tile.dart';

class AllMyPersonalInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    User _currentUser = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
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
            "Other Details",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                // go to previous page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditMyPersonalInformationPage()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: (_size.width * 0.05)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Personal Details',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
//                    Icon(
//                      Icons.edit,
//                      color: Color(0xB32D2D2D),
//                      size: 20,
//                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: (_size.width * 0.05)),
                child: Divider(
                  color: Color(0x73707070),
                  thickness: 1,
                ),
              ),
              CustomTile(
                  Icons.call,
                  'Phone',
                  (_currentUser.personalInformation?.phoneNumber != null)
                      ? '+91- '
                          '${_currentUser.personalInformation.phoneNumber}'
                      : '+91-',
                  _size),
              CustomTile(
                  Icons.email,
                  'Email',
                  (_currentUser.personalInformation?.email != null)
                      ? '${_currentUser.personalInformation.email}'
                      : null,
                  _size),
              CustomTile(
                  Icons.room,
                  'Address',
                  (_currentUser.personalInformation?.address != null)
                      ? '${_currentUser.personalInformation.address}'
                      : null,
                  _size),
              CustomTile(
                  Icons.open_in_new,
                  'Website',
                  (_currentUser.personalInformation?.website != null)
                      ? '${_currentUser.personalInformation.website}'
                      : null,
                  _size),
              CustomTile(
                  Icons.person_outline,
                  'About Me',
                  (_currentUser.personalInformation?.aboutMe != null)
                      ? '${_currentUser.personalInformation.aboutMe}'
                      : null,
                  _size),
            ],
          ),
        ),
      ),
    );
  }
}
