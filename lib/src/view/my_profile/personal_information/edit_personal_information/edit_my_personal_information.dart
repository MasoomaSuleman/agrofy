import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// added dependnecies
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/core/widgets/alert_dialogs.dart';
import 'package:kisaanCorner/src/model/user/personal_information/personal_information_model.dart';
import 'package:kisaanCorner/utils/SizeConfig.dart';
import 'package:provider/provider.dart';

// app dependencies
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/widgets/change_profile_photo.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/widgets/custom_editfield_wrapper.dart';
import 'package:kisaanCorner/src/view/profile/widgets/custom_button.dart';

enum TextFiledTypeEnum {
  fullName,
  email,
  profession,
  phoneNumber,
  organization,
  address,
  website,
  aboutMe
}

class EditMyPersonalInformationPage extends StatefulWidget {
  @override
  _EditMyPersonalInformationPageState createState() =>
      _EditMyPersonalInformationPageState();
}

class _EditMyPersonalInformationPageState
    extends State<EditMyPersonalInformationPage> {
  final _personalInfoFormKey = GlobalKey<FormState>();
  final ScrollController _editPersonalInformationScrollController =
      ScrollController();
  String enumToString(Object o) => o.toString().split('.').last;
  bool _buttonIsClickable = true;

  @override
  Widget build(BuildContext context) {
    User _currentUser = Provider.of<User>(context);
    PersonalInformationModel personalInformationModel =
        _currentUser.personalInformation;

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
            "Edit",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: SizeConfig.screenWidth,
          child: SingleChildScrollView(
              controller: _editPersonalInformationScrollController,
              child: Form(
                key: _personalInfoFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    ChangeProfilePhoto(
                        personalInformationModel:
                            _currentUser.personalInformation,
                        defaultProfileImageUrl:
                            personalInformationModel.profileImageUrl),
                    SizedBox(
                      height: 20,
                    ),
                    CustomEditFieldWrapper(
                            personalInformationModel: personalInformationModel,
                            textFieldType:
                                enumToString(TextFiledTypeEnum.fullName),
                            fieldHeight: 35,
                            isEditable: false
//                              (_currentUser.signInMethod == 'Google')
//                                ? false
//                                : true
                            )
                        .addEditText(),
                    CustomEditFieldWrapper(
                            personalInformationModel: personalInformationModel,
                            textFieldType:
                                enumToString(TextFiledTypeEnum.email),
                            isEditable: (_currentUser.signInMethod == 'Google')
                                ? false
                                : true,
                            fieldHeight: 35)
                        .addEditText(),
                    CustomEditFieldWrapper(
                            personalInformationModel: personalInformationModel,
                            textFieldType:
                                enumToString(TextFiledTypeEnum.profession),
                            fieldHeight: 35)
                        .addEditText(),
                    CustomEditFieldWrapper(
                            personalInformationModel: personalInformationModel,
                            textFieldType:
                                enumToString(TextFiledTypeEnum.phoneNumber),
                            isEditable:
                                (_currentUser.signInMethod == 'PhoneNumber')
                                    ? false
                                    : true,
                            fieldHeight: 35)
                        .addEditText(),
                    CustomEditFieldWrapper(
                            personalInformationModel: personalInformationModel,
                            textFieldType:
                                enumToString(TextFiledTypeEnum.organization),
                            fieldHeight: 35)
                        .addEditText(),
                    CustomEditFieldWrapper(
                            personalInformationModel: personalInformationModel,
                            textFieldType:
                                enumToString(TextFiledTypeEnum.address),
                            fieldHeight: 70)
                        .addEditText(),
                    CustomEditFieldWrapper(
                            personalInformationModel: personalInformationModel,
                            textFieldType: enumToString(
                              TextFiledTypeEnum.website,
                            ),
                            fieldHeight: 35)
                        .addEditText(),
                    CustomEditFieldWrapper(
                            personalInformationModel: personalInformationModel,
                            textFieldType: enumToString(
                              TextFiledTypeEnum.aboutMe,
                            ),
                            fieldHeight: 180)
                        .addEditText(),
                    SizedBox(
                      height: 30,
                    ),
                    (_buttonIsClickable)
                        ? CustomButton(
                            text: 'Done',
                            press: () async {
                              // on press for this button
                              if (_personalInfoFormKey.currentState
                                  .validate()) {
                                _personalInfoFormKey.currentState.save();
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                // disable the save button
                                // now save the new details to user model
                                setState(() {
                                  _buttonIsClickable = false;
                                });

                                _currentUser
                                    .editPersonalInformation(
                                        context: context,
                                        personalInformationModel:
                                            personalInformationModel)
                                    .then((value) {
                                  if (value) {
                                    // details saved successfully
                                    print(
                                        "EditMyPersonalInformationPage()''': New personal Info saved success: ${_currentUser.personalInformation.profession}");
                                    // enable the save button and go back
                                    setState(() {
                                      _buttonIsClickable = true;
                                    });
                                    AlertDialogs _alert = AlertDialogs();
                                    _alert.showAlertDialogWithOKbutton(
                                        context,
                                        'User details updated successfully.',
                                        2);
                                  } else {
                                    // details not saved
                                    print(
                                        "EditMyPersonalInformationPage()''': save new info failed: ${_currentUser.personalInformation.profession}");
                                    // enable the save button
                                    setState(() {
                                      _buttonIsClickable = true;
                                    });
                                  }
                                });
                              } else {
                                _editPersonalInformationScrollController
                                    .animateTo(
                                  0.0,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 500),
                                );
                              }
                            },
                          )
                        : Opacity(
                            opacity: 0.3,
                            child: CustomButton(
                              text: 'Done',
                              press: () {},
                            ),
                          ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
