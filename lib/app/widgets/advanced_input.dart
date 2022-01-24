import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/kcolors.dart';

class AdvancedInput extends StatelessWidget {

  late Icon icon;
  late String? hint;
  late TextEditingController? controller;
  late bool obscure = false;
  late String? Function(String?)? func;
  TextInputType? keyboard;
  int? maxLines;
  int? maxLength;
  Function(String)? onChanged;
  bool? isEnabled;
  String? initialVal;
  TextStyle? textStyle;

  AdvancedInput({
    required this.icon,
    required this.hint,
    required this.controller,
    required this.obscure,
    required this.func,
    this.keyboard,
    this.maxLines,
    this.maxLength,
    this.onChanged,
    this.isEnabled,
    this.initialVal,
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        validator: func,
        controller: controller,
        keyboardType: keyboard,
        obscureText: obscure,
        maxLines: maxLines,
        maxLength: maxLength,
        style: textStyle,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: const TextStyle(fontSize: 20, color: Colors.black),
            hintText: hint,
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
                child: icon,
              ),
            )),
      ),
    );
  }
}
