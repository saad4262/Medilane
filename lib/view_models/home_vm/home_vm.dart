


import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating API call
    isLoading.value = false;
  }
}
