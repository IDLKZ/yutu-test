import 'package:findout/app/helpers/kcolors.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {

  late String? Function(String?) func;
  late TextEditingController controller;
  late bool obscure;
  late String hint;
  late Icon icon;

  InputWidget({required Icon icon, required String hint, required TextEditingController controller, required bool obscure, required String? Function(String?) func});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: func,
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: const TextStyle(fontSize: 20, color: Colors.black),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.transparent, width: 3),
                borderRadius: BorderRadius.circular(20)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(20)
            ),
            filled: true,
            fillColor: KColors.kLightGray,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconTheme(
                data: const IconThemeData(color: KColors.kMiddleBlue),
                child: icon,
              ),
            )
        ),
      ),
    );
  }
}
