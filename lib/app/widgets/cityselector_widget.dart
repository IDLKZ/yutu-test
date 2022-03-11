import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../data/models/geocities_model.dart';
import '../data/providers/geocities_provider.dart';
import '../helpers/global_mixin.dart';
import '../helpers/kcolors.dart';

class CitySelectorWidget extends StatelessWidget{
  late TextEditingController cityController;
  late TextEditingController cityIdController;
  CitySelectorWidget({required this.cityController, required this.cityIdController});

  @override
  Widget build(BuildContext context){
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: cityController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: const TextStyle(fontSize: 20, color: Colors.black),
          hintText: 'city'.tr,
          focusedBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: Colors.transparent, width: 3),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(20)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(20)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(20)),
          filled: true,
          fillColor: KColors.kLightGray,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconTheme(
              data: const IconThemeData(color: KColors.kMiddleBlue),
              child: Icon(FontAwesomeIcons.globe),
            ),
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await GeoCitiesProvider().getCitiesLists(pattern);
      },
      itemBuilder: (context,Map<String,String>suggestion) {
        return ListTile(
          title: Text(suggestion['name']??""),
        );
      },
      onSuggestionSelected: (Map<String,String>suggestion) {
        print(suggestion["wikiDataId"]);
        cityController.text = suggestion['name']! as String;
         cityIdController.text = suggestion['wikiDataId']! as String;
      },

    );


  }


}