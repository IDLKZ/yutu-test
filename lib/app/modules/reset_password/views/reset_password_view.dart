import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:findout/app/widgets/advanced_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {

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
            child: Text(
              'reset'.tr,
              style: TextStyle(fontSize: 36,
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
      if (controller.resetFormKey.currentState!.validate()) {
        return controller.authController.resetPassword(controller.emailController.text.trim());
      }
    }

    Widget _form(String label, Function() func) {
      return Form(
        key: controller.resetFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: AdvancedInput(
                  controller: controller.emailController,
                  hint: "email".tr,
                  icon:Icon(FontAwesomeIcons.envelope),
                  func: (val){return ValidatorMixin().validateText(val, true,email: true,maxLength: 255);},
                )
            ),

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
            _form('reset_btn'.tr, _buttonAction),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('login'.tr, style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KColors.kDarkViolet),),
            ),
          ],
        ),
      ),
    );
  }
}
