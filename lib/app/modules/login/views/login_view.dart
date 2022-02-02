import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:findout/app/widgets/advanced_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {


  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
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

    _buttonAction() {
      if (loginFormKey.currentState!.validate()) {
        return controller.authController.login(controller.emailController.text.trim(), controller.passwordController.text.trim());
      }
    }

    Widget _form(String label, Function() func) {
      return Form(
        key: loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: AdvancedInput(
                controller: controller.emailController,
                hint: "Email",
                icon:Icon(FontAwesomeIcons.envelope),
                func: (val){return ValidatorMixin().validateText(val, true,email: true,maxLength: 255);},
              )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AdvancedInput(
                controller: controller.passwordController,
                hint:"Пароль",
                icon:Icon(FontAwesomeIcons.lock),
                func: (val){return ValidatorMixin().validateText(val, true,minLenght: 4,maxLength: 255);},
                obscure: true,
              )
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


    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            _welcome(),
            _form('Login', _buttonAction),
            const SizedBox(height: 30,),
            GestureDetector(
                onTap: () => Get.to(() => Routes.REGISTER),
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
