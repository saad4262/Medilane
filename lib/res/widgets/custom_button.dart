import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilane/res/colors/app_color.dart';
import '../media-queries/media_query.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final IconData? icon;
  final bool isFullWidth;
  final bool isDisabled;
  final double? width;
  final double? height;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
    this.icon,
    this.isFullWidth = false,
    this.isDisabled = false,
    this.width,
    this.height,

  });

  final ButtonController buttonController = Get.put(ButtonController()); // ✅ Initialize controller

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Obx(() => Container(
      width: isFullWidth ? double.infinity : width ?? 200, // Default width: 200
      height: height ?? 50, // Default height: 50
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
          disabledBackgroundColor: color, // ✅ Prevents color from changing to grey when disabled
        ),

        onPressed: isDisabled || buttonController.isLoading.value
            ? null
            : () async {
          buttonController.startLoading();
          await Future.delayed(Duration(seconds: 2));
          buttonController.stopLoading();
          onPressed();

        },
        child: buttonController.isLoading.value
            ? SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: textColor,
            strokeWidth: 3,
          ),
        )
            : Row(
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
    ));
  }
}


class ButtonController extends GetxController {
  var isLoading = false.obs;

  void startLoading() {
    isLoading.value = true;
  }

  void stopLoading() {
    isLoading.value = false;
  }
}