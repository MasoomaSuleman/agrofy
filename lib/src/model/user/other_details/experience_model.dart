import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Experience {
  String title;
  String employmentType;
  String companyName;
  String location;
  String startDate;
  String lastDate;
  bool showProfile;

  Experience({
    @required this.title,
    @required this.employmentType,
    @required this.companyName,
    @required this.lastDate,
    @required this.startDate,
    @required this.showProfile,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'employmentType': employmentType,
      'companyName': companyName,
      'location': location,
      'startDate': startDate,
      'lastDate': lastDate,
      'showProfile': showProfile
    };
  }
  toJson() {
    return {
      'title': title,
      'employmentType': employmentType,
      'companyName': companyName,
      'location': location,
      'startDate': startDate,
      'lastDate': lastDate,
      'showProfile': showProfile
    };
  }
  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
        title: json["title"],
        employmentType: json["employmentType"],
        companyName: json["companyName"],
        lastDate: json["lastDate"],
        startDate: json["startDate"],
        showProfile: json["showProfile"],
        location: json["location"]);
  }

  factory Experience.fromSnapshot(DocumentSnapshot snap) {
    return Experience(
      title: snap.data['title'],
      employmentType: snap.data['employmentType'],
      companyName: snap.data['companyName'],
      location: snap.data['location'],
      startDate: snap.data['startDate'],
      lastDate: snap.data['lastDate'],
      showProfile: snap.data['showProfile'],
    );
  }
}
