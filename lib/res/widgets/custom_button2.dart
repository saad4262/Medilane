import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilane/res/colors/app_color.dart';
import '../media-queries/media_query.dart';

class CustomButton2 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final IconData? icon;
  final bool isFullWidth;
  final bool isDisabled;
  final double? width;
  final double? height;

  CustomButton2({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
    this.icon,
    this.isFullWidth = false,
    this.isDisabled = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Container(
      width: isFullWidth ? double.infinity : width ?? 200, // Default width: 200
      height: height ?? 50, // Default height: 50
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
          disabledBackgroundColor: color, // Prevents color change when disabled
        ),
        onPressed: isDisabled ? null : onPressed, // No loading logic, directly executes `onPressed`
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 20),
              SizedBox(width: mediaQuery.width(.8)),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: mediaQuery.fontSize(4.5),
                fontWeight: FontWeight.w600,
                fontFamily: "poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
