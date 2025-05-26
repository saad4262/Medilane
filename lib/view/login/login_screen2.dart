


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilane/res/assets/image_assets.dart';
import 'package:medilane/res/colors/app_color.dart';

import '../../res/app_style/app_style.dart';
import '../../res/media-queries/media_query.dart';
import '../../res/routes/routes_name.dart';
import '../../res/widgets/custom_button.dart';
import '../../res/widgets/custom_shimmer.dart';
import '../../res/widgets/custom_textField.dart';
import '../../view_models/auth_vm/auth_vm.dart';

class LoginScreen2 extends StatelessWidget {
   LoginScreen2({super.key});
   final emailController = Get.put(CustomTextFieldController(fieldType: "Email"), tag: "email2");
   final passwordController = Get.put(CustomTextFieldController(fieldType: "Password"), tag: "password2");
   final authController = Get.put(AuthController());
   final buttonController = Get.put(ButtonController());

  final FocusNode passwordFocus = FocusNode(); // Next field focus

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
                children: [
                  Image.asset(
                    ImageAssets.loginScreen2,
                    height:mediaQuery.height(30),
                    width: double.infinity,
                  ),
                  Positioned(child: Padding(
                    padding: mediaQuery.paddingOnly(left: 6,top: 5),
                    child: InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xFFF5F4F8),
                          child: Icon(Icons.arrow_back_ios_new)),
                    ),
                  ),)
                ]
            ),
            SizedBox(height: mediaQuery.height(2),),
        
            Padding(
              padding: mediaQuery.paddingOnly(left: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child:  RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Let's".tr,
                        style: AppStyle.headings2,
                      ),
                      TextSpan(
                          text: " Sign In".tr,
                          style: AppStyle.richHeadings2 // Change color as needed
                      ),
                    ],
                  ),
        
                ),
              ),
            ),
        
            SizedBox(height: mediaQuery.height(3),),

            CustomTextField(
              prefixIcon: Icon(Icons.email,color: AppColor.blueMain,),
        
              hintText: "email".tr,
              controller: emailController,
              nextFocusNode: passwordFocus,
              fillColor: Color(0xFFE8E8E8),
              filled: true,
              borderRadius: 10,
              borderColor: Colors.transparent,
        
              backgroundColor: Color(0xFFE8E8E8),
              height: mediaQuery.height(7.5),
              width: mediaQuery.width(80),
        
        
        
        
            ),
        
        
            SizedBox(height: mediaQuery.height(4),),



            CustomTextField(
              prefixIcon: Icon(Icons.lock,color: AppColor.blueMain,),
              hintText: "password".tr,
              controller: passwordController,
              nextFocusNode: FocusNode(), // Last field, no next focus
              isPassword: true,
              fillColor: Color(0xFFE8E8E8),
              filled: true,
              borderRadius: 10,
              borderColor: Colors.transparent,
              height: mediaQuery.height(7.5),
              backgroundColor: Color(0xFFE8E8E8),
              width: mediaQuery.width(80),
        
        
            ),
        
            SizedBox(height: mediaQuery.height(1),),
        
        
        
                Padding(
                  padding: mediaQuery.paddingOnly(right: 12,top: 2),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("Forgot password?".tr , style: AppStyle.richDescriptions ,)),
                ),
            SizedBox(height: mediaQuery.height(2),),


      Obx(() =>  CustomButton(
              text: "Login".tr,

      onPressed: () async {
        authController.isLoading.value = true;


        // Get.to(() => CustomShimmerScreen());


        bool isSuccess = await authController.login(
            emailController.text, passwordController.text); // ✅ Await the login result

        authController.isLoading.value = false;


        if (isSuccess) {
          Get.offNamed(RouteName.HomeScreen);
        } else {
          Get.back();

          Get.snackbar("Error", "Invalid login credentials"); // ✅ Show error message
        }
        // authController.login( emailController.text, passwordController.text);
        // Get.toNamed(RouteName.HomeScreen);
      },
              isLoading: authController.isLoading.value,
              color: AppColor.greenMain,
              textColor: AppColor.whiteColor,
              borderRadius: 12,
              isFullWidth: false,
              height: mediaQuery.height(7),
              width: mediaQuery.width(70),
            )),
        
        
        
            SizedBox(height: mediaQuery.height(3.5),),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  // Center Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Or'.tr,
                      style: TextStyle(fontSize: 16, color: Color(0xFF4A4A4A)),
                    ),
                  ),
                  // Right Divider
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      // AuthService().signInWithGoogle();
                    },
                    child: Container(
                      // color: Colors.grey,
        
                      height: mediaQuery.height(9),
                      width: mediaQuery.width(30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFE8E8E8)
        
                      ),
                      child: Image.asset(
        
                          ImageAssets.googleImage
                      ),
                    ),
                  ),
        
                  Container(
                      height: mediaQuery.height(9),
                      width: mediaQuery.width(30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFE8E8E8)
        
                      ),
                      child: Image.asset(
                          ImageAssets.fbImage
                      )
                  )
                ],
              ),
            ),
            SizedBox(height: mediaQuery.height(3)),
            Padding(
              padding: mediaQuery.paddingOnly(bottom: 5),
        
        
                child: InkWell(
                  onTap:() {
                    Get.toNamed(RouteName.SignupScreen1);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "footer1".tr,
                          style: AppStyle.text,
                        ),
        
                        TextSpan(
                            text: "footer2".tr,
                            style: AppStyle.richText,
        
                        ),
                      ],
                    ),
        
                  ),
                ),
              ),
        
        
          ],
        ),
      ),

    );
  }
}
