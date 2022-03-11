import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../controllers/auth_controller.dart';

class LoginController extends GetxController {

  final authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  //Custom function
  static const List<Map> languagesApp = [
    {"title":"Рус.","code":"ru"},
    // {"title":"Kaz.","code":"kz"},
    {"title":"Eng.","code":"en"},
  ];
  authenticateUser(){

  }


  //Custom function


  @override
  void onClose() {
    //this.emailController.dispose();
    //this.passwordController.dispose();
    super.onClose();
  }
}
