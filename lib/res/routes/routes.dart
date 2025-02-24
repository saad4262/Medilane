

import 'package:get/get.dart';

import 'package:medilane/res/routes/routes_name.dart';

import '../../view/login/onboarding_screen.dart';
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

  ];

}