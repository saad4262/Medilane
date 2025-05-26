import 'package:adminpanel1medilane/view_models/auth_vm/auth_vm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:medilane/firebase_options.dart';
import 'package:medilane/res/getx_loclization/languages.dart';
import 'package:medilane/res/routes/routes.dart';
import 'package:medilane/view/home/home_screen.dart';
import 'package:medilane/view/home/invoice_screen.dart';
import 'package:medilane/view/home/med_detail.dart';
import 'package:medilane/view_models/product_list.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
);
  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } catch (e) {
  //   if (e.toString().contains("already exists")) {
  //     print("🔥 Firebase already initialized");
  //   } else {
  //     rethrow;
  //   }
  // }
  await dotenv.load(fileName: "key.env");

  Get.put(AuthController3());
  Get.put(ProductController());
  Get.put(ProductController2());
  Get.lazyPut(() => CategoryController());

  Get.lazyPut(() => PdfService());
  Get.lazyPut(() => EmailService());


  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      // home: HomeScreen(),
    );
  }
}

