import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilane/res/assets/image_assets.dart';
import 'package:medilane/res/colors/app_color.dart';

// import 'package:medilane/view/login/widgets/input_email_widget.dart';
// import 'package:medilane/view/login/widgets/input_password_widget.dart';
// import 'package:medilane/view/login/widgets/login_button_widget.dart';

import '../../data/response/status.dart';
import '../../res/app_style/app_style.dart';
import '../../res/media-queries/media_query.dart';
import '../../view_models/controller/OnboardingScreen_vm/onboardingScreen_vm.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());




  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/img1.png",
      "title": "IntroHeading1",
      "description": "desc1",
    },
    {
      "image": "assets/images/img2.png",
      "title": "IntroHeading2",
      "description": "desc2",
    },
    {
      "image": "assets/images/img3.png",
      "title": "IntroHeading3",
      "description": "desc3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Scaffold(
      body: Column(
        children: [

          SizedBox(height: mediaQuery.height(10),),
          // Row(
          //   children: [
              // InkWell(
              //     onTap: () { Get.updateLocale(Locale("en","US"));},
              //
              //     child: Text("eng")),
              Padding(
                padding: mediaQuery.paddingOnly(right: 5),
                child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        // onTap:() { Get.updateLocale(Locale("ur","PK"));},
                        child: Text("Skip", style: TextStyle(color: AppColor.greyColor,fontSize: mediaQuery.fontSize(5)),))),
              ),
          //   ],
          // ),
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: pages.length,
              onPageChanged: controller.updatePage,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(pages[index]["image"]!, height: mediaQuery.height(35)),
                    SizedBox(height: mediaQuery.height(10)),
                    Container(
                      height: mediaQuery.height(34),
                      width :mediaQuery.width(90),
                      child: Card(
                        color: Color(0xffF5F7FF),
                        elevation: 4, // Shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: mediaQuery.height(4),),
                              Text(
                                pages[index]["title"]!.tr,
                                style: AppStyle.headings,
                              ),
                              SizedBox(height: mediaQuery.height(2)),
                              Padding(
                                padding: mediaQuery.paddingSymmetric(horizontal: 2 ),
                                child: Text(
                                  pages[index]["description"]!.tr,
                                  textAlign: TextAlign.center,
                                  style: AppStyle.descriptions,
                                ),
                              ),
                              SizedBox(height: mediaQuery.height(8)),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      pages.length,
                                          (index) => Container(
                                        margin: mediaQuery.marginSymmetric(horizontal: .5),
                                        width: controller.currentPage.value == index ? mediaQuery.width(6) : mediaQuery.width(3.5),
                                        height: mediaQuery.height(1.15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: controller.currentPage.value == index
                                              ? AppColor.blueMain
                                              : AppColor.greyColor,
                                        ),
                                      ),
                                    ),
                                  )),

                                  Obx(() => controller.currentPage.value == pages.length - 1
                                      ? CircleAvatar(

                                    child: Icon(Icons.arrow_forward,color: AppColor.whiteColor,),
                                    backgroundColor: AppColor.greenMain,
                                  )
                                      : InkWell(
                                  onTap : controller.nextPage,
                child: CircleAvatar(
                  radius: 25,
                child: Icon(Icons.arrow_forward,color: AppColor.whiteColor,),
                backgroundColor: AppColor.greenMain,
                                                                          // SizedBox(height: 30),

                )))],
                              ),
                              ],
                          ),

                        ),
                      ),
                    ),


                  ],
                );
              },
            ),
          ),



        ],
      ),
    );
  }
}