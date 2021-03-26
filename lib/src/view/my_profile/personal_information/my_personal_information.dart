import 'package:flutter/material.dart';

// addded dependedncies
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// app dependencies
import 'edit_personal_information/edit_my_personal_information.dart';
import 'widgets/profile_photo.dart';
import 'widgets/followers_following_count.dart';
import 'widgets/custom_tile.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/my_profile/personal_information/all_my_personal_information.dart';

class MyPersonalInformation extends StatefulWidget {
  @override
  _MyPersonalInformationState createState() => _MyPersonalInformationState();
}

class _MyPersonalInformationState extends State<MyPersonalInformation> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    User _currentUser = Provider.of<User>(context);
    return Container(
      color: Color(0xFFFDFDFD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          ProfilePhoto(
            personalInformationModel: _currentUser.personalInformation,
            defaultProfileImageUrl:
                _currentUser.personalInformation.profileImageUrl,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            (_currentUser.personalInformation?.fullName != null)
                ? '${_currentUser.personalInformation.fullName}'
                : 'Error',
            style: GoogleFonts.poppins(
                fontSize: 20,
                color: Color(0xff323131),
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            (_currentUser.personalInformation?.profession != null)
                ? '${_currentUser.personalInformation.profession}'
                : 'Error',
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: Color(0xff323131),
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            (_currentUser.personalInformation?.organization != null)
                ? '${_currentUser.personalInformation.organization}'
                : ' ',
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: Color(0xff323131),
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(
            height: 10,
          ),
          FollowersFollowingCount(
              _currentUser.followersCount, _currentUser.followingCount),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: (_size.width * 0.05)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Personal Information',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(0),
                  iconSize: 20,
                  icon: Icon(Icons.edit),
                  color: Color(0xB32D2D2D),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditMyPersonalInformationPage()));
                  },
                ),
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
                  ? '+91- ' '${_currentUser.personalInformation.phoneNumber}'
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
              Icons.open_in_new,
              'Website',
              (_currentUser.personalInformation?.website != null)
                  ? '${_currentUser.personalInformation.website}'
                  : null,
              _size),
          GestureDetector(
            onTap: () {
              // move to next screen where all details can be seen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllMyPersonalInformation()));
            },
            child: Text(
              'SEE ALL',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.lightGreen[900]),
            ),
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
