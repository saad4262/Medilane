import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilane/res/getx_loclization/languages.dart';
import 'package:medilane/res/routes/routes.dart';




void main() {
  runApp(const MyApp());
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
    );
  }
}

