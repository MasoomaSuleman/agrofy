import 'package:flutter/material.dart';
import 'package:kisaanCorner/src/model/user/other_details/achievment_model.dart';
import 'package:kisaanCorner/src/model/user/other_details/experience_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

import 'package:kisaanCorner/src/view/profile/widgets/custom_editfield.dart';
import 'package:kisaanCorner/src/model/user/personal_information/personal_information_model.dart';

class CustomEditFieldWrapper {
  final PersonalInformationModel personalInformationModel;
  String textFieldType;
  final double fieldHeight;
  final Experience experienceModel;
  final Achievements achievmentsModel;
  final bool isEditable;
  CustomEditFieldWrapper(
      {this.personalInformationModel,
      this.textFieldType,
      this.fieldHeight,
      this.experienceModel,
      this.achievmentsModel,
      this.isEditable});
  CustomEditField custom;

  addEditText() {
    return custom = CustomEditField(
      isRequired: getIsRequired(),
      lableText: getLable(),
      fieldHeight: fieldHeight,
      textInputType: getInputType(),
      textInputAction: getTextInputAction(),
      inputFormatter: getTextInputFormatter(),
      onFieldUpdate: onFieldUpdate,
      errorText: getErrorText(),
      maxLines: getmaxLines(),
      validatorType: getValidatorType(),
      initialValue: getInitialValue(),
      isEditable: getIsEditable(),
    );
  }

  //TODO: Instead of sending the validator type send the validation function
  // but the problem is it needs to call the setstate function that is not accessible here

  getIsEditable() {
    switch (textFieldType) {
      case 'fullName':
        if (isEditable == null)
          return true;
        else
          return isEditable;
        break;
      case 'email':
        if (isEditable == null)
          return true;
        else
          return isEditable;
        break;
      case 'phoneNumber':
        if (isEditable == null)
          return true;
        else
          return isEditable;
        break;
      case 'profession':
        if (isEditable == null)
          return true;
        else
          return isEditable;
        break;
      case 'organization':
        if (isEditable == null)
          return true;
        else
          return isEditable;
        break;
      case 'address':
        if (isEditable == null)
          return true;
        else
          return isEditable;
        break;
      case 'website':
        if (isEditable == null)
          return true;
        else
          return isEditable;
        break;
      case 'aboutMe':
        if (isEditable == null)
          return true;
        else
          return isEditable;
        break;
      case 'title':
      if (isEditable == null)
        return true;
      else
        return isEditable;
      break;
      case 'companyName':
      if (isEditable == null)
        return true;
      else
        return isEditable;
      break;
      case 'location':
      if (isEditable == null)
        return true;
      else
        return isEditable;
      break;
      case 'titleA':
      if (isEditable == null)
        return true;
      else
        return isEditable;
      break;
      case 'occupationName':
      if (isEditable == null)
        return true;
      else
        return isEditable;
      break;
      case 'issuer':
      if (isEditable == null)
        return true;
      else
        return isEditable;
      break;
    }
  }

  getInitialValue() {
    switch (textFieldType) {
      case 'fullName':
        return (personalInformationModel.fullName != null)
            ? personalInformationModel.fullName
            : null;
        break;
      case 'email':
        return (personalInformationModel.email != null)
            ? personalInformationModel.email
            : null;
        break;
      case 'phoneNumber':
        return (personalInformationModel.phoneNumber != null)
            ? (personalInformationModel.phoneNumber.isNotEmpty)
                ? (personalInformationModel.phoneNumber.length > 10)
                    ? personalInformationModel.phoneNumber.substring(3)
                    : personalInformationModel.phoneNumber
                : null
            : null;
        break;
      case 'title':
       return (experienceModel.title != null) ?
          experienceModel.title
          : null;
      case 'companyName':
       return (experienceModel.title != null) ?
          experienceModel.companyName
          : null;
      case 'location':
       return (experienceModel.location != null) ?
          experienceModel.location
          : null;
      case 'titleA':
       return (achievmentsModel.title != null) ?
       achievmentsModel.title
      : null;
      case 'occupationName':
       return (achievmentsModel.occupation != null) ?
       achievmentsModel.occupation
      : null;
      case 'issuer':
       return (achievmentsModel.issuer != null) ?
       achievmentsModel.issuer
      : null;
      case 'profession':
        return (personalInformationModel.profession != null)
            ? personalInformationModel.profession
            : null;
        break;
      case 'organization':
        return (personalInformationModel.organization != null)
            ? personalInformationModel.organization
            : null;
        break;
      case 'address':
        return (personalInformationModel.address != null)
            ? personalInformationModel.address
            : null;
        break;
      case 'website':
        return (personalInformationModel.website != null)
            ? personalInformationModel.website
            : null;
        break;
      case 'aboutMe':
        return (personalInformationModel.aboutMe != null)
            ? personalInformationModel.aboutMe
            : null;
        break;
    }
  }

  getValidatorType() {
    switch (textFieldType) {
      case 'fullName':
        return 'isRequired';
        break;
      case 'email':
        return 'email';
        break;
      case 'profession':
        return 'isRequired';
        break;
      case 'phoneNumber':
        return 'phoneNumber';
        break;
      case 'organization':
        return null;
        break;
      case 'address':
        return null;
        break;
      case 'website':
        return null;
        break;
      case 'aboutMe':
        return null;
        break;
      case 'title':
        return 'isRequired';
        break;
      case 'companyName':
        return 'isRequired';
        break;
      case 'location':
        return null;
        break;
      case 'titleA':
        return 'isRequired';
        break;
      case 'occupationName':
        return 'isRequired';
        break;
      case 'issuer':
        return 'isRequired';
        break;
    }
  }

//  getValidatorFunction() {
//    switch (textFieldType) {
//      case 'fullName':
//        return (value){};
//        break;
//      case 'email':
//        return false;
//        break;
//      case 'profession':
//        return true;
//        break;
//      case 'phoneNumber':
//        return false;
//        break;
//      case 'organization':
//        return false;
//        break;
//      case 'address':
//        return false;
//        break;
//      case 'website':
//        return false;
//        break;
//      case 'aboutMe':
//        return false;
//        break;
//    }
//  }

  getIsRequired() {
    switch (textFieldType) {
      case 'fullName':
        return true;
        break;
      case 'email':
        return false;
        break;
      case 'profession':
        return true;
        break;
      case 'phoneNumber':
        return false;
        break;
      case 'organization':
        return false;
        break;
      case 'address':
        return false;
        break;
      case 'website':
        return false;
        break;
      case 'aboutMe':
        return false;
        break;
      case 'title':
        return true;
        break;
      case 'companyName':
        return true;
        break;
      case 'location':
        return false;
        break;
      case 'titleA':
        return true;
        break;
      case 'occupationName':
        return true;
        break;
      case 'issuer':
        return true;
        break;
    }
  }

  getLable() {
    switch (textFieldType) {
      case 'fullName':
        return 'Full Name *';
        break;
      case 'email':
        return 'Email';
        break;
      case 'profession':
        return 'Profession *';
        break;
      case 'phoneNumber':
        return 'Phone Number';
        break;
      case 'organization':
        return 'Organization';
        break;
      case 'address':
        return 'Address';
        break;
      case 'website':
        return 'Website';
        break;
      case 'aboutMe':
        return 'About Me';
        break;
      case 'title':
        return 'Title *';
        break;
      case 'companyName':
        return 'Company Name *';
        break;
      case 'location':
        return 'Location';
        break;
      case 'titleA':
        return 'Title *';
        break;
      case 'occupationName':
        return 'Occupation Name *';
        break;
      case 'issuer':
        return 'Issuer *';
        break;
    }
  }

  getInputType() {
    switch (textFieldType) {
      case 'fullName':
        return TextInputType.name;
        break;
      case 'email':
        return TextInputType.emailAddress;
        break;
      case 'profession':
        return TextInputType.text;
        break;
      case 'phoneNumber':
        return TextInputType.phone;
        break;
      case 'organization':
        return TextInputType.text;
        break;
      case 'address':
        return TextInputType.multiline;
        break;
      case 'website':
        return TextInputType.url;
        break;
      case 'aboutMe':
        return TextInputType.multiline;
        break;
      case 'title':
        return TextInputType.text;
        break;
      case 'companyName':
        return TextInputType.text;
        break;
      case 'location':
        return TextInputType.multiline;
        break;
      case 'titleA':
        return TextInputType.text;
        break;
      case 'occupationName':
        return TextInputType.text;
        break;
      case 'issuer':
        return TextInputType.text;
        break;
    }
  }

  getTextInputFormatter() {
    switch (textFieldType) {
      case 'fullName':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
          FilteringTextInputFormatter.singleLineFormatter
        ];
        break;
      case 'email':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
        break;
      case 'profession':
        return <TextInputFormatter>[];
        break;
      case 'phoneNumber':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.singleLineFormatter,
          LengthLimitingTextInputFormatter(10),
        ];
        break;
      case 'organization':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
        break;
      case 'address':
        return <TextInputFormatter>[];
        break;
      case 'website':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
        break;
      case 'aboutMe':
        return <TextInputFormatter>[];
        break;
      case 'title':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
        break;
      case 'companyName':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
        break;
      case 'location':
        return <TextInputFormatter>[];
        break;
      case 'titleA':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
        break;
      case 'occupationName':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
        break;
      case 'issuer':
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
        break;
    }
  }

  onFieldUpdate(String value) {
    switch (textFieldType) {
      case 'fullName':
        personalInformationModel.fullName = value;
        break;
      case 'email':
        personalInformationModel.email = value;
        break;
      case 'profession':
        personalInformationModel.profession = value;
        break;
      case 'phoneNumber':
        personalInformationModel.phoneNumber = value;
        break;
      case 'organization':
        personalInformationModel.organization = value;
        break;
      case 'address':
        personalInformationModel.address = value;
        break;
      case 'website':
        personalInformationModel.website = value;
        break;
      case 'aboutMe':
        personalInformationModel.aboutMe = value;
        break;
      case 'title':
        experienceModel.title = value;
        break;
      case 'companyName':
        experienceModel.companyName = value;
        break;
      case 'location':
        experienceModel.location = value;
        break;
      case 'titleA':
        achievmentsModel.title = value;
        break;
      case 'occupationName':
        achievmentsModel.occupation = value;
        break;
      case 'issuer':
        achievmentsModel.issuer = value;
        break;
    }
  }

  getErrorText() {
    switch (textFieldType) {
      case 'fullName':
        return 'This is a required question';
        break;
      case 'email':
        return 'Enter valid Email Address';
        break;
      case 'profession':
        return 'This is a required question';
        break;
      case 'phoneNumber':
        return 'Enter valid phone number';
        break;
      case 'organization':
        return '';
        break;
      case 'address':
        return '';
        break;
      case 'website':
        return '';
        break;
      case 'aboutMe':
        return '';
        break;
      case 'title':
        return 'This is a required question';
        break;
      case 'companyName':
        return 'This is a required question';
        break;
      case 'location':
        return '';
        break;
      case 'titleA':
        return 'This is a required question';
        break;
      case 'occupationName':
        return 'This is a required question';
        break;
      case 'issuer':
        return 'This is a required question';
        break;
    }
  }

  getTextInputAction() {
    switch (textFieldType) {
      case 'fullName':
        // TODO: Instead of null chane focus
        return null;
        break;
      case 'email':
        return null;
        break;
      case 'profession':
        return null;
        break;
      case 'phoneNumber':
        return null;
        break;
      case 'organization':
        return null;
        break;
      case 'address':
        return TextInputAction.newline;
        break;
      case 'website':
        return null;
        break;
      case 'aboutMe':
        return TextInputAction.newline;
        break;
      case 'title':
        return null;
        break;
      case 'companyName':
        return null;
        break;
      case 'location':
        return TextInputAction.newline;
        break;
      case 'titleA':
        return null;
        break;
      case 'occupationName':
        return null;
        break;
      case 'issuer':
        return null;
        break;
    }
  }

  getmaxLines() {
    switch (textFieldType) {
      case 'fullName':
        return null;
        break;
      case 'email':
        return null;
        break;
      case 'profession':
        return null;
        break;
      case 'phoneNumber':
        return null;
        break;
      case 'organization':
        return null;
        break;
      case 'address':
        return 2;
        break;
      case 'website':
        return null;
        break;
      case 'aboutMe':
        return 8;
        break;
      case 'title':
        return null;
        break;
      case 'companyName':
        return null;
        break;
      case 'location':
        return 2;
        break;
      case 'titleA':
        return null;
        break;
      case 'occupationName':
        return null;
        break;
      case 'issuer':
        return null;
        break;
    }
  }
}
