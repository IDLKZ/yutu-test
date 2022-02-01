import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:findout/app/widgets/advanced_input.dart';
import 'package:findout/app/widgets/datepicker_widget.dart';
import 'package:findout/app/widgets/select_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {

    Widget _welcome(){
      return Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.35,
            // width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/ellipse.png'),
                    fit: BoxFit.fill
                )
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top:120, left: 20),
            child: const Text(
              'Регистрация',
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: KColors.kDarkViolet),
            ),
          )
        ],
      );
    }


    Widget _button(String text, void Function() func){
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
          backgroundColor: MaterialStateProperty.all<Color>(KColors.kMiddleBlue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              )),

        ),
      );
    }

    Widget _form(String label, void Function() func){
      return Form(
        key: controller.registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    child: AdvancedInput(
                      controller: controller.nameController,
                      hint: "Имя",
                      icon: Icon(FontAwesomeIcons.userCircle),
                      obscure: false,
                      func: (String? val ) {return ValidatorMixin().validateText(val, true,maxLength: 255,minLenght: 1); },
                      hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                    )
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: AdvancedInput(
                      controller: controller.surnameController,
                      hint: "Фамилия",
                      icon: Icon(FontAwesomeIcons.userCircle),
                      obscure: false,
                      func: (String? val ) {return ValidatorMixin().validateText(val, true,maxLength: 255,minLenght: 1); },
                      hintStyle: TextStyle(fontSize: 12, color: Colors.black),

                    )
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: DatePickerWidget(
                controller: controller.ageController,
                icon: Icon(FontAwesomeIcons.calendarCheck),
                hint: "Дата рождения (+18 лет)",
                func: (val) {return ValidatorMixin().validateDate(val, true); },
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime(DateTime.now().year - 18),
                initialDate: DateTime(DateTime.now().year - 18),
                format:DateFormat("dd.MM.yyyy"),
                time: false,
              )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AdvancedInput(
                controller: controller.emailController,
                hint: "Email",
                icon: Icon(FontAwesomeIcons.envelope),
                obscure: false,
                func: (String? val ) {return ValidatorMixin().validateText(val, true,email: true); },
                keyboard:TextInputType.emailAddress
              )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AdvancedInput(
                controller: controller.passwordController,
                hint: "Пароль",
                icon: Icon(FontAwesomeIcons.lock),
                obscure: true,
                func: (String? val ) {return ValidatorMixin().validateText(val, true,minLenght: 4, maxLength: 255); },
                keyboard:TextInputType.emailAddress
              )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
                child: AdvancedInput(
                    controller: controller.phoneController,
                    hint: "Телефон",
                    icon: Icon(FontAwesomeIcons.phone),
                    obscure: false,
                    func: (String? val ) {return ValidatorMixin().validateText(val, true,phone: true); },
                )
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SelectPicker(
                  controller: controller.cityController,
                  hintText: "Ваш город",
                  func: (val){return ValidatorMixin().validateText(val, true);},
                  icon:Icon(FontAwesomeIcons.globe),
                  labelText: "Ваш город",
                  listItem: GlobalMixin.getListCities(),
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _welcome(),
              _form('Register', controller.authenticateUser),
              const SizedBox(height: 30,),
              GestureDetector(
                  onTap: (){
                    Get.offNamed(Routes.LOGIN);
                  },
                  child: const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: KColors.kDarkViolet),)),
            ],
          ),
        )
    );
  }
}
