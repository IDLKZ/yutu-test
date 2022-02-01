import 'package:findout/app/helpers/global_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';

class RegisterController extends GetxController {
  final authController = Get.find<AuthController>();
  final registerFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  //Custom function
  authenticateUser(){
    if(registerFormKey.currentState!.validate()){
      return authController.register(
          emailController.text.trim(),
          passwordController.text.trim(),
          nameController.text.trim(),
          surnameController.text.trim(),
          ageController.text.trim(),
          int.parse(cityController.text.trim())
      );
    }
  }





  //Custom function




  @override
  void onClose() {
    nameController.dispose();
    surnameController.dispose();
    ageController.dispose();
    cityController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
