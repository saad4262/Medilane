import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CustomTextField2 extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;

  final TextEditingController controller;
  final TextInputType keyboardType;
  final double width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final Color fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  const CustomTextField2({
    super.key,
    required this.hintText,
     this.hintStyle,
    required this.controller,
    required this.width,
    required this.height,
    this.keyboardType = TextInputType.text,
    this.borderRadius = 10,
    this.borderColor = Colors.grey,
    this.fillColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,

        decoration: InputDecoration(
          hintStyle:hintStyle,
          hintText: hintText,
          filled: true,
          fillColor: fillColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(fontSize: height * 0.3),
      ),
    );
  }
}

class TextFieldFocusController extends GetxController {
  late FocusNode focusNode;
  RxBool isFocused = false.obs;

  @override
  void onInit() {
    super.onInit();
    focusNode = FocusNode();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });

    // ever(isFocused, (bool focused) {
    //   if (focused) {
    //     focusNode.requestFocus();
    //   } else {
    //     focusNode.unfocus();
    //   }
    // });

    // Remove auto-focus on init
    // isFocused.value = true;  <-- NO auto-focus here
  }

  void unfocus() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }

  // Call this method ONLY when you want to open keyboard (focus)
  void requestFocus() {
    focusNode.requestFocus();
  }

  // void unfocus() {
  //   focusNode.unfocus();
  // }
}
