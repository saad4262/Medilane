import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


import '../res/app_style/app_style.dart';
import '../res/colors/app_color.dart';
import '../res/media-queries/media_query.dart';
import '../res/widgets/custom_button.dart';
import '../res/widgets/custom_drawer.dart';
import '../res/widgets/customteextfield2.dart';
import '../view_models/auth_vm/auth_vm.dart';

class ProfileViewModel extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  // Text controllers for fields
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final RxString selectedGender = "Male".obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();





  @override
  void onInit() {
    super.onInit();
    final user = _authController.user.value;
    if (user != null) {
      nameController.text = user.username ?? "";
      emailController.text = user.email ?? "";
      phoneController.text = user.phone ?? "";
      selectedGender.value = _authController.selectedGender.value;
    }
  }

  void updateGender(String gender) {
    selectedGender.value = gender;
    _authController.setGender(gender);
  }

  void updateDOB(String dob) {
    dobController.text = dob;
    _authController.selectDate(dob);
  }

  Future<void> updateProfileData() async {
    final uid = _authController.user.value?.uid ?? '';
    final username = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final dob = dobController.text.trim();
    final gender = selectedGender.value;

    await _authController.updateProfile(
        uid, username, email, phone, dob ,gender,() {
      Get.snackbar("Success", "Profile updated successfully!",
          backgroundColor: Colors.green);
    }
    );
  }

  Future<void> pickImage() async {
    await _authController.pickImage();
  }

  String get profileImageUrl => _authController.profileImage.value;
}




class UpdateProfileView extends StatelessWidget {
  final ProfileViewModel viewModel = Get.put(ProfileViewModel());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextFieldFocusController searchController2 = Get.put(TextFieldFocusController());
  final controller = Get.put(AuthController());
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return GestureDetector(
      onTap: () {
        // searchController2.unfocus(); // calls focusNode.unfocus()
        phoneFocusNode.unfocus();
        nameFocusNode.unfocus();
        emailFocusNode.unfocus();
        dobFocusNode.unfocus();
        FocusScope.of(context).unfocus(); // closes keyboard smoothly
      },

      child: Scaffold(
        key: _scaffoldKey,
      
        drawer: CustomDrawer(), // Attach the custom drawer
      
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: mediaQuery.paddingOnly(left: 8, top: 6,right: 2),
                    child: Align(
                      alignment: Alignment.topLeft,
                
                      child: InkWell(
                          onTap: (){
                            _scaffoldKey.currentState?.openDrawer(); // ✅ Open the drawer using the key
                
                          },
                
                          child: Image.asset('assets/images/menu.png', width: 20,color: Color(0xff757474),)),
                
                
                    ),
                  ),
                  SizedBox(width: mediaQuery.width(20)),
                  Padding(
                    padding: mediaQuery.paddingOnly(right: 4, top: 6),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff757474),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
                
              SizedBox(height: mediaQuery.height(5)),
                
              Obx(() {
                if (viewModel._authController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.pickImage(),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: viewModel.profileImageUrl.isNotEmpty
                              ? NetworkImage(viewModel.profileImageUrl)
                              : AssetImage("assets/images/user.png") as ImageProvider,
                        ),
                      ),
                      SizedBox(height:mediaQuery.height(6)),
                      // TextField(
                      //   controller: viewModel.phoneController,
                      //   decoration: InputDecoration(labelText: "Phone Number"),
                      //   keyboardType: TextInputType.phone,
                      // ),
                      Container(
                       width:mediaQuery.width(85),
                        child: CustomTextField2(
                          focusNode:phoneFocusNode,

                          // onChanged: (value) {
                          //   controller.updateSearchQuery(value.trim());
                          // },

                          hintText: "Phone Number",
                            controller: viewModel.phoneController,
                          width: mediaQuery.width(9),
                          height: mediaQuery.height(7),
                          fillColor: Colors.grey.shade100,
                          borderColor: Color(0xffDDDDE4),
                          prefixIcon: Icon(FontAwesomeIcons.phone, size: 18),
                          keyboardType: TextInputType.phone,
                          // focusNode: searchController2.focusNode,
          
          
          
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width:mediaQuery.width(85),
                        child: CustomTextField2(
          
                          // onChanged: (value) {
                          //   controller.updateSearchQuery(value.trim());
                          // },
                          focusNode: nameFocusNode,

                          hintText: "Username",
                          controller: viewModel.nameController,
                          width: mediaQuery.width(9),
                          height: mediaQuery.height(7),
                          fillColor: Colors.grey.shade100,
                          borderColor: Color(0xffDDDDE4),
                          prefixIcon: Icon(FontAwesomeIcons.user, size: 18),
                          // focusNode: searchController2.focusNode,
          
          
          
                        ),
                      ),
          
                      SizedBox(height: 16),
                      // TextField(
                      //   controller: viewModel.emailController,
                      //   decoration: InputDecoration(labelText: "Email"),
                      //   keyboardType: TextInputType.emailAddress,
                      // ),
                      Container(
                        width:mediaQuery.width(85),
                        child: CustomTextField2(
                          focusNode: emailFocusNode,


                          // onChanged: (value) {
                          //   controller.updateSearchQuery(value.trim());
                          // },

                          hintText: "Email",
                          controller: viewModel.emailController,
                          width: mediaQuery.width(9),
                          height: mediaQuery.height(7),
                          fillColor: Colors.grey.shade100,
                          borderColor: Color(0xffDDDDE4),
                          prefixIcon: Icon(Icons.email),
                            keyboardType: TextInputType.emailAddress,

                          // focusNode: searchController2.focusNode,



                        ),
                      ),
          
                      SizedBox(height: 16),
                
                      // TextField(
                      //   controller: viewModel.dobController,
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //     labelText: "Date of Birth",
                      //     suffixIcon: Icon(Icons.calendar_today),
                      //   ),
                      //   onTap: () async {
                      //     DateTime? pickedDate = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime(1900),
                      //       lastDate: DateTime.now(),
                      //     );
                      //     if (pickedDate != null) {
                      //       String formattedDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      //       viewModel.updateDOB(formattedDate);
                      //     }
                      //   },
                      // ),


                      Container(
                        width:mediaQuery.width(85),
                        child: CustomTextField2(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              String formattedDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                              viewModel.updateDOB(formattedDate);
                            }
                          },
          
                          // onChanged: (value) {
                          //   controller.updateSearchQuery(value.trim());
                          // },
                          readOnly: true, // <- prevent keyboard

                          hintText: "Date of Birth",
                          controller: viewModel.dobController,
                          width: mediaQuery.width(9),
                          height: mediaQuery.height(7),
                          fillColor: Colors.grey.shade100,
                          borderColor: Color(0xffDDDDE4),
                          prefixIcon: Icon(Icons.calendar_today),
                          // focusNode: searchController2.focusNode,
          
          
          
                        ),
                      ),
          
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   "Gender:",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w600,
                          //     color: Colors.black87,
                          //   ),
                          // ),
                          // SizedBox(width: 16),

                          _genderOption("Male", viewModel.selectedGender.value, (val) {
                            viewModel.updateGender(val); // ← onChanged logic
                          }),

                          SizedBox(width: 12),

                          _genderOption("Female", viewModel.selectedGender.value, (val) {
                            viewModel.updateGender(val); // ← onChanged logic
                          }),
                        ],
                      ),

                      // Row(
                      //   children: [
                      //     Text("Gender: "),
                      //     Radio(
                      //       value: "Male",
                      //       groupValue: viewModel.selectedGender.value,
                      //       onChanged: (value) => viewModel.updateGender(value!),
                      //     ),
                      //     Text("Male"),
                      //     Radio(
                      //       value: "Female",
                      //       groupValue: viewModel.selectedGender.value,
                      //       onChanged: (value) => viewModel.updateGender(value!),
                      //     ),
                      //     Text("Female"),
                      //   ],
                      // ),
                      SizedBox(height: 20),
                      Obx(() =>  CustomButton(
                        text: "Update",

                        onPressed: () => viewModel.updateProfileData(),
                        isLoading: controller.isLoading.value,
                        color: AppColor.greenMain,
                        textColor: AppColor.whiteColor,
                        borderRadius: 12,
                        isFullWidth: false,
                        height: mediaQuery.height(7),
                        width: mediaQuery.width(70),
                      )),
                      // ElevatedButton(
                      //   onPressed: () => viewModel.updateProfileData(),
                      //   child: Text("Update"),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppColor.primaryColor,
                      //     foregroundColor: Colors.white,
                      //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      //   ),
                      // ),
                    ],
                  ),
                );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _genderOption(
    String label,
    String selected,
    Function(String) onChanged,
    ) {
  bool isSelected = label == selected;

  return GestureDetector(
    onTap: () => onChanged(label), // 👈 onChanged trigger
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      // decoration: BoxDecoration(
      //   color: isSelected ? Color(0xFFE8F5E9) : Colors.white,
      //   borderRadius: BorderRadius.circular(30),
      //   border: Border.all(
      //     color: isSelected ? Colors.green : Colors.grey.shade400,
      //     width: 1.5,
      //   ),
      //   boxShadow: [
      //     if (isSelected)
      //       BoxShadow(
      //         color: Colors.green.withOpacity(0.2),
      //         blurRadius: 6,
      //         offset: Offset(0, 3),
      //       ),
      //   ],
      // ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColor.greenMain : Colors.grey,
                width: 4,
              ),
            ),
            child: isSelected
                ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            )
                : null,
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: AppStyle.descriptions.copyWith(
              color: isSelected ? AppColor.blueMain : Colors.black54,
            ),),
        ],
      ),
    ),
  );
}

