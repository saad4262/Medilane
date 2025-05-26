import 'dart:ui';

import 'package:adminpanel1medilane/res/app_style/app_style.dart';
import 'package:adminpanel1medilane/res/colors/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medilane/res/widgets/customteextfield2.dart';

import '../../res/widgets/custom_drawer.dart';
import '../../res/widgets/my_categories.dart';
import '../home/home_screen.dart';
import 'appiontment_screen.dart';

class LabHome extends StatelessWidget {
  LabHome({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: MainNavigationScreen(),
    );
  }



  // final TextEditingController searchController = TextEditingController();
  // final FirebaseFirestore db = FirebaseFirestore.instance;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //
  // @override
  // Widget build(BuildContext context) {
  //   final height = MediaQuery.of(context).size.height;
  //   final width = MediaQuery.of(context).size.width;
  //
  //   return Scaffold(
  //     key: _scaffoldKey,
  //     drawer: CustomDrawer(),
  //     body: Column(
  //       children: [
  //         Container(
  //           height: height * 0.42,
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               begin: Alignment.center,
  //               end: Alignment.topRight,
  //               colors: [
  //                 Color(0xFF234F68),
  //                 Color(0xFFE8EA9D),
  //               ],
  //               stops: [0.2, 1.0],
  //             ),
  //             borderRadius: BorderRadius.only(
  //               bottomLeft: Radius.circular(50),
  //               bottomRight: Radius.circular(50),
  //             ),
  //           ),
  //           child: Stack(
  //             children: [
  //               Positioned(
  //                 top: 70,
  //                 left: 20,
  //                 child: InkWell(
  //                   onTap: () {
  //                     _scaffoldKey.currentState?.openDrawer();
  //                   },
  //                   child: Image.asset('assets/images/menu.png', width: 20),
  //                 ),
  //               ),
  //               Positioned(
  //                 top: 50,
  //                 right: 20,
  //                 child: CircleAvatar(
  //                   radius: 25,
  //                   backgroundImage: AssetImage('assets/images/mi.jpeg'),
  //                 ),
  //               ),
  //               Positioned(
  //                 top: 120,
  //                 left: 20,
  //                 child: Text(
  //                   'Welcome Back',
  //                   style: AppStyle.descriptions.copyWith(color: AppColor.whiteColor),
  //                 ),
  //               ),
  //               Positioned(
  //                 top: 145,
  //                 left: 20,
  //                 child: Text(
  //                   "Let's find",
  //                   style: AppStyle.headings2.copyWith(color: AppColor.whiteColor),
  //                 ),
  //               ),
  //               Positioned(
  //                 top: 180,
  //                 left: 20,
  //                 child: Text(
  //                   'your top doctor!',
  //                   style: AppStyle.headings2.copyWith(color: AppColor.whiteColor),
  //                 ),
  //               ),
  //               Positioned(
  //                 top: 250,
  //                 left: 25,
  //                 right: 25,
  //                 child: CustomTextField2(
  //                   hintText: "Search",
  //                   controller: searchController,
  //                   width: width * 0.9,
  //                   height: height * 0.07,
  //                   fillColor: AppColor.whiteColor,
  //                   borderColor: AppColor.whiteColor,
  //                   prefixIcon: Icon(FontAwesomeIcons.search, size: 18),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(height: height * 0.02),
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(left: width * 0.08),
  //               child: Text(
  //                 'Categories',
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: height * 0.02),
  //         Padding(
  //           padding: EdgeInsets.symmetric(horizontal: width * 0.04),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               MyCategories('All', 'assets/images/category1.png'),
  //               MyCategories('Cardiology', 'assets/images/category2.png'),
  //               MyCategories('Medicine', 'assets/images/category3.png'),
  //               MyCategories('General', 'assets/images/category4.png'),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           child: StreamBuilder<QuerySnapshot>(
  //             stream: db.collection('doctors').snapshots(),
  //             builder: (context, snapshot) {
  //               if (snapshot.connectionState == ConnectionState.waiting) {
  //                 return Center(child: CircularProgressIndicator());
  //               }
  //
  //               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  //                 return Center(child: Text('No doctors found'));
  //               }
  //
  //               final doctors = snapshot.data!.docs;
  //
  //               return ListView.builder(
  //                 itemCount: doctors.length,
  //                 itemBuilder: (context, index) {
  //                   final doc = doctors[index];
  //                   final name = doc['name'];
  //                   final speciality = doc['speciality'];
  //
  //                   return Padding(
  //                     padding: EdgeInsets.only(
  //                       left: width * 0.03,
  //                       right: width * 0.03,
  //                       bottom: height * 0.015,
  //                     ),
  //                     child: InkWell(
  //                       onTap: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                             builder: (context) => AppointmentScreen(name, speciality),
  //                           ),
  //                         );
  //                       },
  //                       child: Container(
  //                         padding: EdgeInsets.symmetric(horizontal: width * 0.04),
  //                         decoration: BoxDecoration(
  //                           border: Border.all(color: Color(0xffE0E2E2), width: 2),
  //                           borderRadius: BorderRadius.circular(25),
  //                         ),
  //                         child: Padding(
  //                           padding: EdgeInsets.symmetric(vertical: height * 0.015),
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.center,
  //                                 children: [
  //                                   Column(
  //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       CircleAvatar(
  //                                         radius: 25,
  //                                         backgroundImage: AssetImage('assets/images/mi.jpeg'),
  //                                       ),
  //                                       SizedBox(height: height * 0.027),
  //                                       Row(
  //                                         children: [
  //                                           Image.asset(
  //                                             'assets/images/star.png',
  //                                             scale: 4,
  //                                           ),
  //                                           Text('4.8'),
  //                                         ],
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   SizedBox(width: width * 0.03),
  //                                   Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         name,
  //                                         style: TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.bold,
  //                                         ),
  //                                       ),
  //                                       Text(
  //                                         speciality,
  //                                         style: TextStyle(fontSize: 16),
  //                                         textAlign: TextAlign.start,
  //                                       ),
  //                                       SizedBox(height: height * 0.02),
  //                                       Container(
  //                                         height: height * 0.040,
  //                                         width: width * 0.28,
  //                                         decoration: BoxDecoration(
  //                                           color: Color(0XFFF5F4F8),
  //                                           borderRadius: BorderRadius.circular(10),
  //                                         ),
  //                                         child: Center(
  //                                           child: Text(
  //                                             'Appointment',
  //                                             style: TextStyle(fontSize: 14),
  //                                             textAlign: TextAlign.center,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  //


}

class MainNavigationScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    LabHome2(),
    Search2(),
    Message2(),
    Profile2(),
    
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




class LabHome2 extends StatelessWidget {
   LabHome2({super.key});

  final TextEditingController searchController = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Container(
            height: height * 0.42,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF234F68),
                  Color(0xFFE8EA9D),
                ],
                stops: [0.2, 1.0],
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
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: Image.asset('assets/images/menu.png', width: 20),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/mi.jpeg'),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  child: Text(
                    'Welcome Back',
                    style: AppStyle.descriptions.copyWith(color: AppColor.whiteColor),
                  ),
                ),
                Positioned(
                  top: 145,
                  left: 20,
                  child: Text(
                    "Let's find",
                    style: AppStyle.headings2.copyWith(color: AppColor.whiteColor),
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 20,
                  child: Text(
                    'your top doctor!',
                    style: AppStyle.headings2.copyWith(color: AppColor.whiteColor),
                  ),
                ),
                Positioned(
                  top: 250,
                  left: 25,
                  right: 25,
                  child: CustomTextField2(
                    hintText: "Search",
                    controller: searchController,
                    width: width * 0.9,
                    height: height * 0.07,
                    fillColor: AppColor.whiteColor,
                    borderColor: AppColor.whiteColor,
                    prefixIcon: Icon(FontAwesomeIcons.search, size: 18),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.08),
                child: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyCategories('All', 'assets/images/category1.png'),
                MyCategories('Cardiology', 'assets/images/category2.png'),
                MyCategories('Medicine', 'assets/images/category3.png'),
                MyCategories('General', 'assets/images/category4.png'),
              ],
            ),
          ),
          SizedBox(height: height *0.03,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection('doctors').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No doctors found'));
                }

                final doctors = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doc = doctors[index];
                    final name = doc['name'];
                    final speciality = doc['speciality'];

                    return Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.03,
                        right: width * 0.03,
                        bottom: height * 0.015,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentScreen(name, speciality),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE0E2E2), width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: height * 0.015),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage('assets/images/mi.jpeg'),
                                        ),
                                        SizedBox(height: height * 0.027),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/star.png',
                                              scale: 4,
                                            ),
                                            Text('4.8'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          speciality,
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(height: height * 0.02),
                                        Container(
                                          height: height * 0.040,
                                          width: width * 0.28,
                                          decoration: BoxDecoration(
                                            color: Color(0XFFF5F4F8),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Appointment',
                                              style: TextStyle(fontSize: 14),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}


class Profile2 extends StatelessWidget {
  const Profile2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Profile")),
    );
  }
}


class Search2 extends StatelessWidget {
  const Search2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Search")),
    );
  }
}


class Message2 extends StatelessWidget {
  const Message2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Message")),
    );
  }
}
