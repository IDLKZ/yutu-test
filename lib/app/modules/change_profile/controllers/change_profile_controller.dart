import 'package:findout/app/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeProfileController extends GetxController {
  UserController user = Get.find<UserController>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   nameController.text = user.user?.name??"";
   surnameController.text = user.user?.surname??"";
   ageController.text = user.user?.age.toString()??'';
   cityController.text = user.user?.city??"";
   emailController.text = user.user?.email??"";
  }

  static const List<Map> languagesApp = [
    {"title":"Рус.","code":"ru"},
    // {"title":"Kaz.","code":"kz"},
    {"title":"Eng.","code":"en"},
  ];



  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cityController.dispose();
    ageController.dispose();
  }
}
