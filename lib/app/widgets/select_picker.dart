import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';

import '../helpers/kcolors.dart';

class SelectPicker extends StatelessWidget {

  late Icon icon;
  late TextEditingController controller;
  late String? Function(String?)? func;
  late String labelText;
  late String hintText;
  late List<Map<String, dynamic>>? listItem;
  void Function(String)? onChanged;
  void Function(String)? onSaved;

  SelectPicker({
      required this.icon,
      required this.controller,
      required this.func,
      required this.labelText,
      required this.hintText,
      required this.listItem,
      this.onChanged,
      this.onSaved
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 15),
      child: SelectFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: const TextStyle(fontSize: 20, color: Colors.black),
            hintText: hintText,
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
            filled: true,
            fillColor: KColors.kLightGray,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconTheme(
                data: const IconThemeData(color: KColors.kMiddleBlue),
                child: Icon(FontAwesomeIcons.boxes),
              ),
            )),
        controller: controller,
        validator: func,
        icon: Icon(Icons.format_shapes),
        labelText: labelText,
        style: TextStyle(fontSize: 18),
        items: listItem,
        onChanged: (val) => null,
        onSaved: (val) => null,
      ),
    );

  }
}
