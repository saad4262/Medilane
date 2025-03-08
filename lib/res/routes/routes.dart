

import 'package:get/get.dart';

import 'package:medilane/res/routes/routes_name.dart';
import 'package:medilane/view/login/login_screen1.dart';
import 'package:medilane/view/signup/location_screen1.dart';
import 'package:medilane/view/signup/profile_screen.dart';
import 'package:medilane/view/signup/singup_screen1.dart';

import '../../view/home/home_screen.dart';
import '../../view/login/login_screen2.dart';
import '../../view/onboarding/onboarding_screen.dart';
import '../../view/signup/location_screen1.dart';
// import '../../view/splash_screen.dart';

class AppRoutes {



  static appRoutes() => [
    // GetPage(
    //   name: RouteName.splashScreen,
    //   page: () => SplashScreen() ,
    //   transitionDuration: Duration(milliseconds: 250),
    //   transition: Transition.leftToRightWithFade ,
    // ) ,
    GetPage(
      name: RouteName.OnboardingScreen,
      page: () => OnboardingScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade ,
    ) ,

    GetPage(
      name: RouteName.LoginScreen1,
      page: () => LoginScreen1() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeft ,
    ) ,


    GetPage(
      name: RouteName.LoginScreen2,
      page: () => LoginScreen2() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeft ,
    ),


    GetPage(
      name: RouteName.SignupScreen1,
      page: () => SignupScreen1() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeft ,
    ),


    GetPage(
      name: RouteName.MapScreen,
      page: () => MapView() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeft ,
    ),

    GetPage(
      name: RouteName.ProfileScreen,
      page: () => ProfileScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeft ,
    ),

    GetPage(
      name: RouteName.HomeScreen,
      page: () => HomeScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeft ,
    ),
  ];

}