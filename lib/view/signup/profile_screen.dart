import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medilane/res/colors/app_color.dart';
import 'package:medilane/res/routes/routes_name.dart';
import 'package:medilane/res/widgets/custom_button.dart';

import '../../res/app_style/app_style.dart';
import '../../res/media-queries/media_query.dart';
import '../../res/widgets/custom_backArrow.dart';
import '../../res/widgets/custom_button2.dart';
import '../../res/widgets/custom_textField.dart';
import '../../view_models/auth_vm/auth_vm.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(AuthController());

  final phoneNumberController = Get.put(
      CustomTextFieldController(fieldType: "PhoneNumber"),
      tag: "PhoneNumber");
  final TextEditingController dateController = TextEditingController();

  Widget _customRadioButton(


      String text, String groupValue, AuthController controller,  BuildContext context, // ✅ Pass context as a parameter
      )
  {
    final mediaQuery = MediaQueryHelper(context);

    return GestureDetector(

      onTap: () => controller.setGender(text),
      child: Row(
        children: [
          Container(
            width:  mediaQuery.width(6),
            height:  mediaQuery.height(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: groupValue == text ? AppColor.greenMain : Colors.grey,
                width: mediaQuery.width(1),
              ),
            ),
            child: groupValue == text
                ? Center(
              child: Container(
                width:  mediaQuery.width(6),
                height:  mediaQuery.height(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.greenMain,
                ),
              ),
            )
                : null,
          ),
          SizedBox(width: mediaQuery.width(6)),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: groupValue == text ? AppColor.blueMain : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Scaffold(
      body: Padding(
        padding: mediaQuery.paddingOnly(top: 6, left: 3, right: 3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBackButton(),
                SizedBox(width: mediaQuery.width(20)),
                CustomButton2(
                  text: "Skip".tr,
                  onPressed: () {},
                  color: Color(0xFFF5F4F8),
                  textColor: AppColor.blueMain,
                  borderRadius: 30,
                  width: mediaQuery.width(30),
                  height: mediaQuery.height(5),
                ),
              ],
            ),

            SizedBox(
              height: mediaQuery.height(6),
            ),

            Padding(
              padding: mediaQuery.paddingOnly(left: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Fill your".tr,
                        style: AppStyle.headings2,
                      ),
                      TextSpan(
                          text: " information".tr,
                          style:
                          AppStyle.richHeadings2 // Change color as needed
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: mediaQuery.paddingOnly(left: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("below".tr,
                    style: AppStyle.richHeadings2 // Change color as needed
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height(2),
            ),

            Padding(
              padding: mediaQuery.paddingOnly(left: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("You can edit this later on your account setting.".tr,
                    style: AppStyle.smallDescriptions // Change color as needed
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height(5),
            ),

            GestureDetector(
              onTap: () {
                controller.pickImage(); // Call image picker function
              },
              child: Obx(() => Stack(children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: controller.selectedImage.value != null
                      ? FileImage(controller.selectedImage.value!)
                  as ImageProvider
                      : (controller.profileImage.value.isNotEmpty
                      ? NetworkImage(controller.profileImage.value)
                      : AssetImage("assets/images/person1.png")
                  as ImageProvider),
                ),
                Positioned(
                    bottom: 2,
                    right: 4,
                    child: CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColor.blueMain,
                        child: Icon(
                          Icons.edit,
                          color: AppColor.whiteColor,
                          size: 18,
                        )))
              ])),
            ),
            SizedBox(
              height: mediaQuery.height(5),
            ),

            // 📌 Phone Number
            // TextField(
            //   decoration: InputDecoration(labelText: "Phone Number"),
            //   onChanged: (value) => controller.user.value!.phone = value,
            // ),
            // SizedBox(height: 20),

            CustomTextField(
              prefixIcon: Icon(
                Icons.phone,
                color: AppColor.blueMain,
              ),
              hintText: "Phone number".tr,
              controller: phoneNumberController,
              nextFocusNode: FocusNode(),
              fillColor: Color(0xFFE8E8E8),
              onChanged: (value) => controller.user.value!.phone = value,
              keyboardType: TextInputType.number,
              filled: true,
              borderRadius: 10,
              borderColor: Colors.transparent,
              height: mediaQuery.height(7.5),
              backgroundColor: Color(0xFFE8E8E8),
              width: mediaQuery.width(80),
            ),

            SizedBox(
              height: mediaQuery.height(3),
            ),

            // 📌 Date of Birth Picker
            Obx(
                  () => Padding(
                padding: mediaQuery.paddingOnly(left: 7, right: 7),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),

                    hintText: "Date of Birth".tr,
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: AppColor.blueMain,
                    ),
                    // color: Color(0xFFE8E8E8),
                    // borderRadius: BorderRadius.circular(10),
                    filled: true,
                    fillColor: Color(0xFFE8E8E8),
                    // labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                      BorderSide(color: Color(0xFFE8E8E8), width: mediaQuery.width(2)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                      BorderSide(color: Color(0xFF1F4C6B), width: mediaQuery.width(2)),
                    ),
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                      text: controller.selectedDate.value),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      controller
                          .selectDate(DateFormat('yyyy-MM-dd').format(picked));
                    }
                  },
                ),
              ),
            ),

            SizedBox(
              height: mediaQuery.height(5),
            ),

            // 📌 Gender Selection (Radio Buttons)
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _customRadioButton(
                    "Male".tr, controller.selectedGender.value, controller,context),
                SizedBox(width: mediaQuery.width(20)),
                _customRadioButton(
                    "Female".tr, controller.selectedGender.value, controller,context),
              ],
            )),

            SizedBox(height: 30),

            // 📌 Save Button
            // ElevatedButton(
            //   onPressed: () => controller.updateProfile(
            //     controller.user.value!.uid,
            //     controller.user.value!.phone,
            //     controller.selectedDate.value,
            //     controller.selectedGender.value,
            //   ),
            //   child: Text("Save"),
            // ),

            Obx(() => CustomButton(
              text: "Finish".tr,
              onPressed: () {
                //
                // controller.updateProfile(
                //   controller.user.value!.uid,
                //   controller.user.value!.phone,
                //   controller.selectedDate.value,
                //   controller.selectedGender.value,

                if (controller.user.value == null ||
                    controller.user.value!.uid.isEmpty ||
                    controller.user.value!.phone.isEmpty ||
                    controller.selectedDate.value == null ||
                    controller.selectedGender.value.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Please fill in all fields before proceeding.",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  controller.updateProfile(
                      controller.user.value!.uid,
                      controller.user.value!.phone,
                      controller.user.value!.email,
                      controller.user.value!.username,
                      controller.selectedDate.value,
                      controller.selectedGender.value,

                      showSuccessBottomSheet(context)

                  );

                }


              },
              isLoading: controller.isLoading.value,
              color: AppColor.greenMain,
              textColor: AppColor.whiteColor,
              borderRadius: 12,
              isFullWidth: false,
              height: mediaQuery.height(7),
              width: mediaQuery.width(70),
            )),
          ],
        ),
      ),
    );
  }
}




void showSuccessBottomSheet(BuildContext context) {
  final mediaQuery = MediaQueryHelper(context);

  showModalBottomSheet(
    context: context,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        height: mediaQuery.height(45),
        padding: mediaQuery.paddingOnly( left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Stack(
              children: [
                Image.asset("assets/images/shape2.png") ,
                Positioned(
                  top: 30,
                  left: 30,
                  child:
                  Image.asset("assets/images/shape1.png") ,

                ),

              ],
            ),
            RichText(
              textAlign: TextAlign.center,

              text: TextSpan(

                children: [
                  TextSpan(
                    text: "Account  ",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text: "successfully created!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF204D6C)),
                  ),
                ],
              ),
            ),
            SizedBox(height:mediaQuery.height(5)),

            CustomButton2(
              text: "Done",
              color: Color(0xFF8BC83F),
              textColor: Colors.white,
              borderRadius: 10,
              height: mediaQuery.height(5),
              width:mediaQuery.width(50),
              onPressed: () {
                Get.toNamed(RouteName.HomeScreen);
              },

            ),
          ],
        ),
      );
    },
  );
}