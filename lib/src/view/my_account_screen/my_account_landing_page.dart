import 'package:flutter/material.dart';

// added dependncies
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// app dependencies
import 'widgets/custom_list_tile.dart';
import 'widgets/custom_circular_profile_avatar.dart';
import 'widgets/taxman_info.dart';
import '../my_profile/my_profile_landing_page.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/network/user_signIn_functions.dart';
import 'package:kisaanCorner/Screens/signIn_screen.dart';

//import 'package:kisaanCorner/Screens/FollowingScreen.dart';
import 'package:kisaanCorner/src/view/my_followers_following/following_screen.dart';
//import 'package:kisaanCorner/Screens/MyBookmarksScreen.dart';
import 'package:kisaanCorner/src/view/my_bookmarks/my_bookmarks_screen.dart';
//import 'package:kisaanCorner/Screens/MyContributionsScreen.dart';
//import 'package:kisaanCorner/Screens/MyFollowersScreen.dart';
import 'package:kisaanCorner/src/view/my_contributions/my_contributions_landing_page.dart';
import 'package:kisaanCorner/src/view/my_followers_following/my_followers_screen.dart';
import 'package:kisaanCorner/Screens/NotificationsScreen.dart';

class MyAccountLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String fullName = Provider.of<User>(context).personalInformation.fullName;
    String userId = Provider.of<User>(context).userId;
    int followersCount = Provider.of<User>(context).followersCount;
    int followingCount = Provider.of<User>(context).followingCount;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: AppBar(
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
              flexibleSpace: GestureDetector(
                onTap: () {
                  // gog to my profile landing page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProfileLandingPage()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomCircularProfileAvatar(30),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$fullName",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomListTile(Icons.add, "My Contributions", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyContributionsLandingPage(
                                    userId,
                                  )));
                    }, 'assets/images/my_account_page_icons/my_contributions.svg',
                        null),
                    CustomListTile(Icons.bookmark, "My Bookmarks", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyBookmarksScreen()));
                    }, 'assets/images/my_account_page_icons/my_bookmarks.svg',
                        null),
                    CustomListTile(Icons.notifications, "Notifications", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NotificationsScreen(userId)));
                    }, 'assets/images/my_account_page_icons/notifications.svg',
                        null),
                    CustomListTile(Icons.person, "My Followers", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyFollowersScreen(
                                    userId,
                                  )));
                    }, 'assets/images/my_account_page_icons/following.svg',
                        followersCount.toString()),
                    CustomListTile(Icons.person_add, "Following", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FollowingScreen(
                                    userId,
                                  )));
                    }, 'assets/images/my_account_page_icons/following.svg',
                        followingCount.toString()),
                    CustomListTile(
                        Icons.edit,
                        "About Us",
                        () {},
                        'assets/images/my_account_page_icons/about_us.svg',
                        null),
                    CustomListTile(Icons.account_circle, "Log Out", () async {
                      UserSignInFunctions forLogOut = UserSignInFunctions();
                      forLogOut.logOutUser(context).then((value) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Signin()));
                      }).catchError((e) {});
                      // AuthServices.logOut(context);
                    }, 'assets/images/my_account_page_icons/log_out.svg', null),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              TaxmanInfo(),
              Expanded(
                child: Container(),
              ),
            ],
          )),
    );
  }
}
