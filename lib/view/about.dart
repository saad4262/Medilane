import 'package:adminpanel1medilane/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../res/app_style/app_style.dart';
import '../res/media-queries/media_query.dart';
import '../res/widgets/custom_drawer.dart';

class AboutScreen extends StatelessWidget {
   AboutScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: const Text('About Medilane'),
      //   backgroundColor: Colors.teal,
      // ),
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
                    'About',
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

            SizedBox(height: mediaQuery.height(3),),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Medilane',
                      style: AppStyle.headings.copyWith(color: AppColor.blueMain),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Medilane is your all-in-one healthcare companion, offering access to medical stores, '
                          'diagnostic labs, AI-based medical tests, and virtual consultations with an AI doctor.',
                      style: AppStyle.descriptions.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Medical Stores',
                      style: AppStyle.headings.copyWith(color: AppColor.blueMain),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Browse and order medicines from trusted medical stores near you. '
                          'Get fast delivery and authentic products at your doorstep.',
                      style: TextStyle(fontSize: 15, height: 1.4),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Medical Labs',
                      style: AppStyle.headings.copyWith(color: AppColor.blueMain),
                    ),
                    const SizedBox(height: 8),
                     Text(
                      'Schedule lab tests with certified diagnostic centers. '
                          'Get detailed reports directly on your phone, with easy tracking.',
                      style: AppStyle.descriptions.copyWith(fontSize: 13)
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'AI Medical Test Model',
                      style:AppStyle.headings.copyWith(color: AppColor.blueMain),
                    ),
                    const SizedBox(height: 8),
                     Text(
                      'Our advanced AI model analyzes your medical test results and provides '
                          'insights to help you understand your health better.',
                      style: AppStyle.descriptions.copyWith(fontSize: 13)
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'AI Doctor',
                      style: AppStyle.headings.copyWith(color: AppColor.blueMain),
                    ),
                    const SizedBox(height: 8),
                     Text(
                      'Chat with our AI-powered doctor anytime for instant medical advice, '
                          'symptom checks, and health tips — available 24/7 for your convenience.',
                      style: AppStyle.descriptions.copyWith(fontSize: 13),
                    ),
                     SizedBox(height: mediaQuery.height(5),),
                    Center(
                      child: Text(
                        'Your Health, Our Priority',
                        style: AppStyle.descriptions.copyWith(fontSize: 12,color: Color(0xff757474),))
                      ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
