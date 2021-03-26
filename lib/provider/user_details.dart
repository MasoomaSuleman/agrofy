import 'package:flutter/material.dart';

class UserDetails with ChangeNotifier {
  String _user_id;
  String _user_name;
  String _userPhoneNumber;
  String _user_image_url;
  String _userOrganization;
  String _userProfession;
  String _userEmailID;

  static Map<String, dynamic> toJson(UserDetails user) => {
        'name': user._user_name,
        'email': user._userEmailID,
        'profession': user._userProfession,
        'phoneNumber': user._userPhoneNumber,
        'organization': user._userOrganization,
        'profileImageURl': user._user_image_url
      };

  void setUserDetails(
      {String userID,
      String userName,
      String userPhoneNumber,
      String imageUrl,
      String userOrganization,
      String userProfession,
      String userEmailID}) {
    this._user_id = userID;
    this._user_name = userName;
    this._userPhoneNumber = userPhoneNumber;
    this._user_image_url = imageUrl;
    this._userOrganization = userOrganization;
    this._userProfession = userProfession;
    this._userEmailID = userEmailID;

    // notifyListeners();
  }

  void deleteUserData() {
    this._user_id = null;
    this._user_name = null;
    this._userPhoneNumber = null;
    this._user_image_url = null;
    this._userOrganization = null;
    this._userProfession = null;
    this._userEmailID = null;
    notifyListeners();
  }

  String get user_id => _user_id;

  String get user_image_url => _user_image_url;

  String get user_name => _user_name;

  String get userOrganization => _userOrganization;

  String get userProfession => _userProfession;

  String get userPhoneNumber => _userPhoneNumber;

  String get userEmailID => _userEmailID;

  set userEmailID(String value) {
    _userEmailID = value;
  }

  set userProfession(String value) {
    _userProfession = value;
  }

  set userOrganization(String value) {
    _userOrganization = value;
  }

  set user_image_url(String value) {
    _user_image_url = value;
  }

  set userPhoneNumber(String value) {
    _userPhoneNumber = value;
  }

  set user_name(String value) {
    _user_name = value;
  }

  set user_id(String value) {
    _user_id = value;
  }
}
