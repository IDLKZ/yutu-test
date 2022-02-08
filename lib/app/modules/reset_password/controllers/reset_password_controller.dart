import 'package:findout/app/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {

  GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final authController = Get.find<AuthController>();

  resetPassword() {

  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }
}
