import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Widget _welcome() {
      return Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.45,
            // width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg-login.png'),
                    fit: BoxFit.fill
                )
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 95, left: 20),
            child: const Text(
              'Добро пожаловать',
              style: TextStyle(fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: KColors.kDarkViolet),
            ),
          )
        ],
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure, String? Function(String?) func) {
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

    Widget _button(String text, Function() func) {
      return ElevatedButton(
        onPressed: func,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(width: 10,),
            const Icon(Icons.arrow_forward)
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              KColors.kMiddleBlue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              )),

        ),
      );
    }

    Widget _form(String label, Function() func) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: _input(
                  const Icon(Icons.email), 'Email', controller.emailController, false,
                      (val) {
                    return ValidatorMixin().validateText(
                        val, true, email: true);
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _input(
                  const Icon(Icons.lock), 'Password', controller.passwordController, true,
                      (val) {
                    return ValidatorMixin().validateText(
                        val, true, minLenght: 6);
                  }
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20, right: 25),
              child: Text('Forget password?', style: TextStyle(fontSize: 16),),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: _button(label, func),
              ),
            )
          ],
        ),
      );
    }

    _buttonAction() {
      if (_formKey.currentState!.validate()) {
        return authController.login(controller.emailController.text.trim(), controller.passwordController.text.trim());
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            _welcome(),
            _form('Login', _buttonAction),
            const SizedBox(height: 30,),
            GestureDetector(
                onTap: () => Get.toNamed(Routes.REGISTER),
                child: const Text('Registration', style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KColors.kDarkViolet),)
            ),
          ],
        ),
      ),
    );
  }
}
