import 'package:flutter/material.dart';
import 'dart:math';

// button primary colors
const kPrimaryButton = Color(0xFF323131); // this is the grey color buttons
const Color kGreyColor = Color(0xffA2A2A2);
const Color kLightGreyColor = Color(0xffF3F3F3);
const Color kTextColor = Color(0xffAEAEAE);
const Color kBackgroundColor = Color(0xffF8F8F8);

const String kDefaultUserImageUrl =
    'https://firebasestorage.googleapis.com/v0/b/gst-app-c30b5.appspot.com/o/defaultUser.jpg?alt=media&token=eec0ee83-26c6-4927-88c0-ddebc2c71fab';

// profile Screen Input fields decoration

const kTextFieldInputDecoration = InputDecoration(
  enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
  fillColor: Colors.transparent,
  hintText: "Enter Value",
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
  labelText: "Value",
  filled: true,
);

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}
//
//const Map<int, Color> color = {
//  50: Color(0xFFEAECEE),
//  100: Color(0xFFD5D8DC),
//  200: Color(0xFFABB2B9),
//  300: Color(0xFF808B96),
//  400: Color(0xFF566573),
//  500: Color(0xFF2C3E50),
//  600: Color(0xFF273746),
//  700: Color(0xFF212F3D),
//  800: Color(0xFF1C2833),
//  900: Color(0xFF17202A),
//};
//
//const MaterialColor primarySwatch = MaterialColor(0xFF17202A, color);

//const AlertDialog kAnswerAddedSuccessAlert = AlertDialog(
//  title: Text("Your Answer is added succeccfully"),
//);
