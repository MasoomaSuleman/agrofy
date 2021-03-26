import 'package:flutter/foundation.dart';
import 'package:kisaanCorner/src/model/question/subcategory.dart';

class CategoryModel {
 final String type;
 final String name;
 final bool isActive;
 final List<SubCategory> subcategory ;
 bool isChecked;
  CategoryModel(
    {
     @required this.isActive,
     @required this.name,
     @required this.type,
     @required this.subcategory, 
       this.isChecked=false,
    }
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["name"],
      type: json['type'],
      isActive: json['isActive'],
      subcategory: json['subcategory']
    );
  }
  toJson() {
    return {
      "name": name,
      "type": type,
      "isActive":isActive,
      "subcategory": subcategory,
    };
  }
  
}

