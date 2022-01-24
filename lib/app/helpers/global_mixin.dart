import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:intl/intl.dart';


import 'kcolors.dart';

class GlobalMixin {
  static String truncateText(String text, int length ,[int start = 0]){
    return text.length > length ? text.substring(0, length - 1) + "..." : text;
  }

  static SnackbarController successSnackBar(String title, String description) {
    return Get.snackbar(title, description, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kSuccess, colorText: Colors.white);
  }

  static SnackbarController warningSnackBar(String title, String description) {
    return Get.snackbar(title, description, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
  }

  static SnackbarController errorSnackBar(String title, String description) {
    return Get.snackbar(title, description, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kError, colorText: Colors.white);
  }

  static DateTime? convertToDateFormatController(TextEditingController dateController){
    try{
     return DateTime.parse(DateFormat("dd.MM.yyyy HH:mm").parse(dateController.text.trim()).toString());
    }
    catch(e){
      print(e);
    }
  }

  static convertData(DateTime time){
    DateFormat("d");
  }
}