
import 'package:flutter/material.dart';
import 'package:kisaanCorner/Screens/AddAnswer/AddAnswerScreen.dart';
import 'package:kisaanCorner/Screens/BooksScreen.dart';
import 'package:kisaanCorner/Screens/EditAnswer/EditAnswerScreen.dart';
import 'package:kisaanCorner/Screens/EditProfileScreen.dart';
import 'package:kisaanCorner/Screens/FeaturedNews.dart';
import 'package:kisaanCorner/Screens/Home/HomeScreen.dart';
import 'package:kisaanCorner/Screens/NotificationsScreen.dart';
import 'package:kisaanCorner/Screens/OtherUsersFollowersScreen.dart';
import 'package:kisaanCorner/Screens/OtherUsersFollowingScreen.dart';
import 'package:kisaanCorner/Screens/QuestionDetails/ui_components/QuestionDetails.dart';
import 'package:kisaanCorner/Screens/otherUserProfile.dart';
import 'package:kisaanCorner/Screens/otp_input_screen.dart';
import 'package:kisaanCorner/Screens/signIn_screen.dart';
import 'package:kisaanCorner/src/view/my_bookmarks/my_bookmarks_screen.dart';
import 'package:kisaanCorner/src/view/my_contributions/my_contributions_landing_page.dart';
import 'package:kisaanCorner/src/view/my_followers_following/my_followers_screen.dart';
import 'package:kisaanCorner/src/view/profile/profile_landing_page.dart';

import 'routing_constants.dart';

//screens

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case profileSetupRoute:
      return MaterialPageRoute(
          builder: (context) => ProfileLandingPage(settings.arguments));
    case booksRoute:
      return MaterialPageRoute(builder: (context) => BooksScreen());
    case editProfileRoute:
      return MaterialPageRoute(builder: (context) => EditProfileScreen());
    case featuredNewsRoute:
      return MaterialPageRoute(builder: (context) => FeaturedScreen());
    case myFollowingRoute:
      return MaterialPageRoute(
          builder: (context) => (settings.arguments));
    case myFollowersRoute:
      return MaterialPageRoute(
          builder: (context) => MyFollowersScreen(settings.arguments));
    case myBookmarksRoute:
      return MaterialPageRoute(builder: (context) => MyBookmarksScreen());
    case myContributionsRoute:
      return MaterialPageRoute(
          builder: (context) => MyContributionsLandingPage(settings.arguments));
    case myNotificationsRoute:
      return MaterialPageRoute(builder: (context) => NotificationsScreen(null));
    case otherUserProfileRoute:
      return MaterialPageRoute(builder: (context) => OtherUserProfile());
    case otherUserFollowersRoute:
      return MaterialPageRoute(
          builder: (context) => OtherUsersFollowersScreen());
    case otherUserFollowingRoute:
      return MaterialPageRoute(
          builder: (context) => OtherUsersFollowingScreen());
    case otpInputRoute:
      return MaterialPageRoute(builder: (context) => OtpPage());
    case questionDetailsRoute:
      return MaterialPageRoute(
          builder: (context) => QuestionDetails(null, null, null));
    case signinAndroidRoute:
      return MaterialPageRoute(builder: (context) => Signin());
    case homeRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case editAnswerRoute:
      return MaterialPageRoute(builder: (context) => EditAnswerScreen(null));
    case addAnswerRoute:
      return MaterialPageRoute(builder: (context) => AddAnswerScreen(null));
    default:
      return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}
