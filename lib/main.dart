import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilane/res/getx_loclization/languages.dart';
import 'package:medilane/res/routes/routes.dart';
import 'package:medilane/view/signup/location_screen1.dart';
import 'package:medilane/view/signup/profile_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: Languages(),
      locale: const Locale('en' ,'US'),
      fallbackLocale: const Locale('en' ,'US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutes.appRoutes(),
      // home: ProfileScreen(),
    );
  }
}

