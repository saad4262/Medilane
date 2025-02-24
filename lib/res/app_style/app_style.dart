import 'package:flutter/material.dart';

class FontSizes {
  static const double small = 9.0;
  static const double extraSmall = 13.0;
  static const double medium = 16.0;
  static const double large = 18.0;
  static const double extraLarge = 20.0;
  static const double headline = 24.0;
  static const double title = 27.0;
  static const double display = 37.0;
}

class AppStyle {
  static TextStyle descriptions = TextStyle(
    fontSize: FontSizes.medium,
    fontFamily: 'poppins',
    // fontWeight: FontWeight.w500,
  );

  static TextStyle headings = TextStyle(
    fontSize: FontSizes.headline,
    fontFamily: 'poppins',
    fontWeight: FontWeight.bold,
  );

  static TextStyle txtFootnote = TextStyle(
    fontSize: FontSizes.extraSmall,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtHeadline = TextStyle(
    fontSize: FontSizes.large,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w700,
  );

  static TextStyle txtSFProDisplaySemibold21 = TextStyle(
    fontSize: FontSizes.headline,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w600,
  );

  static TextStyle txtSFUITextSemibold27 = TextStyle(
    fontSize: FontSizes.title,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w600,
  );

  static TextStyle txtBerkshireSwashRegular37 = TextStyle(
    fontSize: FontSizes.display,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w400,
  );
}
