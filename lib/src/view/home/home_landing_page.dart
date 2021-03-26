import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:kisaanCorner/Screens/BooksScreen.dart';
import 'package:kisaanCorner/Screens/FeaturedNews.dart';
import 'package:kisaanCorner/src/view/home/widgets/home_screen/home_screen.dart';
import 'package:kisaanCorner/Screens/Home/ui_components/HomeMainScreen.dart';

class HomeLangingPage extends StatefulWidget {
  @override
  _HomeLangingPageState createState() => _HomeLangingPageState();
}

class _HomeLangingPageState extends State<HomeLangingPage> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 1);

  DateTime _currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: PersistentTabView(
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears.
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        popAllScreensOnTapOfSelectedTab: true,

        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style8, // Choose the nav bar style with this property.
      ),
    );
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > Duration(seconds: 1)) {
      _currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Double Tap To Exit App!", toastLength: Toast.LENGTH_LONG);
      return Future.value(false);
    }
    return Future.value(true);
  }

  List<Widget> _buildScreens() {
    return [
      BooksScreen(),
      HomeScreen(),
      FeaturedScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        titleFontSize: 10,
        icon: ImageIcon(
          AssetImage('assets/images/ic_view_week_24px.png'),
        ),
        title: ('Books'),
        activeColor: Colors.lightGreen[900],
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
          titleFontSize: 10,
          icon: Icon(Icons.home),
          activeColor: Colors.lightGreen[900],
          inactiveColor: Colors.grey,
          title: ("Home")),
      PersistentBottomNavBarItem(
        titleFontSize: 10,
        icon: ImageIcon(
          AssetImage('assets/images/icons8-news.png'),
        ),
        title: ('News'),
        activeColor: Colors.lightGreen[900],
        inactiveColor: Colors.grey,
      ),
    ];
  }
}
