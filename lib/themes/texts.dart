import 'package:flutter/material.dart';
import 'package:myfarm/themes/colors.dart';

class AppText {
  AppText._();
  static const appbarText = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  static const blacknormalText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const blacksmallText = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  static const greysmallText = TextStyle(
    color: Color.fromARGB(255, 93, 93, 93),
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  static const blackbigText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const orangeXLText = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: AppColor.primaryColor,
  );

  static const whiteSmallItalicText = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontStyle: FontStyle.italic,
  );
  static const blackSmallItalicText = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );

  static const whitenormalbuttonText = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  static const labelText = TextStyle(
    color: AppColor.primaryColor,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static const textfieldText = TextStyle(
    color: AppColor.primaryColor,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
}
