import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Achievements {
  String title;
  String occupation;
  String issuer;
  String honorDate;

  Achievements(
      {@required this.title,
      @required this.occupation,
      @required this.issuer,
      @required this.honorDate});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'occupation': occupation,
      'issuer': issuer,
      'honorDate': honorDate,
    };
  }
  toJson() {
    return {
      'title': title,
      'occupation': occupation,
      'issuer': issuer,
      'honorDate': honorDate,
    };
  }
  factory Achievements.fromSnapshot(DocumentSnapshot snap) {
    return Achievements(
      title: snap.data['title'],
      occupation: snap.data['occupation'],
      issuer: snap.data['issuer'],
      honorDate: snap.data['honorDate'],
    );
  }
  factory Achievements.fromJson(Map<String, dynamic> json) {
    return Achievements(
      title: json["title"],
      occupation: json["occupation"],
      issuer: json["issuer"],
      honorDate: json["honorDate"],
    );
  }
}
