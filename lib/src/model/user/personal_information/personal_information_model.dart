import 'dart:io';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalInformationModel {
  String fullName;
  String email;
  String profession;
  String phoneNumber;
  String organization;
  String address;
  String website;
  String aboutMe;
  String profileImageUrl;

  // for ui purposes
  // would go in the controller class actually
  File inputProfileImage;

  PersonalInformationModel(
      {@required this.fullName,
      this.email,
      @required this.profession,
      this.phoneNumber,
      this.organization,
      this.address,
      this.website,
      this.aboutMe,
      this.profileImageUrl});

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'profession': profession,
      'phoneNumber': phoneNumber,
      'organization': organization,
      'address': address,
      'website': website,
      'aboutMe': aboutMe,
      'profileImageUrl': profileImageUrl
    };
  }

  factory PersonalInformationModel.fromSnapshot(DocumentSnapshot snap) {
    return PersonalInformationModel(
        fullName: snap.data['fullName'],
        profession: snap.data['profession'],
        email: snap.data['email'],
        phoneNumber: snap.data['phoneNumber'],
        organization: snap.data['organization'],
        website: snap.data['website'],
        aboutMe: snap.data['aboutMe'],
        address: snap.data['address'],
        profileImageUrl: snap.data['profileImageUrl']);
  }
}
