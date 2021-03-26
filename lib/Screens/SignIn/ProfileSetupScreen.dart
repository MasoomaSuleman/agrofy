import 'package:flutter/material.dart';

//added dependenciew
import 'package:google_fonts/google_fonts.dart';

// app dependencies
import 'package:kisaanCorner/Screens/SignIn/ui_components/updateProfilePicture.dart';
import 'package:kisaanCorner/constants.dart';
import 'package:kisaanCorner/Screens/SignIn/services/saveUserDetailsToFirebase.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String name;
  final String email;
  final String photoUrl;
  final String phoneNumber;
  final String uid;

  ProfileSetupScreen(
      {this.name, this.email, this.photoUrl, this.uid, this.phoneNumber});

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
      uid: uid);
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final String name;
  final String email;
  final String photoUrl;
  final String phoneNumber;
  final String uid;

  _ProfileSetupScreenState(
      {this.phoneNumber, this.uid, this.photoUrl, this.email, this.name});

  final _formKey = GlobalKey<FormState>();
  final _keyLoader = GlobalKey();

  TextEditingController _nameTEC = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  TextEditingController _emailTEC = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  TextEditingController _professionTEC = TextEditingController();
  final FocusNode _professionFocus = FocusNode();
  TextEditingController _phoneNumberTEC = TextEditingController();
  final FocusNode _phoneNumberFocus = FocusNode();
  TextEditingController _organizationTEC = TextEditingController();
  final FocusNode _organizationFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    _nameTEC.text = ((name?.isNotEmpty) ?? true) ? name : null;
    _emailTEC.text = ((email?.isNotEmpty) ?? true) ? email : null;
    _phoneNumberTEC.text =
        ((phoneNumber?.isNotEmpty) ?? true) ? phoneNumber?.substring(3) : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final appBar = AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        "Complete your profile",
        style: GoogleFonts.poppins(color: Colors.black),
      ),
    );
    return SafeArea(
        child: Scaffold(
      appBar: appBar,
      backgroundColor: Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: _size.width,
            height: _size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: UpdateProfilePicture(
                      _size, 40.0, photoUrl, uid, _keyLoader),
                ),
                Container(
                  width: _size.width * 0.8,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: new TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'Full Name ',
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 10),
                          ),
                          TextSpan(
                            text: '*',
                            style: GoogleFonts.poppins(
                                color: Colors.red, fontSize: 10),
                          )
                        ]),
                      ),
                      SizedBox(
                        width: _size.width * 0.8,
                        height: 35,
                        child: TextFormField(
                          controller: _nameTEC,
                          focusNode: _nameFocus,
                          onFieldSubmitted: (_) => _fieldFocusChange(
                              context, _nameFocus, _emailFocus),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Name Required';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            fillColor: Colors.transparent,
                            hintStyle: TextStyle(color: Colors.grey),
                           contentPadding: EdgeInsets.fromLTRB(2, 20, 2, 4),
                            filled: true,
                          ),
                          onChanged: (value) {
                            // save the name value here
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _size.width * 0.8,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 10),
                      ),
                      SizedBox(
                        width: _size.width * 0.8,
                        height: 35,
                        child: TextFormField(
                          controller: _emailTEC,
                          focusNode: _emailFocus,
                          onFieldSubmitted: (_) => _fieldFocusChange(
                              context, _emailFocus, _professionFocus),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            fillColor: Colors.transparent,
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.fromLTRB(2, -8, 2, 2),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _size.width * 0.8,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: new TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'Profession ',
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 10),
                          ),
                          TextSpan(
                            text: '*',
                            style: GoogleFonts.poppins(
                                color: Colors.red, fontSize: 10),
                          )
                        ]),
                      ),
                      SizedBox(
                        width: _size.width * 0.8,
                        height: 35,
                        child: TextFormField(
                          controller: _professionTEC,
                          focusNode: _professionFocus,
                          onFieldSubmitted: (_) => _fieldFocusChange(
                              context, _professionFocus, _phoneNumberFocus),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            fillColor: Colors.transparent,
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.fromLTRB(2, 20, 2, 4),
                            filled: true,
                          ),
                          onChanged: (value) {
                            // save the name value here
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _size.width * 0.8,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number",
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 10),
                      ),
                      SizedBox(
                        width: _size.width * 0.8,
                        height: 35,
                        child: TextFormField(
                          controller: _phoneNumberTEC,
                          focusNode: _phoneNumberFocus,
                          onFieldSubmitted: (_) => _fieldFocusChange(
                              context, _phoneNumberFocus, _organizationFocus),
                          textInputAction: TextInputAction.next,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value.isNotEmpty && value.length != 10) {
                              return 'Enter Valid Phone number';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            fillColor: Colors.transparent,
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.fromLTRB(2, -8, 2, 2),
                            filled: true,
                          ),
                          onChanged: (value) {
                            // save the name value here
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _size.width * 0.8,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Organization",
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 10),
                      ),
                      SizedBox(
                        width: _size.width * 0.8,
                        height: 35,
                        child: TextFormField(
                          controller: _organizationTEC,
                          focusNode: _organizationFocus,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            fillColor: Colors.transparent,
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.fromLTRB(2, -8, 2, 2),
                            filled: true,
                          ),
                          onChanged: (value) {
                            // save the name value here
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _size.width * 0.8,
                  height: 40.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await SaveUserDetailsToFirebase
                              .onCLickSaveDetailsToFirebaseUser(
                                  context: context,
                                  userId: uid,
                                  userName: _nameTEC.text,
                                  userEmail: _emailTEC.text,
                                  userPhoneNumber: _phoneNumberTEC.text,
                                  userImageURL: photoUrl,
                                  userProfession: _professionTEC.text,
                                  userOrganization: _organizationTEC.text,
                                  keyLoader: _keyLoader);
                          //show spinner till saving the data
                        }
                      },
                      child: Text(
                        "Complete Profile",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      color: kPrimaryButton,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
