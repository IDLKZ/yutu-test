import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/helpers/country_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ntp/ntp.dart';

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

  static DateTime convertToDate(String? data){
    try{
      if(data != null){
        return DateFormat("dd.MM.yyyy").parse(data);
      }
    }
    catch(e){}
    return DateTime.now();
  }

  static DateTime getBirthDate(String? data){
    try{
      return DateFormat("dd.MM.yyyy").parse(data??"");
    }
    catch(e){
      return DateTime(DateTime.now().year - 18);
    }

  }

  static List<Map<String,dynamic>> getListCities(){
    return CountryConstants.cities_ru;
  }

  static String? cityName(int? city){
    return city != null ? CountryConstants.citiesMapRu[city] : null;
  }

  String? getLocale() {
    String locale = Get.locale!.languageCode;
    return locale.capitalizeFirst;
  }

  static Future<String> getCurrentLocale() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locale = prefs.getString("langLocale") ?? "ru";
    return locale;
  }

  static setShared(String key, dynamic value ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(value.runtimeType == String){
      prefs.setString(key, value);
    }
    if(value.runtimeType == bool){
      prefs.setBool(key, value);
    }
    if(value.runtimeType == int){
      prefs.setInt(key, value);
    }
    if(value.runtimeType == double){
      prefs.setDouble(key, value);
    }
  }

  static getImage(String? image){
    if(image.toString() != "null" && image.toString().isNotEmpty){
      return NetworkImage(image.toString());
    }
    else{
      return AssetImage("assets/images/ava.png");
    }
  }

  static getTimestamp()async {
    DateTime startDate = await NTP.now();
    return startDate.millisecondsSinceEpoch;
  }

}