

import 'dart:async';
import 'dart:ui';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:adminpanel1medilane/view_models/product_list/product_list.dart' as admin_panel;
import 'package:adminpanel1medilane/models/product_list/product_list.dart';


import 'package:flutter/material.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medilane/res/colors/app_color.dart';
import 'package:medilane/res/routes/routes_name.dart';
import 'package:medilane/view_models/auth_vm/auth_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/auth/admin_user_model.dart';
import '../../res/app_style/app_style.dart';
import '../../res/assets/image_assets.dart';
import '../../res/media-queries/media_query.dart';
import '../../res/widgets/custom_drawer.dart';
import '../../res/widgets/customteextfield2.dart';
import '../../view_models/auth_vm/admin_auth_vm.dart';
import '../../view_models/home_vm/home_vm.dart';
import '../../view_models/product_list.dart';
import 'checkout_screen.dart';
import 'med_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:adminpanel1medilane/view_models/auth_vm/auth_vm.dart';
import 'package:adminpanel1medilane/models/auth/user_model.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   //
   // final HomeController homeController = Get.put(HomeController());
   //
   //
   // AuthController authController = Get.put(AuthController());
   // final ProductController2 controller = Get.put(ProductController2());
   //
   // // AuthController3 authController3 = Get.find<AuthController3>();
   // final drawerController = Get.put(DrawerControllerX());
   // final searchController = TextEditingController();
   // final TextFieldFocusController searchController2 = Get.put(TextFieldFocusController());
   //
   //
   // final searchBarController = Get.put(SearchBarController());
   //
   // final DataController loadingController = Get.put(DataController());
   // final CartController cartController = Get.put(CartController());
   // // final MedicalStoreController controllerMedical = Get.put(MedicalStoreController());
   // final String storeId = 'adminStoreDocId'; // you need to know or get this from somewhere (could be fixed or passed)
   //
   //




   @override
  Widget build(BuildContext context) {
     // controller.fetchAllProducts();
     //
     // final mediaQuery = MediaQueryHelper(context);
     //
     // final height = MediaQuery.of(context).size.height;
     // final width = MediaQuery.of(context).size.width;


    return Scaffold(
      resizeToAvoidBottomInset: false, // ✅ Prevent moving widgets when keyboard opens
// backgroundColor: Colors.white,
//
//
//       key: _scaffoldKey, // ✅ Attach the key to Scaffold
//
//       drawer: CustomDrawer(), // Attach the custom drawer
//
//       body: Obx(() => homeController.isLoading.value
//     ? HomeShimmer()
//         : GestureDetector(
//         onTap: (){
//           FocusScope.of(context).unfocus();
//
//         },
//           child: Padding(
//           padding: mediaQuery.paddingOnly(top: 0,left: 0,right: 0),
          body: Column(
            children: [

              // Container(
              //   height: height * 0.42,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.center,
              //       end: Alignment.topRight,
              //       colors: [
              //         Color(0xFF234F68),
              //         Color(0xFFE8EA9D), // ~10% opacity = 0x1A
              //       ],
              //       stops: [0.2, 1.0], // Smooth blend
              //     ),
              //
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(50),
              //       bottomRight: Radius.circular(50),
              //     ),
              //   ),
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         top: 70,
              //         left: 20,
              //         child: InkWell(
              //             onTap: (){
              //
              //               _scaffoldKey.currentState?.openDrawer(); // ✅ Open the drawer using the key
              //
              //             },
              //             child: Image.asset('assets/images/menu.png', width: 20)),
              //       ),
              //       Positioned(
              //         top: 50,
              //         right: 20,
              //         child:Obx(() => Hero(
              //           tag: 'profile-avatar', // Same tag for Hero animation
              //
              //           child: CircleAvatar(
              //
              //
              //             radius: 30,
              //             backgroundImage:authController.profileImage.value.isNotEmpty
              //                 ? NetworkImage(authController.profileImage.value)
              //                 :  const AssetImage("assets/images/person1.png"),
              //             child: authController.profileImage.value.isEmpty
              //                 ? const Icon(Icons.person, size: 30)
              //                 : null,
              //           ),
              //         )),
              //
              //       ),
              //       // Positioned(
              //       //   top: 120,
              //       //   left: 20,
              //       //   child: Text(
              //       //       'Welcome Back',
              //       //       style: AppStyle.descriptions.copyWith(color: AppColor.whiteColor)
              //       //   ),
              //       // ),
              //       Positioned(
              //         top: 135,
              //         left: 20,
              //         child: RichText(
              //           text: TextSpan(
              //             children: [
              //               TextSpan(
              //                 text: "Hey, ",
              //                 style: AppStyle.headings2.copyWith(color: AppColor.whiteColor),
              //               ),
              //               TextSpan(
              //                   text: " ${authController.user.value?.username ?? ""} ! ",
              //                   style: AppStyle.headings2.copyWith(color: AppColor.whiteColor) // Change color as needed
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         top: 180,
              //         left: 20,
              //         child: Text(
              //             "Let's Start Exploring",
              //             style: AppStyle.headings2.copyWith(color: AppColor.whiteColor)
              //         ),
              //       ),
              //       Positioned(
              //         top: 250,
              //         left: 25,
              //         right: 25,
              //         child: CustomTextField2(
              //
              //           hintText: "Search",
              //                   controller: searchController,
              //                   width: width * 0.9,
              //                   height: height * 0.07,
              //                   fillColor: AppColor.whiteColor,
              //                   borderColor: AppColor.whiteColor,
              //                   prefixIcon: Icon(FontAwesomeIcons.search, size: 18),
              //           focusNode: searchController2.focusNode,
              //
              //
              //
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // Padding(
              //   padding: mediaQuery.paddingOnly(top: 5),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children:[
              //       Builder(
              //         builder: (context) => InkWell(
              //             onTap: (){
              //               _scaffoldKey.currentState?.openDrawer(); // ✅ Open the drawer using the key
              //
              //             },
              //             child: Icon(FontAwesomeIcons.barsStaggered)),
              //       ),
              //
              //         Text("HomeScreen"),
              //         Obx(() => Hero(
              //           tag: 'profile-avatar', // Same tag for Hero animation
              //
              //           child: CircleAvatar(
              //
              //
              //             radius: 30,
              //             backgroundImage:authController.profileImage.value.isNotEmpty
              //                 ? NetworkImage(authController.profileImage.value)
              //                 :  const AssetImage("assets/images/person1.png"),
              //             child: authController.profileImage.value.isEmpty
              //                 ? const Icon(Icons.person, size: 30)
              //                 : null,
              //           ),
              //         )),
              //
              //   ]
              //
              //   ),
              // ),

                // child: FloatingNavBar(
                //   resizeToAvoidBottomInset: false,
                //   color: AppColor.whiteColor,
                //   borderRadius: 25,
                //   selectedIconColor: AppColor.blueMain,
                //   unselectedIconColor: Colors.grey.withOpacity(0.6),
                //   items: [
                //     FloatingNavBarItem(iconData: FontAwesomeIcons.home, page: Home(), title: 'Home'),
                //     FloatingNavBarItem(iconData: FontAwesomeIcons.cartPlus, page: Doctors(), title: 'Doctors'),
                //     FloatingNavBarItem(iconData: FontAwesomeIcons.facebookMessenger, page: Reminders(), title: 'Reminders'),
                //     FloatingNavBarItem(iconData: FontAwesomeIcons.userDoctor, page: Records(), title: 'Records'),
                //   ],
                //   horizontalPadding: 0,
                //
                //   hapticFeedback: true,
                //   showTitle: false,
                // ),


            ],


      ),
      // bottomNavigationBar:
bottomNavigationBar:MainNavigationScreen(),

    );
  }

   // Widget build(BuildContext context) {
   //   controller.fetchAllProducts();
   //
   //   final mediaQuery = MediaQueryHelper(context);
   //   final height = MediaQuery.of(context).size.height;
   //   final width = MediaQuery.of(context).size.width;
   //
   //   return Scaffold(
   //     key: _scaffoldKey,
   //     drawer: CustomDrawer(),
   //     backgroundColor: Colors.white,
   //     resizeToAvoidBottomInset: false, // prevent widgets moving on keyboard open
   //
   //     body: Obx(() => homeController.isLoading.value
   //         ? HomeShimmer()
   //         : GestureDetector(
   //       onTap: () {
   //         FocusScope.of(context).unfocus();
   //       },
   //       child: CustomScrollView(
   //         // controller: scrollX.scrollController, // ✅ Use from controller
   //
   //         slivers: [
   //           SliverAppBar(
   //             expandedHeight: height * 0.42,
   //             pinned: true, // Keep toolbar visible when collapsed
   //             floating: false, // Prevent it from floating mid scroll
   //             snap: false, // No snap animation
   //             backgroundColor: Colors.transparent,
   //             elevation: 0,
   //             automaticallyImplyLeading: false,
   //             flexibleSpace: LayoutBuilder(
   //               builder: (BuildContext context, BoxConstraints constraints) {
   //                 var top = constraints.biggest.height;
   //                 bool isCollapsed = top <= kToolbarHeight + 10;
   //
   //                 return Stack(
   //                   fit: StackFit.expand,
   //
   //                   children: [
   //                     // Background gradient or solid when collapsed
   //                     Container(
   //                       decoration: BoxDecoration(
   //                         gradient: isCollapsed
   //                             ? null
   //                             : LinearGradient(
   //                           begin: Alignment.center,
   //                           end: Alignment.topRight,
   //                           colors: [
   //                             Color(0xFF234F68),
   //                             Color(0xFFE8EA9D),
   //                           ],
   //                           stops: [0.4, 1.0],
   //                         ),
   //                         color: isCollapsed ? Color(0xFF234F68) : null,
   //                         borderRadius: isCollapsed
   //                             ? null
   //                             : BorderRadius.only(
   //                           bottomLeft: Radius.circular(50),
   //                           bottomRight: Radius.circular(50),
   //                         ),
   //                       ),
   //                     ),
   //
   //                     // Menu icon
   //                     Positioned(
   //                       top: 70,
   //                       left: 20,
   //                       child: InkWell(
   //                         onTap: () {
   //                           _scaffoldKey.currentState?.openDrawer();
   //                         },
   //                         child: Image.asset('assets/images/menu.png', width: 20),
   //                       ),
   //                     ),
   //
   //                     // Profile avatar
   //
   //                     Obx(() => Positioned(
   //                       top: 55,
   //                       right: 80,
   //                       child: Stack(
   //                         children: [
   //                           IconButton(
   //                             icon: Icon(Icons.shopping_cart, color: Colors.white),
   //                             onPressed: () {
   //                               print("Cart count: ${cartController.cartItems.length}");
   //                               Navigator.of(context).push(
   //                                 PageRouteBuilder(
   //                                   transitionDuration: const Duration(milliseconds: 400),
   //                                   pageBuilder: (context, animation, secondaryAnimation) => CheckoutScreen(),
   //                                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
   //                                     final begin = Offset(-1, 1.0);
   //                                     final end = Offset.zero;
   //                                     final curve = Curves.easeInOut;
   //                                     final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
   //                                     return SlideTransition(
   //                                       position: animation.drive(tween),
   //                                       child: child,
   //                                     );
   //                                   },
   //                                 ),
   //                               );
   //                             },
   //                           ),
   //                           if (cartController.cartItems.isNotEmpty)
   //                             Positioned(
   //                               right: 6,
   //                               top: 6,
   //                               child: Container(
   //                                 padding: EdgeInsets.all(4),
   //                                 decoration: BoxDecoration(
   //                                   color: Colors.red,
   //                                   shape: BoxShape.circle,
   //                                 ),
   //                                 child: Text(
   //                                   '${cartController.cartItems.length}',
   //                                   style: TextStyle(
   //                                     color: Colors.white,
   //                                     fontSize: 12,
   //                                   ),
   //                                 ),
   //                               ),
   //                             ),
   //                         ],
   //                       ),
   //                     )),
   //
   //
   //
   //
   //                     Positioned(
   //                       top: 50,
   //                       right: 20,
   //                       child: Obx(
   //                             () => Hero(
   //                           tag: 'profile-avatar',
   //                           child: CircleAvatar(
   //                             radius: 26,
   //                             backgroundImage: authController.profileImage.value.isNotEmpty
   //                                 ? NetworkImage(authController.profileImage.value)
   //                                 : const AssetImage("assets/images/person1.png"),
   //                             child: authController.profileImage.value.isEmpty
   //                                 ? const Icon(Icons.person, size: 30)
   //                                 : null,
   //                           ),
   //
   //                             ),
   //                       ),
   //                     ),
   //
   //                     // Only show this content when expanded
   //                     if (!isCollapsed) ...[
   //                       Positioned(
   //                         top: 135,
   //                         left: 20,
   //                         child: RichText(
   //                           text: TextSpan(
   //                             children: [
   //                               TextSpan(
   //                                 text: "Hey, ",
   //                                 style: AppStyle.headings2.copyWith(color: AppColor.whiteColor),
   //                               ),
   //                               TextSpan(
   //                                 text: " ${authController.user.value?.username ?? ""} ! ",
   //                                 style: AppStyle.headings2.copyWith(color: AppColor.whiteColor),
   //                               ),
   //                             ],
   //                           ),
   //                         ),
   //                       ),
   //                       Positioned(
   //                         top: 180,
   //                         left: 20,
   //                         child: Text(
   //                           "Let's Start Exploring",
   //                           style: AppStyle.headings2.copyWith(color: AppColor.whiteColor),
   //                         ),
   //                       ),
   //                       Positioned(
   //                         top: 250,
   //                         left: 25,
   //                         right: 25,
   //                         child: CustomTextField2(
   //                           hintText: "Search",
   //                           controller: searchController,
   //                           width: width * 0.9,
   //                           height: height * 0.07,
   //                           fillColor: AppColor.whiteColor,
   //                           borderColor: AppColor.whiteColor,
   //                           prefixIcon: Icon(FontAwesomeIcons.search, size: 18),
   //                           focusNode: searchController2.focusNode,
   //                         ),
   //                       ),
   //                     ],
   //                   ],
   //                 );
   //               },
   //             ),
   //           ),
   //
   //           SliverFillRemaining(
   //             child: MainNavigationScreen(),
   //           ),
   //         ],
   //       ),
   //     )),
   //   );
   // }

}


class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}




class MainNavigationScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    Home(),
    Reminders(),
    Records(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        extendBody: true, // Important: allows content to show behind the navbar

        backgroundColor: Colors.transparent,
      body: pages[controller.selectedIndex.value],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1), // translucent
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // subtle shadow
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                // backgroundColor: Colors.transparent, // <-- transparent background
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.selectedIndex.value,
                onTap: controller.changeTab,
                selectedItemColor: AppColor.blueMain,
                unselectedItemColor: Colors.grey.withOpacity(0.6),
                showUnselectedLabels: false,
                showSelectedLabels: false,
                elevation: 0, // no default elevation
                items: [
                  _buildItem(FontAwesomeIcons.home, 0),
                  _buildItem(FontAwesomeIcons.cartPlus, 1),
                  _buildItem(FontAwesomeIcons.facebookMessenger, 2),
                  _buildItem(FontAwesomeIcons.userDoctor, 3),
                ],
              ),
            ),
          ),
        ),
            ),
      )));
  }

  BottomNavigationBarItem _buildItem(IconData icon, int index) {
    final isSelected = controller.selectedIndex.value == index;
    return BottomNavigationBarItem(
      label: '',
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 23,
            color: isSelected ? AppColor.blueMain : Colors.grey,
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isSelected ? AppColor.blueMain : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}





class Home extends StatelessWidget {

  AuthController authController = Get.put(AuthController());
  // ProductController productController = Get.put(ProductController());
  final ProductController2 controller = Get.put(ProductController2());
  // final  AuthController3 authController3 = Get.put(AuthController3());

  final DataController loadingController = Get.put(DataController());

  final MedicalStoreController medicalStoreController = Get.put(MedicalStoreController());

  //
  // final MedicalStoreController controllerMedical = Get.put(MedicalStoreController());
  // final String storeId = 'adminStoreDocId'; // you need to know or get this from somewhere (could be fixed or passed)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final HomeController homeController = Get.put(HomeController());



  // AuthController3 authController3 = Get.find<AuthController3>();
  final drawerController = Get.put(DrawerControllerX());
  final searchController = TextEditingController();
  final TextFieldFocusController searchController2 = Get.put(TextFieldFocusController());


  final searchBarController = Get.put(SearchBarController());

  final CartController cartController = Get.put(CartController());
  // final MedicalStoreController controllerMedical = Get.put(MedicalStoreController());
  final String storeId = 'adminStoreDocId'; // you need to know or get this from somewhere (could be fixed or passed)





  @override
  Widget build(BuildContext context) {
    controller.fetchAllProducts();

    final mediaQuery = MediaQueryHelper(context);



    return Scaffold(
        resizeToAvoidBottomInset: false, // ✅ Prevent moving widgets when keyboard opens
        backgroundColor: Colors.white,


        key: _scaffoldKey, // ✅ Attach the key to Scaffold

        drawer: CustomDrawer(), // Attach the custom drawer

        body: Obx(() => homeController.isLoading.value
        ? HomeShimmer()
        : GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();

        },
        child: Padding(
        padding: mediaQuery.paddingOnly(top: 0,left: 0,right: 0),
    child:  SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: mediaQuery.height(42),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF234F68),
                    Color(0xFFE8EA9D), // ~10% opacity = 0x1A
                  ],
                  stops: [0.2, 1.0], // Smooth blend
                ),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 70,
                    left: 20,
                    child: InkWell(
                        onTap: (){

                          _scaffoldKey.currentState?.openDrawer(); // ✅ Open the drawer using the key

                        },
                        child: Image.asset('assets/images/menu.png', width: 20)),
                  ),


                  Obx(() => Positioned(
                                          top: 55,
                                          right: 80,
                                          child: Stack(
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.shopping_cart, color: Colors.white),
                                                onPressed: () {
                                                  print("Cart count: ${cartController.cartItems.length}");
                                                  Navigator.of(context).push(
                                                    PageRouteBuilder(
                                                      transitionDuration: const Duration(milliseconds: 400),
                                                      pageBuilder: (context, animation, secondaryAnimation) => CheckoutScreen(),
                                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                        final begin = Offset(-1, 1.0);
                                                        final end = Offset.zero;
                                                        final curve = Curves.easeInOut;
                                                        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                                        return SlideTransition(
                                                          position: animation.drive(tween),
                                                          child: child,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                              if (cartController.cartItems.isNotEmpty)
                                                Positioned(
                                                  right: 6,
                                                  top: 6,
                                                  child: Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Text(
                                                      '${cartController.cartItems.length}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )),

                  Positioned(
                    top: 50,
                    right: 20,
                    child:Obx(() => Hero(
                      tag: 'profile-avatar', // Same tag for Hero animation

                      child: CircleAvatar(


                        radius: 30,
                        backgroundImage:authController.profileImage.value.isNotEmpty
                            ? NetworkImage(authController.profileImage.value)
                            :  const AssetImage("assets/images/person1.png"),
                        child: authController.profileImage.value.isEmpty
                            ? const Icon(Icons.person, size: 30)
                            : null,
                      ),
                    )),

                  ),
                  // Positioned(
                  //   top: 120,
                  //   left: 20,
                  //   child: Text(
                  //       'Welcome Back',
                  //       style: AppStyle.descriptions.copyWith(color: AppColor.whiteColor)
                  //   ),
                  // ),
                  Positioned(
                    top: 135,
                    left: 20,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Hey, ",
                            style: AppStyle.headings2.copyWith(color: AppColor.whiteColor),
                          ),
                          TextSpan(
                              text: " ${authController.user.value?.username ?? ""} ! ",
                              style: AppStyle.headings2.copyWith(color: AppColor.whiteColor) // Change color as needed
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 20,
                    child: Text(
                        "Let's Start Exploring",
                        style: AppStyle.headings2.copyWith(color: AppColor.whiteColor)
                    ),
                  ),
                  Positioned(
                    top: 250,
                    left: 25,
                    right: 25,
                    child: CustomTextField2(

                       onChanged: (value) {
                         controller.updateSearchQuery(value.trim());
                       },

                      hintText: "Search",
                      controller: searchController,
                      width: mediaQuery.width(9),
                      height: mediaQuery.height(7),
                      fillColor: AppColor.whiteColor,
                      borderColor: AppColor.whiteColor,
                      prefixIcon: Icon(FontAwesomeIcons.search, size: 18),
                      focusNode: searchController2.focusNode,



                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: mediaQuery.height(1.2)),


            Padding(
              padding: mediaQuery.paddingOnly(left: 5),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Deals of the Day",style: AppStyle.headings.copyWith(color: AppColor.blueMain),),)
    ),
            SizedBox(height: mediaQuery.height(1)),


            Container(
              color: Colors.white,
              height: 150, // Fixed height for slider
              // width: mediaQuery.width(100),

              child: CardSliderScreen(),
            ),

            SizedBox(height: mediaQuery.height(3)),


            Padding(
                padding: mediaQuery.paddingOnly(left: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Featured Products",style: AppStyle.headings.copyWith(color: AppColor.blueMain),),)
            ),
            SizedBox(height: mediaQuery.height(1)),




            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: mediaQuery.paddingSymmetric(horizontal: 8),
                  child: MedicineCategorySelector(),
                )),

            // SizedBox(height: 10),

            // GridView with fixed height using shrinkWrap and physics
            Container(
              color: Colors.white,
              child: Padding(
                padding: mediaQuery.paddingOnly(top: 0,bottom: 2,left: 2,right: 2),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColor.blueMain,
                        size: 50,
                      ),
                    );
                  }
                  if (controller.filteredProducts.isEmpty) {
                    return Center(child: Text('No products found'));
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Let SingleChildScrollView handle scrolling
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.63,
                    ),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return _buildCard(product, context);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
    )
    ),
    ),
    ),
    );
  }

  Widget _buildCard(Product product,BuildContext context) {

    medicalStoreController.fetchAllStores();
    // controllerMedical.fetchStoreName(storeId);

    final mediaQuery = MediaQueryHelper(context);
    // final ProductController2 controller = Get.put(ProductController2());
    // controller.fetchUserProfile2(authController3.user.value!.uid);
    final  AuthController3 authController3 = Get.put(AuthController3());

    final ProductController2 controller3= Get.find(); // Get the controller

    return GestureDetector(
      onTap: () {

        controller.setSelectedProduct(product);

        // Get the ProductController instance
        final ProductController2 controller3 = Get.find();

        // Set the selected product
        controller3.setSelectedProduct(product);

        // Navigate to the DetailScreen
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final begin = const Offset(-1, 1.0);
              final end = Offset.zero;
              final curve = Curves.easeInOut;
              final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: mediaQuery.paddingAll(1.3),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: product.id, // Unique tag for hero animation
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: product.imageUrl,
                              width: double.infinity,
                              height: mediaQuery.height(20),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()), // optional placeholder while loading
                              errorWidget: (context, url, error) => Icon(Icons.error), // optional error widget if image fails to load
                            ),
                            Positioned(
                              bottom: 5,
                              right: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColor.blueMain,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  product.price.toString(), // Convert double to String before displaying
                                  style: AppStyle.descriptions.copyWith(fontSize: 12, color: Colors.white,fontWeight: FontWeight.bold)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.only(left: 4, top: 5),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          product.name, // Product Name
                          style: AppStyle.descriptions.copyWith(fontWeight: FontWeight.bold,color: AppColor.blueMain,fontSize: 14),
                        ),
                      ),
                    ),
                    // SizedBox(height: 4),
                    // Text(
                    //   "\$${product.price.toStringAsFixed(2)}", // Product Price
                    //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.green),
                    // ),
                    SizedBox(height: mediaQuery.height(1)),
                    Padding(
                      padding: mediaQuery.paddingOnly(left: .5,right: .5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 14),
                              SizedBox(width: mediaQuery.width(1),),
                              Text("4.5", style: AppStyle.descriptions.copyWith(color: AppColor.blueMain,fontSize: 12)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on, size: 14, color: AppColor.blueMain),
                              SizedBox(width: mediaQuery.width(1),),
                              Text("Sahiwal", style: AppStyle.descriptions.copyWith(color: AppColor.blueMain,fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: mediaQuery.paddingOnly(right: 1),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 12,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            SizedBox(width: 8),
                            // Text("Clinix"), // Replace with the relevant user name if needed

                            Obx(() {
                              if (medicalStoreController.stores.isEmpty) {
                                return const CircularProgressIndicator();
                              } else {
                                final store = medicalStoreController.stores.firstWhere(
                                      (store) => store.uid == product.uid,
                                  orElse: () => UserModelAdmin(medicalstoreName: 'Unknown Store', uid: '', email: ''),
                                );


                                return Text(
                                  store?.medicalstoreName ?? 'Unknown Store',
                                  style: AppStyle.descriptions.copyWith(color: AppColor.blueMain, fontSize: 12),
                                );
                              }
                            }),

                            // Obx(() {
                            //   if (controllerMedical.storeName.value == '') {
                            //     return CircularProgressIndicator();
                            //   }
                            //   return Text(
                            //     ' ${controllerMedical.storeName.value}',
                            //     style: TextStyle(fontSize: 12),
                            //   );
                            // }),
                
                            // Replace with the relevant user name if needed
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ),

      );

  }
}


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Profile")),
    );
  }
}

class Reminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Reminders Page"));
  }
}

class Records extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Records Page"));
  }
}



class HomeShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          // Top Row (Menu, Title, Profile Image)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildShimmerBox(width: 40, height: 40), // Menu Icon
              _buildShimmerBox(width: 120, height: 20), // Title
              _buildShimmerBox(width: 60, height: 60, radius: 30), // Profile Image
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: _buildShimmerBox(width: double.infinity, height: 200), // Main Content
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
            child: _buildShimmerBox(width: double.infinity, height: 70, radius: 25),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height, double radius = 8.0}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}



class SearchBarController extends GetxController {
  var shouldShowSearchBar = true.obs;

  void toggleSearchBar() {
    shouldShowSearchBar.value = !shouldShowSearchBar.value;
  }

  void hideSearchBar() {
    shouldShowSearchBar.value = false;
  }

  void showSearchBar() {
    shouldShowSearchBar.value = true;
  }
}





class CardSliderController extends GetxController {
  final PageController pageController = PageController(viewportFraction: 0.8);
  var currentPage = 0.obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      currentPage.value = (currentPage.value + 1) % 5;
      pageController.animateToPage(
        currentPage.value,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    pageController.dispose();
    super.onClose();
  }
}


class CardSliderScreen extends StatelessWidget {
  final CardSliderController controller = Get.put(CardSliderController());

  final List<Map<String, dynamic>> salesItems = [
    {
      'name': 'Paracetamol ',
      'brand': 'GSK',
      'image': 'assets/images/panadol.png',
      'oldPrice': 120,
      'newPrice': 90,
    },
    {
      'name': 'Vitamin C',
      'brand': 'NutraLife',
      'image': 'assets/images/panadol.png',
      'oldPrice': 200,
      'newPrice': 150,
    },
    {
      'name': 'Cough Syrup',
      'brand': 'Benadryl',
      'image': 'assets/images/panadol.png',
      'oldPrice': 180,
      'newPrice': 135,
    },
    {
      'name': 'Hand Sanitizer',
      'brand': 'Dettol',
      'image': 'assets/images/panadol.png',
      'oldPrice': 75,
      'newPrice': 60,
    },
    {
      'name': 'Thermometer',
      'brand': 'Omron',
      'image': 'assets/images/panadol.png',
      'oldPrice': 300,
      'newPrice': 250,
    },
  ];

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQueryHelper(context);


      return PageView.builder(

        controller: controller.pageController,
        itemCount: salesItems.length,
        itemBuilder: (context, index) {
          final item = salesItems[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: mediaQuery.width(100),
                decoration: BoxDecoration(
                  color: Color(0XFFF5F4F8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Product Image
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(24),left: Radius.circular(10)),
                        child: Image.asset(
                          item['image'],
                          height: 220,
                          width: mediaQuery.width(30),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Info
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'],
                                style: AppStyle.descriptions),
                            SizedBox(height: 4),
                            Text("by ${item['brand']}",
                                style: AppStyle.descriptions.copyWith(color: Colors.grey,fontSize: 12)),
                            Spacer(),
                            Row(
                              children: [
                                Text("Rs. ${item['oldPrice']}",
                                    style:AppStyle.descriptions.copyWith(decoration: TextDecoration.lineThrough,
                                      color: Colors.redAccent,)),
                                SizedBox(width: 8),
                                Text("Rs. ${item['newPrice']}",
                                    style: AppStyle.descriptions.copyWith(color: AppColor.blueMain,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${((1 - item['newPrice'] / item['oldPrice']) * 100).round()}% OFF",
                                style: AppStyle.descriptions.copyWith(color: Colors.green.shade800, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },


    );
  }
}




class CategoryController extends GetxController {
  RxString selectedCategory = ''.obs;

  void setCategory(String category) {
    selectedCategory.value = category;
  }
}


class MedicineCategorySelector extends StatelessWidget {
  final List<String> categories = [
    'All',
    'Tablets',
    'Syrups',
    'Injections',
    'Creams/Ointments',
    'Drops',
    'Powders',
    'Inhalers',
    'others'
  ];

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = controller.selectedCategory.value == category;
        return GestureDetector(
          onTap: () => controller.setCategory(category),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColor.blueMain : const Color(0xffF5F4F8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColor.blueMain : const Color(0xffF5F4F8),
              ),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 15,
                color: isSelected ? AppColor.whiteColor : AppColor.blueMain,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'poppins',
              ),
            ),
          ),
        );
      }).toList(),
    ));
  }
}






class ScrollControllerX extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxBool isCollapsed = false.obs;

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      final offset = scrollController.offset;
      if (offset > 100 && !isCollapsed.value) {
        isCollapsed.value = true;
      } else if (offset <= 100 && isCollapsed.value) {
        isCollapsed.value = false;
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
