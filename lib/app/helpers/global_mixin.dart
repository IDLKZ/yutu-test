import 'package:findout/app/controllers/location_controller.dart';
import 'package:findout/app/data/models/fcm_model.dart';
import 'package:findout/app/helpers/api_constants.dart';
import 'package:findout/app/helpers/country_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ntp/ntp.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
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

  static int convertToDateFormatControllerToMilliseconds(TextEditingController dateController,{String format = "dd-MM-yyyy HH:mm"}){
    try{
     return DateTime.parse(DateFormat(format).parse(dateController.text.trim()).toString()).millisecondsSinceEpoch;
    }
    catch(e){
      print(e);
      return getTimestamp();
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
    return Get.find<LocationController>().locale.value == "en"? CountryConstants.cities_en :       CountryConstants.cities_ru;
  }

  static String? cityName(String? city){
    // return city != null ? (Get.find<LocationController>().locale.value == "en"? CountryConstants.citiesMapEn[city] : CountryConstants.citiesMapRu[city] ) : null;
    return city != null ? "$city" : null;
  }

  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    if (query.isEmpty && query.length < 3) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    }
    var url = Uri.https('api.geoapify.com', '/v1/geocode/autocomplete', {'text': query, 'apiKey': 'bfc117fe64f2427f8390c8ebd9b54f83'});

    var response = await http.get(url);

    List<Suggestion> suggestions = [];
    if (response.statusCode == 200) {
      // Iterable json = convert.jsonDecode(response.body);
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      var json = jsonResponse['features'];

      suggestions =
      List<Suggestion>.from(json.map((model) => Suggestion.fromJson(model)));

      print('Number of suggestion: ${suggestions.length}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return Future.value(suggestions
        .map((e) => {'name': e.word})
        .toList());
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
      Get.updateLocale(Locale(value??"ru"));
      Get.find<LocationController>().locale.value = value??"ru";
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

class Suggestion {
  final String word;

  Suggestion({
    required this.word,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      word: json['properties']['address_line1'],
    );
  }
}

class FCMSender{

    static Future sendNotification(String to, String collapseKey, Map<String,dynamic> notification,{String priority = "high"}) async
    {

      FCMNotification FCMnotification =  FCMNotification(title:notification["title"],body:notification["body"]);
        FCM fcm = FCM(to: to, collapseKey: collapseKey, priority: priority,notification: FCMnotification);
        final data = fcm.toJson();
        String token = ApiConstants.FCM_AUTH;
        try{
          await http.post(
            Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: convert.jsonEncode(data),
          );
        }
        catch(e){
          print(e);
        }


    }



}