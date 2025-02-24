


import 'package:flutter/material.dart';

class MediaQueryHelper {
  final BuildContext context;

  MediaQueryHelper(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  double get statusBarHeight => MediaQuery.of(context).padding.top;
  double get bottomInset => MediaQuery.of(context).viewInsets.bottom;

  /// Returns width percentage of the screen
  double width(double percentage) => screenWidth * (percentage / 100);

  /// Returns height percentage of the screen
  double height(double percentage) => screenHeight * (percentage / 100);

  /// Returns font size relative to screen width
  double fontSize(double size) => screenWidth * (size / 100);
  EdgeInsets paddingAll(double percentage) => EdgeInsets.all(width(percentage));

  /// Returns EdgeInsets with responsive padding (symmetric)
  EdgeInsets paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(
        horizontal: width(horizontal),
        vertical: height(vertical),
      );

  /// Returns EdgeInsets with responsive padding (individual)
  EdgeInsets paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: width(left),
        top: height(top),
        right: width(right),
        bottom: height(bottom),
      );

  /// Returns EdgeInsets with responsive margin (all sides)
  EdgeInsets marginAll(double percentage) => EdgeInsets.all(width(percentage));

  /// Returns EdgeInsets with responsive margin (symmetric)
  EdgeInsets marginSymmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(
        horizontal: width(horizontal),
        vertical: height(vertical),
      );

  /// Returns EdgeInsets with responsive margin (individual)
  EdgeInsets marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: width(left),
        top: height(top),
        right: width(right),
        bottom: height(bottom),
      );
}
