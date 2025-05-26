import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomTextField extends StatelessWidget {
  final String hintText;
  final CustomTextFieldController controller;
  final bool isPassword;
  final Color textColor;
  final Color borderColor;
  final Color errorBorderColor;
  final TextInputType keyboardType;
  final TextEditingController? textEditingController; // ✅ Use TextEditingController


  final double width;
  final double height;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? nextFocusNode;
  final bool filled;
  final Color fillColor;
  final Color focusedBorderColor;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;




  const CustomTextField({
    super.key,

    required this.hintText,
    required this.controller,
    this.errorBorderColor = Colors.red,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.isPassword = false,
    this.textColor = Colors.black,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.transparent,
    this.onChanged,
    required this.width ,
    required this.height ,
    required this.backgroundColor ,
    this.borderRadius = 10.0,
    this.contentPadding, // Accept null value
    this.prefixIcon,
    this.suffixIcon,
    this.nextFocusNode,
    this.filled = true,
    this.fillColor = Colors.white,
    this.readOnly = false,
   this.textEditingController,

  });

  @override
  Widget build(BuildContext context) {
    double fontSize = height * 0.25; // Adjust the multiplier as needed

    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: controller.errorText.value == null ? borderColor : Colors.red,
            ),
          ),
          child: TextField(
            controller: controller.textController,
            onChanged: onChanged,
            focusNode: controller.focusNode,
            obscureText: isPassword ? controller.isObscure.value : false,
            keyboardType: keyboardType,
            onTap: onTap,
            readOnly: readOnly,
            // controller :


            decoration: InputDecoration(
              filled: filled,
              fillColor: fillColor,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: height * 0.25),
              border: InputBorder.none,
              contentPadding: contentPadding,

              // ✅ Prefix Icon
              prefixIcon: prefixIcon != null
                  ? Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.25), // Adjust icon alignment
                child: prefixIcon,
              )
                  : null,
              // ✅ Suffix Icon (Shows password toggle if `isPassword = true`)
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  controller.isObscure.value ? Icons.visibility_off : Icons.visibility,
                  color: textColor,
                ),
                onPressed: controller.toggleObscure,
              )
                  : suffixIcon,


              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: errorBorderColor, width: 2.0),
              ),
            ),
            style: TextStyle(color: textColor,fontSize: fontSize,fontFamily: "poppins"),
            textInputAction: nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
            onSubmitted: (_) {
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
          ),
        ),

        // ✅ Error message display
        if (controller.errorText.value != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: Text(
              controller.errorText.value!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    ));
  }
}




class CustomTextFieldController extends GetxController {
  var textController = TextEditingController();
  var focusNode = FocusNode();
  var isObscure = false.obs; // For password visibility
  var errorText = RxnString(); // Nullable error message
  final String fieldType;
  final FocusNode? nextFocusNode;

  CustomTextFieldController({required this.fieldType, this.nextFocusNode}) {

    textController = TextEditingController();

    // Add listener to check when focus is lost
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        validateField(); // Validate only when focus leaves
      }
    });
  }

  String get text => textController.text;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void setError(String? error) {
    errorText.value = error;
  }

  void validateField() {
    String value = textController.text.trim();

    if (fieldType == "Email") {
      if (value.isEmpty) {
        setError("Email cannot be empty");
      } else if (!GetUtils.isEmail(value)) {
        setError("Enter a valid email");
      } else {
        setError(null);
      }
    } else if (fieldType == "Password") {
      if (value.isEmpty) {
        setError("Password cannot be empty");
      } else if (value.length < 6) {
        setError("Password must be at least 6 characters");
      } else {
        setError(null);
      }
    } else if (fieldType == "ConfirmPassword") {
      String passwordValue = "";

      // String passwordValue = Get.find<CustomTextFieldController>(tag: "password").textController.text;
      try {
        passwordValue = Get.find<CustomTextFieldController>(tag: "signup_password").textController.text;
      } catch (e) {
        passwordValue = "";
      }

      if (value.isEmpty) {
        setError("Confirm Password cannot be empty");
      } else if (passwordValue.isNotEmpty && value != passwordValue) {
        setError("Passwords do not match");
      } else {
        setError(null);
      }

    } else if (fieldType == "Username") {  // ✅ Add validation for username
      if (value.isEmpty) {
        setError("Username cannot be empty");
      } else if (value.length < 3) {
        setError("Username must be at least 3 characters");
      } else {
        setError(null);
      }

    } else {
      setError(null); // No validation required for other fields
    }
  }

  void requestKeyboard() {
    Future.delayed(Duration(milliseconds: 0), () {
      focusNode.requestFocus();
    });
  }

  void clearText() {

    textController.clear();
    errorText.value = null;
  }

  @override
  void onClose() {

    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
