



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medilane/view_models/auth_vm/auth_vm.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Icon(Icons.menu),

              Text("HomeScreen"),
              Obx(() => CircleAvatar(
                radius: 30,
                backgroundImage:authController.profileImage.value.isNotEmpty
                    ? NetworkImage(authController.profileImage.value)
                    : null,
                child: authController.profileImage.value.isEmpty
                    ? const Icon(Icons.person, size: 30)
                    : null,
              )),

        ]

        ),
      ),
    );
  }
}
