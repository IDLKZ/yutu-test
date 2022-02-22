import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../helpers/kcolors.dart';

class AdvancedInput extends StatelessWidget {

  late Widget icon;
  late String? hint;
  late TextEditingController? controller;
  late String? Function(String?)? func;
  bool obscure;
  TextInputType? keyboard;
  int? maxLines;
  int? maxLength;
  Function(String)? onChanged;
  bool? isEnabled;
  String? initialVal;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  Widget suffixIcon;
  FocusNode? focusNode;
  List<TextInputFormatter>? inputFormatter;
  bool phone;
  bool underline;
  Widget? prependIcon;
  var phoneInput = <TextInputFormatter>[new MaskTextInputFormatter(
  mask: '+###########',
  filter: {"#": RegExp(r"^\+?77([0124567][0-8]\d{7})$")},
  type: MaskAutoCompletionType.lazy)];

  AdvancedInput({
    required this.icon,
    required this.hint,
    required this.controller,
    required this.func,
    this.obscure = false,
    this.keyboard,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.isEnabled,
    this.initialVal,
    this.textStyle,
    this.hintStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.suffixIcon = const SizedBox(),
    this.focusNode,
    this.inputFormatter,
    this.phone = false,
    this.underline = false,
    this.prependIcon = null
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
        maxLines: obscure ? 1 : maxLines,
        maxLength: maxLength,
        style: textStyle,
        autocorrect: false,
        focusNode: focusNode,
        inputFormatters: phone ? phoneInput : null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: hintStyle,
            hintText: hint,
            focusedBorder:underline
                ? UnderlineInputBorder()
                :OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 3),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder:underline
            ? UnderlineInputBorder()
            : OutlineInputBorder(
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
            ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconTheme(
              data: const IconThemeData(color: KColors.kMiddleBlue),
              child: suffixIcon,
            ),
          ),
          icon: prependIcon
        ),
      ),
    );
  }
}
