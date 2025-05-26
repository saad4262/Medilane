import 'package:flutter/material.dart';
import 'package:medilane/res/colors/app_color.dart';

class FontSizes {
  static const double extraSmall = 9.0;
  static const double  small = 13.0;
  static const double medium = 15.0;
  static const double large = 18.0;
  static const double mediumHeadline = 20.0;
  static const double headline = 24.0;
  static const double title = 30.0;
  static const double display = 37.0;
}

class AppStyle {
  static TextStyle descriptions = TextStyle(
    fontSize: FontSizes.medium,
    fontFamily: 'poppins',
    // fontWeight: FontWeight.w500,
  );

  static TextStyle richDescriptions = TextStyle(
    fontSize: FontSizes.medium,
    fontFamily: 'poppins',
    // fontWeight: FontWeight.w500,
    color: AppColor.blueMain
  );

  static TextStyle btnText = TextStyle(
      fontSize: FontSizes.medium,
      fontFamily: 'poppins',
      // fontWeight: FontWeight.w500,
      color: AppColor.whiteColor
  );

  static TextStyle headings = TextStyle(
    fontSize: FontSizes.mediumHeadline,
    fontFamily: 'poppins',
    fontWeight: FontWeight.bold,
  );

  static TextStyle richHeadings = TextStyle(
    fontSize: FontSizes.mediumHeadline,
    fontFamily: 'poppins',
    fontWeight: FontWeight.bold,
    color: AppColor.blueMain
  );


  static TextStyle headings2 = TextStyle(
    fontSize: FontSizes.title,
    fontFamily: 'poppins',
    fontWeight: FontWeight.bold,
      color: AppColor.blackColor

  );

  static TextStyle richHeadings2 = TextStyle(
      fontSize: FontSizes.title,
      fontFamily: 'poppins',
      fontWeight: FontWeight.bold,
      color: AppColor.blueMain

  );

  static TextStyle richHeadings3 = TextStyle(
      fontSize: FontSizes.title,
      fontFamily: 'poppins',
      // fontWeight: FontWeight.bold,
      color: AppColor.blueMain
  );

  static TextStyle text = TextStyle(
    fontSize: FontSizes.medium,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w400,
      color: AppColor.blackColor

  );
  static TextStyle richText = TextStyle(
    fontSize: FontSizes.medium,
    fontFamily: 'poppins',
    fontWeight: FontWeight.bold,
    color: AppColor.blueMain
  );

  static TextStyle smallDescriptions = TextStyle(
      fontSize: FontSizes.small,
      fontFamily: 'poppins',
      // fontWeight: FontWeight.w400,
      color: AppColor.blackColor

  );
}
