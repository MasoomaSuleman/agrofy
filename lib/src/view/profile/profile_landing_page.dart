import 'package:flutter/material.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/my_profile/my_profile_landing_page.dart';

// app dependencies
import 'package:kisaanCorner/src/view/profile/other_details/add_some_more_details.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/complete_your_profile.dart';
import 'package:kisaanCorner/src/view/profile/widgets/custom_button.dart';
import 'package:kisaanCorner/utils/SizeConfig.dart';
import 'package:kisaanCorner/src/core/widgets/alert_dialogs.dart';
import 'package:kisaanCorner/src/core/widgets/loading_dialogs.dart';
import 'package:kisaanCorner/Screens/Home/HomeScreen.dart';

class ProfileLandingPage extends StatefulWidget {
  final User user;
  ProfileLandingPage(this.user);
  @override
  _ProfileLandingPageState createState() => _ProfileLandingPageState();
}

class _ProfileLandingPageState extends State<ProfileLandingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    achExpanded = false;
    expExpanded = false;
    _currentAppBar = _kAppbarCompleteYourProfile;
    _pageController.addListener(() {
      setState(() {
        pageIndex = _pageController.page.round();
        _changeAppBar();
      });
    });
  }

  static int pageIndex = 0;
  static final _pageController = PageController(initialPage: pageIndex);
  //User userModel = User();
  final _expFormKey = GlobalKey<FormState>();
  final _acvFormKey = GlobalKey<FormState>();
  bool achExpanded;
  bool expExpanded;
  GlobalKey _globalKey = GlobalKey();

  final _personalInformationFormKey = GlobalKey<FormState>();

  AppBar _currentAppBar = AppBar();
  final AppBar _kAppbarCompleteYourProfile = AppBar(
    backgroundColor: Colors.lightGreen[900],
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        // Navigator.pop(context);
      },
    ),
    title: Text(
      "Complete your profile",
      style: GoogleFonts.poppins(color: Colors.white),
    ),
  );
  final AppBar _kAppbarAddMoreDetails = AppBar(
    backgroundColor: Colors.lightGreen[900],
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        // go to previous page
        _goToPageCompleteYourProfile();
      },
    ),
    title: Text(
      "Add some more details",
      style: GoogleFonts.poppins(color: Colors.white),
    ),
  );

  void callbackExp(bool val) {
    setState(() {
      expExpanded = val;
    });
  }

  void callbackAcv(bool val) {
    setState(() {
      achExpanded = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _currentAppBar,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            CompleteYourProfilePage(
                goToAddMoreDetailsPage: goToAddMoreDetailsPage,
                userModel: widget.user,
                personalInformationFormKey: _personalInformationFormKey),
            AddSomeMoreDetailsPage(
              expkey: _expFormKey,
              achkey: _acvFormKey,
              callbackAch: callbackAcv,
              callbackExp: callbackExp,
              userModel: widget.user,
            ),
          ],
        ),
        bottomNavigationBar: (pageIndex == 1)
            ? Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.1,
                    right: SizeConfig.screenWidth * 0.1,
                    bottom: 5,
                    top: 2),
                child: CustomButton(
                  width: SizeConfig.screenWidth * 0.8,
                  text: 'Complete Profile',
                  press: () {
                    bool _achIsValid = true;
                    bool _expIsValid = true;
                    LoadingDialogs _dialog = LoadingDialogs();
                    AlertDialogs _alert = AlertDialogs();
                    if (expExpanded) {
                      _expFormKey.currentState.save();
                      if (widget.user.experienceList[0].title != null) {
                        // _personalInformationFormKey.currentState.save();
                        _expFormKey.currentState.save();
                        _expIsValid = _expFormKey.currentState.validate();

                        // _personalInformationFormKey.currentState.save();
                      }
                    } else {
                      widget.user.experienceList.clear();
                    }
                    if (achExpanded) {
                      _acvFormKey.currentState.save();

                      if (widget.user.achievementList[0].title != null) {
                        //_personalInformationFormKey.currentState.save();
                        _acvFormKey.currentState.save();
                        _achIsValid = _acvFormKey.currentState.validate();

                        // _personalInformationFormKey.currentState.save();
                      }
                    } else {
                      widget.user.achievementList.clear();
                    }
                    if (_expIsValid && _achIsValid) {
                      _dialog.showPleaseWaitLoading(
                          context: context, globalKey: _globalKey);
                      widget.user
                          .save(widget.user, context, _globalKey)
                          .then((value) {
                        if (value) {
                          // success in adding user
                          Navigator.of(_globalKey.currentContext,
                                  rootNavigator: true)
                              .pop();
                          _alert.showAlertDialogWithOKbutton(
                              context, 'New User is added', 1);
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
//                          Navigator.pushReplacement(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => HomeScreen()));
                        } else {
                          // error while adding userr
                          Navigator.of(_globalKey.currentContext,
                                  rootNavigator: true)
                              .pop();
                          _alert.showAlertDialogWithOKbutton(
                              context, 'Error while addig user.', 1);
                        }
                      });
                    }
                  },
                ),
              )
            : null,
      ),
    );
  }

  static void _goToPageCompleteYourProfile() {
    _pageController.jumpToPage(0);
  }

  void goToAddMoreDetailsPage() {
    _pageController.jumpToPage(1);
  }

  _changeAppBar() {
    if (pageIndex == 0) {
      _currentAppBar = _kAppbarCompleteYourProfile;
    } else
      _currentAppBar = _kAppbarAddMoreDetails;
  }
}
