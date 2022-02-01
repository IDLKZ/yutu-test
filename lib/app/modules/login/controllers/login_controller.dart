import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../controllers/auth_controller.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  //Custom function

  authenticateUser(){
    if (loginFormKey.currentState!.validate()) {
      return authController.login(emailController.text.trim(), passwordController.text.trim());
    }
  }


  //Custom function


  @override
  void onClose() {
    this.emailController.dispose();
    this.passwordController.dispose();
    super.onClose();
  }
}
