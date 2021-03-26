import 'package:flutter/material.dart';

//dericved dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/utils/updateProfilePicture.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//app dependencies
import '../loading.dart';
import '../utils/AuthServices.dart';
import '../constants.dart';
import '../provider/user_details.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _keyLoader = GlobalKey();

  void callSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userDetails = Provider.of<UserDetails>(context);
    String _uid = userDetails.user_id;
    String _name = userDetails.user_name;
    String _email = userDetails.userEmailID;
    String _profession = userDetails.userProfession;
    String _phoneNumber = userDetails.userPhoneNumber;
    String _org = userDetails.userOrganization;
    //String _photoURL = userDetails.user_image_url;
    return isLoading
        ? LoadingFullScreen()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              title: Text(
                "Edit your profile",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            backgroundColor: Color(0xFFF8F8F8),
            body: ChangeNotifierProvider<UserDetails>(
              create: (_) => UserDetails(),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    height: size.height - 56.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: size.width * 0.8,
                          height: size.height * 0.2,
                          child: Center(
                            child: Column(
                              children: [
                                UpdateProfilePicture(
                                  size: size,
                                  imageRadius: 0.4,
                                  userImageURL: userDetails.user_image_url,
                                  uid: _uid,
                                  func: callSetState,
                                  keyLoader: _keyLoader,
                                ),
                                Text(
                                  "Change profile Photo",
                                  style:
                                      GoogleFonts.poppins(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 50.0,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue:
                                (_name?.isNotEmpty ?? true) ? _name : null,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Name Required';
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldInputDecoration.copyWith(
                              hintText: "Enter Name",
                              labelText: "Name",
                              suffixIcon: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 12,
                              ),
                            ),
                            onChanged: (value) {
                              // save the name value here
                              _name = value;
                            },
                            onSaved: (value) => _name = value,
                          ),
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 50.0,
                          child: TextFormField(
                            initialValue:
                                (_email?.isNotEmpty ?? true) ? _email : null,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Email Required';
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldInputDecoration.copyWith(
                                hintText: "Enter Email address",
                                labelText: "Email address",
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 12,
                                )),
                            onChanged: (value) {
                              // save the name value here
                              _email = value;
                            },
                            onSaved: (value) => _email = value,
                          ),
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 50.0,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: (_profession?.isNotEmpty ?? true)
                                ? _profession
                                : null,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Profession Required';
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldInputDecoration.copyWith(
                              hintText: "Enter Profession",
                              labelText: "Profession",
                              suffixIcon: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 12,
                              ),
                            ),
                            onSaved: (value) {
                              _profession = value;
                            },
                            onChanged: (value) {
                              // save the name value here
                              _profession = value;
                            },
                          ),
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 50.0,
                          child: TextFormField(
                            initialValue: (_phoneNumber?.isNotEmpty ?? true)
                                ? _phoneNumber
                                : null,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isNotEmpty && value.length != 10) {
                                return 'Enter Valid Phone number';
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldInputDecoration.copyWith(
                              hintText: "Enter Number",
                              labelText: "Phone Number",
                              suffixIcon: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 12,
                              ),
                            ),
                            onSaved: (value) {
                              _phoneNumber = value;
                            },
                            onChanged: (value) {
                              // save the name value here
                              _phoneNumber = value;
                            },
                          ),
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 50.0,
                          child: TextFormField(
                            initialValue:
                                (_org?.isNotEmpty ?? true) ? _org : null,
                            keyboardType: TextInputType.text,
                            decoration: kTextFieldInputDecoration.copyWith(
                              hintText: "Enter Organization Number",
                              labelText: "Organization",
                              suffixIcon: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 12,
                              ),
                            ),
                            onChanged: (value) {
                              // save the name value here
                              _org = value;
                            },
                            onSaved: (value) {
                              _org = value;
                            },
                          ),
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 40.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: FlatButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  //show spinner till saving the data
                                  _formKey.currentState.save();
                                  setState(() {
                                    isLoading = true;
                                  });

                                  //now save this to firestore
                                  _firestore
                                      .collection('userData')
                                      .document('$_uid')
                                      .updateData({
                                    "name": _name,
                                    "email": _email,
                                    "phoneNumber": _phoneNumber,
                                    "profession": _profession,
                                    "organization": _org
                                  }).then((value) {
                                    userDetails.setUserDetails(
                                        userEmailID: _email,
                                        userName: _name,
                                        userID: _uid,
                                        userProfession: _profession,
                                        userPhoneNumber: _phoneNumber,
                                        userOrganization: _org);
//                                  userDetails
//                                      .setUserDetails(_uid, _name, _phoneNumber, "", _org, _profession, _email);

                                    print(
                                        "EditProfileScreen()''': user details updated in firestore $_name");
                                    print(
                                        "EditProfileScreen()''': user details updated in provider ${userDetails.user_name} ");
                                    Navigator.pop(context);
                                  }).catchError((e) {
                                    print(
                                        "EditProfileScreen()''': Eror in savnig details ");
                                  });
//                              _userToPass.name = this.widget.name;
//                              _userToPass.email = this.widget.email;
//                              _userToPass.profileImageURL =
//                                  this.widget.photourl;
//                              _userToPass.phoneNumber = this.widget.phoneNumber;
//                              _firestore
//                                  .collection('userData')
//                                  .document('${this.widget.uid}')
//                                  .setData(User.toJson(_userToPass))
//                                  .whenComplete(() {
//                                print(
//                                    "ProfileSetupScreen()''':User added Success");
                                  //push to home screen
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => HomeScreen()));
//                              }).catchError((e) {
//                                print(
//                                    "ProfileScreenSetup()''': Error while adding the user");
//                                setState(() {
//                                  loading = false;
//                                });
//                              });
                                }
                              },
                              child: Text(
                                "Update Profile",
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
            ),
          );
  }

//  void setUserDetails(
//    Userdetails userDetails,
//  ) {
//    userDetails.user_image_url = snap['profileImageURl'];
//    userDetails.user_id = snap.documentID;
//    userDetails.user_name = snap['name'];
//    userDetails.user_number = snap['phoneNumber'];
//    userDetails.user_email_id = snap['email'];
//    userDetails.user_organization = snap['organization'];
//    userDetails.user_profession = snap['profession'];
//  }
}
