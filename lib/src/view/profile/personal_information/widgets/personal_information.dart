import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

// app directories
import 'package:kisaanCorner/src/model/user/personal_information/personal_information_model.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/widgets/custom_editfield_wrapper.dart';

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

class PersonalInformation extends StatefulWidget {
  final ScrollController completeYourProfileScrollController;
  final PersonalInformationModel personalInformationModel;
  final personalInformationFormKey;
  final String signInMethod;

  PersonalInformation(
      {this.completeYourProfileScrollController,
      @required this.personalInformationModel,
      this.personalInformationFormKey,
      this.signInMethod});

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  // Helper functions to convert enum to string
  String enumToString(Object o) => o.toString().split('.').last;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.personalInformationFormKey,
      child: Column(
        children: [
          CustomEditFieldWrapper(
                  personalInformationModel: widget.personalInformationModel,
                  textFieldType: enumToString(TextFiledTypeEnum.fullName),
                  isEditable: (widget.signInMethod == 'Google') ? false : true,
                  fieldHeight: 35)
              .addEditText(),
          CustomEditFieldWrapper(
                  personalInformationModel: widget.personalInformationModel,
                  textFieldType: enumToString(TextFiledTypeEnum.email),
                  isEditable: (widget.signInMethod == 'Google') ? false : true,
                  fieldHeight: 35)
              .addEditText(),
          CustomEditFieldWrapper(
                  personalInformationModel: widget.personalInformationModel,
                  textFieldType: enumToString(TextFiledTypeEnum.profession),
                  fieldHeight: 35)
              .addEditText(),
          CustomEditFieldWrapper(
                  personalInformationModel: widget.personalInformationModel,
                  textFieldType: enumToString(TextFiledTypeEnum.phoneNumber),
                  isEditable:
                      (widget.signInMethod == 'PhoneNumber') ? false : true,
                  fieldHeight: 35)
              .addEditText(),
          CustomEditFieldWrapper(
                  personalInformationModel: widget.personalInformationModel,
                  textFieldType: enumToString(TextFiledTypeEnum.organization),
                  fieldHeight: 35)
              .addEditText(),
          CustomEditFieldWrapper(
                  personalInformationModel: widget.personalInformationModel,
                  textFieldType: enumToString(TextFiledTypeEnum.address),
                  fieldHeight: 70)
              .addEditText(),
          CustomEditFieldWrapper(
                  personalInformationModel: widget.personalInformationModel,
                  textFieldType: enumToString(
                    TextFiledTypeEnum.website,
                  ),
                  fieldHeight: 35)
              .addEditText(),
          CustomEditFieldWrapper(
                  personalInformationModel: widget.personalInformationModel,
                  textFieldType: enumToString(
                    TextFiledTypeEnum.aboutMe,
                  ),
                  fieldHeight: 180)
              .addEditText(),
        ],
      ),
    );
  }
}
