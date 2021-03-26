import 'package:flutter/foundation.dart';

class SubCategory {
 final String type;
 final String name;
 final bool isActive;
 bool isChecked;
  SubCategory(
    {
     @required this.isActive,
     @required this.name,
     @required this.type,
     this.isChecked=false,
    }
  );

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      name: json["name"],
      type: json['type'],
      isActive: json['isActive'],
    );
  }
  toJson() {
    return {
      "name": name,
      "type": type,
      "isActive":isActive,
    };
  }
  
}

