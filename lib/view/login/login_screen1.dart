

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilane/res/app_style/app_style.dart';
import 'package:medilane/res/colors/app_color.dart';
import 'package:medilane/res/routes/routes_name.dart';

import '../../res/assets/image_assets.dart';
import '../../res/media-queries/media_query.dart';
import '../../res/widgets/custom_button2.dart';

class LoginScreen1 extends StatelessWidget {
  const LoginScreen1({super.key});
  

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Scaffold(
      body:Column(
        children: [
          SizedBox(height: mediaQuery.height(5),),

          Image.asset(ImageAssets.loginScreen1),

          SizedBox(height: mediaQuery.height(5),),

          Padding(
            padding: mediaQuery.paddingOnly(left: 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child:  RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "head1".tr,
                        style: AppStyle.headings2,
                      ),
                      TextSpan(
                          text: "head2".tr,
                          style: AppStyle.richHeadings2 // Change color as needed
                      ),
                    ],
                  ),

                ),
            ),
          ),

          SizedBox(height: mediaQuery.height(7),),

          CustomButton2(
            text: "loginBtn1".tr,
            onPressed: () {

        Get.toNamed(RouteName.LoginScreen2);

            },
            color: AppColor.greenMain,
            textColor: AppColor.whiteColor,
            borderRadius: 12,
            icon: Icons.email,
            isFullWidth: false,
            height: mediaQuery.height(7),
            width: mediaQuery.width(70),
          ),

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
          Spacer(),
          Padding(
            padding: mediaQuery.paddingOnly(bottom: 1),
            child: InkWell(
              onTap: (){
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
                      style: AppStyle.richText // Change color as needed
                    ),
                  ],
                ),

              ),
            ),
          ),



        ],
      ),
    );
  }
}
