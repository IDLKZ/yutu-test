import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../controllers/auth_controller.dart';

class LoginController extends GetxController {

  final authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  //Custom function

  authenticateUser(){

  }


  //Custom function


  @override
  void onClose() {
    this.emailController.dispose();
    this.passwordController.dispose();
    super.onClose();
  }
}
