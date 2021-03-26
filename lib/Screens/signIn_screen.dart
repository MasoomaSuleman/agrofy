import 'package:flutter/material.dart';

//added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/provider/user_details.dart';

import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

//app packages
import '../constants.dart';
import '../utils/AuthServices.dart';
import 'package:kisaanCorner/src/core/widgets/alert_dialogs.dart';
import 'package:kisaanCorner/src/network/user_signIn_functions.dart';
import 'package:kisaanCorner/Screens/Home/HomeScreen.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = new GlobalKey<FormState>();
  String _phoneNumber, _verificationID;
  bool isLoading = false;

  UserSignInFunctions _userSignInFunctions = UserSignInFunctions();

  //final FacebookLogin fbLogin = new FacebookLogin();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<UserDetails>(
      create: (_) => UserDetails(),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                height: size.height,
                width: size.width,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 60, 8, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Welcome",
                          style: GoogleFonts.poppins(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "Please login to continue to our app",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.grey),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/createAccount.png',
                          height: size.height * 0.4,
                        ),
                        Spacer(),
                        Container(
                          width: size.width * 0.8,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(.3),
                                blurRadius: 4.0,
                              )
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 40,
                                  height: 50,
                                  child: Center(
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      child: SvgPicture.asset(
                                        'assets/images/Flag_of_India.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: double.infinity,
                                width: 1,
                                color: Colors.grey.withOpacity(.3),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "IN  +91 - ",
                                ),
                              ),
                              Container(
                                width: size.width * 0.4,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: "Enter Phone Number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  validator: (value) {
                                    if (value.length != 10 &&
                                        double.tryParse(value) == null) {
                                      return null;
                                    } else {
                                      validPhoneNumberEntered();
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    // save the name value here
                                    //_userToPass.name = value;
                                    setState(() {
                                      this._phoneNumber = "+91" + value;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: this._phoneNumber?.length == 13 &&
                                            double.tryParse(this
                                                    ._phoneNumber
                                                    .substring(3)) !=
                                                null
                                        ? Colors.blue
                                        : Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
//                        SizedBox(
//                          height: 5.0,
//                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Opacity(
                          opacity: isLoading ? 0.3 : 1,
                          child: BigButton(

                            size: size,
                            text: "Verify",
                            height: 50.0,
                            press: () {
                              if (!isLoading) {
                                _formKey.currentState.validate();
                              }
                            },
                          ),
                        ),

//                        SizedBox(
//                          height: 5.0,
//                        ),
                        Spacer(
                          flex: 2,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Divider(
                              color: Colors.black,
                            ),
                            Text(
                              "or via social media",
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
                        Spacer(
                          flex: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (isLoading)
                                ? Opacity(
                                    opacity: 0.3,
                                    child: SmallButton(
                                        size: size,
                                        text: 'Google',
                                        press: () {}))
                                : SmallButton(
                                    size: size,
                                    text: "Google",
                                    press: () async {
                                      // disable this button
                                      setState(() {
                                        isLoading = true;
                                      });

                                      _userSignInFunctions
                                          .customGoogleSignIn(context, onError:(){
                                            setState((){
                                              isLoading = false;
                                            });
                                          });
//                                      if (!isSuccess) {
//                                        setState(() {
//                                          isLoading = false;
//                                        });
//                                        AlertDialogs _alert = AlertDialogs();
//                                        _alert.showAlertDialogWithOKbutton(
//                                            context,
//                                            'Error while Google Sign In. Please try again later.');
//                                        print(
//                                            "SignIn()''': Onpress Goolgle button error on sign in ");
//                                      }
                                    },
                                  ),
//                                SizedBox(
//                                  width: 20.0,
//                                ),
//                            SmallButton(
//                              buttonColor: Color(0xFF1258C1),
//                              size: size,
//                              text: "Facebook",
//                              press: () {
//
//                              },
//                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  moveToOtpScreen() {
    setState(() {
      isLoading = false;
    });
  }

  void facebookButtonLoginFuntionality() {
    //                                //authentication with facebook
//                                fbLogin.logIn(['email', 'public_profile']).then(
//                                    (result) {
//                                  switch (result.status) {
//                                    case FacebookLoginStatus.loggedIn:
//                                      FacebookAccessToken fbAccessToken =
//                                          result.accessToken;
//                                      AuthCredential authCredential =
//                                          FacebookAuthProvider.getCredential(
//                                              accessToken: fbAccessToken.token);
//                                      //FirebaseUser fbUser;
//                                      _auth
//                                          .signInWithCredential(authCredential)
//                                          .then((value) {
//                                        FirebaseUser fbUser = value.user;
//                                        print(
//                                            "Signin_Android()''': signIn with facebook done user is ${fbUser.displayName}");
//                                        //check for user already being there
//                                        _firestrore
//                                            .collection('userData')
//                                            .document("${fbUser.uid}")
//                                            .get()
//                                            .then((docSnap) {
//                                          if (docSnap.exists) {
//                                            Navigator.push(
//                                                context,
//                                                MaterialPageRoute(
//                                                    builder: (context) =>
//                                                        HomeScreen()));
//                                          } else {
//                                            Navigator.push(
//                                                context,
//                                                MaterialPageRoute(
//                                                    builder: (context) =>
//                                                        ProfileSetupScreen(
//                                                          name: fbUser
//                                                              .displayName,
//                                                          photourl:
//                                                              fbUser.photoUrl,
//                                                          email: fbUser.email,
//                                                          uid: fbUser.uid,
//                                                        )));
//                                          }
//                                        });
//                                      });
//                                  }
//                                }).catchError((e) {
//                                  print(
//                                      "Signin_Android()''': Facebook login catched error, $e");
//                                });
  }

  void validPhoneNumberEntered() {
    if (_phoneNumber.length == 13) {
      setState(() {
        isLoading = true;
      });
      _userSignInFunctions
          .phoneNumberVerify(context, _phoneNumber, moveToOtpScreen)
          .then((value) => {});
    } else {
      // show error in entered phone number
    }
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton(
      {Key key,
      @required this.size,
      @required this.text,
      @required this.press,
      this.buttonColor})
      : super(key: key);

  final Size size;
  final String text;
  final Function press;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: (size.width * 0.8),
        height: 40.0,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FlatButton(
              onPressed: press,
              child: Text(
                text,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              color: buttonColor != null ? buttonColor : Colors.lightGreen[900],
            )));
  }
}

class BigButton extends StatelessWidget {
  const BigButton(
      {Key key,
      @required this.size,
      @required this.height,
      @required this.text,
      @required this.press})
      : super(key: key);

  final Size size;
  final String text;
  final Function press;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FlatButton(
          onPressed: press,
          child: Text(
            text,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          color: Colors.lightGreen[900],
        ),
      ),
    );
  }
}
