import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController
  TextEditingController text = new TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  //DELETE USER
  deleteUser(){
    if(text.text == "0000"){
      Get.offAllNamed(Routes.DELETE);
    }
    else{
      text.text = "";
      Get.back();
    }


  }



  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    text.dispose();
  }
}
