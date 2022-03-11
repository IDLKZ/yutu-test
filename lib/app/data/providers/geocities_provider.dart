import 'dart:convert';

import 'package:findout/app/data/models/geocities_model.dart';
import 'package:findout/app/helpers/api_constants.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class GeoCitiesProvider extends GetConnect{

Future <CitiesGeoList> getCities(String name,{int limit = 5})async{
  try{
    String lang = await GlobalMixin.getCurrentLocale();
    var queryParameters = {
      'rapidapi-key': ApiConstants.RapidApiKey,
      'namePrefix': name,
      'limit':limit.toString(),
      'languageCode':lang,
    };
    Uri request = Uri.https(ApiConstants.RapidEndPoint, ApiConstants.RapidEndPointCity, queryParameters);
    final response = await http.get(request);
    if(response.statusCode == 200){
      return CitiesGeoList(cities: jsonDecode(response.body));
    }
    else{
      return CitiesGeoList(cities: []);
    }
  }
  catch(e){
    print(e);
    return CitiesGeoList(cities: []);
  }



}

Future <List<Map<String,String>>> getCitiesLists(String name,{int limit = 5})async{
  try{
    String lang = await GlobalMixin.getCurrentLocale();
    var queryParameters = {
      'rapidapi-key': ApiConstants.RapidApiKey,
      'namePrefix': name,
      'limit':limit.toString(),
      'languageCode':lang,
    };
    Uri request = Uri.https(ApiConstants.RapidEndPoint, ApiConstants.RapidEndPointCity, queryParameters);
    final response = await http.get(request);
    if(response.statusCode == 200){
      return CitiesGeoList.getLists(jsonDecode(response.body));
    }
    else{
      return [];
    }
  }
  catch(e){
    print(e);
    return [];
  }



}

}