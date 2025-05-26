import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilane/res/assets/image_assets.dart';
import 'package:medilane/res/colors/app_color.dart';

import '../../res/app_style/app_style.dart';
import '../../res/media-queries/media_query.dart';
import '../../res/routes/routes_name.dart';
import '../../res/widgets/custom_button.dart';
import '../../res/widgets/custom_textField.dart';
import '../../view_models/auth_vm/auth_vm.dart';

class SignupScreen1 extends StatelessWidget {
  SignupScreen1({super.key});
  final emailController2 =
      Get.put(CustomTextFieldController(fieldType: "Email"), tag: "email");
  final passwordController2 = Get.put(
      CustomTextFieldController(fieldType: "Password"),
      tag: "signup_password");
  final userNameController2 = Get.put(
      CustomTextFieldController(fieldType: "Username"),
      tag: "username");
  final confirmPasswordController2 = Get.put(
      CustomTextFieldController(fieldType: "ConfirmPassword"),
      tag: "signup_confirm_password");

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Image.asset(
                ImageAssets.SignupScreen1,
                height: mediaQuery.height(30),
                width: double.infinity,
              ),
              Positioned(
                child: Padding(
                  padding: mediaQuery.paddingOnly(left: 6, top: 5),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFF5F4F8),
                        child: Icon(Icons.arrow_back_ios_new)),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: mediaQuery.height(2),
            ),
            Padding(
              padding: mediaQuery.paddingOnly(left: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Create your".tr,
                        style: AppStyle.headings2,
                      ),
                      TextSpan(
                          text: "account".tr,
                          style:
                              AppStyle.richHeadings2 // Change color as needed
                          ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height(3),
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.person,
                color: AppColor.blueMain,
              ),
              hintText: "Username".tr,
              controller: userNameController2,
              nextFocusNode: emailFocus,
              fillColor: Color(0xFFE8E8E8),
              filled: true,
              borderRadius: 10,
              borderColor: Colors.transparent,
              backgroundColor: Color(0xFFE8E8E8),
              height: mediaQuery.height(7.5),
              width: mediaQuery.width(80),
            ),
            SizedBox(
              height: mediaQuery.height(3.5),
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.email,
                color: AppColor.blueMain,
              ),
              hintText: "email".tr,
              controller: emailController2,
              nextFocusNode: passwordFocus,
              fillColor: Color(0xFFE8E8E8),
              filled: true,
              borderRadius: 10,
              borderColor: Colors.transparent,
              backgroundColor: Color(0xFFE8E8E8),
              height: mediaQuery.height(7.5),
              width: mediaQuery.width(80),
            ),
            SizedBox(
              height: mediaQuery.height(3.5),
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.lock,
                color: AppColor.blueMain,
              ),
              hintText: "password".tr,
              controller: passwordController2,
              nextFocusNode: confirmPasswordFocus, // Last field, no next focus
              isPassword: true,
              fillColor: Color(0xFFE8E8E8),
              filled: true,
              borderRadius: 10,
              borderColor: Colors.transparent,
              height: mediaQuery.height(7.5),
              backgroundColor: Color(0xFFE8E8E8),
              width: mediaQuery.width(80),
            ),
            SizedBox(
              height: mediaQuery.height(3.5),
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.lock,
                color: AppColor.blueMain,
              ),
              hintText: "confirm password".tr,
              controller: confirmPasswordController2,
              nextFocusNode: null, // Last field, no next focus
              isPassword: true,
              fillColor: Color(0xFFE8E8E8),
              filled: true,
              borderRadius: 10,

              borderColor: Colors.transparent,
              height: mediaQuery.height(7.5),
              backgroundColor: Color(0xFFE8E8E8),
              width: mediaQuery.width(80),
            ),
            SizedBox(
              height: mediaQuery.height(1),
            ),
            Padding(
              padding: mediaQuery.paddingOnly(right: 12, top: 2),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Terms of service".tr,
                    style: AppStyle.richDescriptions,
                  )),
            ),
            SizedBox(
              height: mediaQuery.height(2),
            ),
            Obx(() => CustomButton(
                  text: "Register".tr,
                  onPressed: () {
                    authController.signUp(
                        userNameController2.text,
                        emailController2.text,
                        passwordController2.text,
                        confirmPasswordController2.text);

                    Get.toNamed(RouteName.MapScreen);
                  },
                  isLoading: authController.isLoading.value,
                  color: AppColor.greenMain,
                  textColor: AppColor.whiteColor,
                  borderRadius: 12,
                  isFullWidth: false,
                  height: mediaQuery.height(7),
                  width: mediaQuery.width(70),
                )),
            SizedBox(
              height: mediaQuery.height(3.5),
            ),
          ],
        ),
      ),
    );
  }
}
