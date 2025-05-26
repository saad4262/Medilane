import 'package:adminpanel1medilane/res/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medilane/view/home/home_screen.dart';

import '../../view/Lab/lab_home.dart';
import '../../view/about.dart';
import '../../view/ai_doctor_screen.dart';
import '../../view/order_history.dart';
import '../../view/settings_screen.dart';
import '../../view/update_profile.dart';
import '../../view_models/auth_vm/auth_vm.dart';
import '../colors/app_color.dart';

class CustomDrawer extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Drawer(



      child: Column(
        children: [

          Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(color: AppColor.blueMain),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Hero(
                      tag: 'profile-avatar', // Hero tag for the avatar
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: authController.profileImage.value.isNotEmpty
                            ? NetworkImage(authController.profileImage.value)
                            : const AssetImage("assets/images/person1.png"),
                        child: authController.profileImage.value.isEmpty
                            ? const Icon(Icons.person, size: 30)
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        authController.user.value?.username ?? "",
                        style: AppStyle.headings,
                      ),
                    ),
                  );
                }),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        authController.user.value?.email ?? "",
                        style: AppStyle.descriptions,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          ListTile(
            leading: Icon(FontAwesomeIcons.home),
            title: Text("Home",style: AppStyle.descriptions),
            onTap: () {
              Get.to(HomeScreen());
            },
          ),

          ListTile(
            leading: Icon(FontAwesomeIcons.microscope),
            title: Text("Medical Labs",style: AppStyle.descriptions),
            onTap: () {
              Get.to(LabHome());
            },
          ),

          ListTile(
            leading: Icon(FontAwesomeIcons.robot),
            title: Text("AI Doctor",style: AppStyle.descriptions),
            onTap: () {
              Get.to(ChatScreen());
            },
          ),

          ListTile(
            leading: Icon(FontAwesomeIcons.history),
            title: Text("Order History",style: AppStyle.descriptions),
            onTap: () {

              Get.to(OrderHistoryScreen());

            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile",style: AppStyle.descriptions),
            onTap: () {

            Get.to(UpdateProfileView());

            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.exclamation),
            title: Text("About",style: AppStyle.descriptions),
            onTap: () {
              Get.to(AboutScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings",style: AppStyle.descriptions),
            onTap: () {

              Get.to(SettingsScreen());

             },
          ),



          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout",style: AppStyle.descriptions,),
            onTap: () {

              authController.logout();

            },

          ),
          // Other ListTile items in the Drawer
        ],
      ),
    );
  }
}


class DrawerControllerX extends GetxController {
  RxBool isDrawerOpen = false.obs;

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  void closeDrawer() {
    isDrawerOpen.value = false;
  }

  void openDrawer() {
    isDrawerOpen.value = true;
  }
}


