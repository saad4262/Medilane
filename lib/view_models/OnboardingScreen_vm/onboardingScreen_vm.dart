import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  PageController pageController = PageController();

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      // Navigate to Home Screen or any other screen

    }
  }

  void updatePage(int index) {
    currentPage.value = index;
  }
}

