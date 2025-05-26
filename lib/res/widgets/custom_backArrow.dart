import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilane/res/colors/app_color.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;
  final double radius;
  final double iconSize;

  const CustomBackButton({
    super.key,
    this.onTap,
    this.backgroundColor = const Color(0xFFF5F4F8),
    this.iconColor = AppColor.blueMain,
    this.radius = 25,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 5),
      child: Material(
        color: Colors.transparent, // Ensures ripple effect visibility
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap ?? () => Get.back(), // Default behavior is to navigate back
          child: CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor,
            child: Icon(Icons.arrow_back_ios_new, color: iconColor, size: iconSize),
          ),
        ),
      ),
    );
  }
}
