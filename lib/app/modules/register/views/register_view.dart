import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:findout/app/widgets/advanced_input.dart';
import 'package:findout/app/widgets/cityselector_widget.dart';
import 'package:findout/app/widgets/datepicker_widget.dart';
import 'package:findout/app/widgets/select_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:get/get.dart';

import '../../../data/providers/geocities_provider.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

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
            child:  Text(
              'registration'.tr,
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: KColors.kDarkViolet),
            ),
          ),
          Positioned(
            right: 20,
            top: 50,
            bottom: MediaQuery.of(context).size.height*0.07,
            child: GestureDetector(
                onTap: (){},
                child: DropdownButton<String>(
                  value: Get.locale!.languageCode,
                  icon: const Icon(Icons.language, color: Colors.black,),
                  iconSize: 24,
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: KColors.kMiddleBlue,
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? newValue) async {
                    String newLang = newValue ?? "ru";

                    await GlobalMixin.setShared("langLocale", newLang);
                  },
                  items: RegisterController.languagesApp.map((value) {
                    return DropdownMenuItem<String>(
                      value: value["code"],
                      child: Text(value["title"] ?? "Рус"),
                    );
                  }).toList(),
                )
            ),
          ),
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
        key: registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: AdvancedInput(
                controller: controller.nameController,
                hint: "name".tr,
                icon: Icon(FontAwesomeIcons.userCircle),
                obscure: false,
                func: (String? val ) {return ValidatorMixin().validateText(val, true,maxLength: 255,minLenght: 1); },
              )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AdvancedInput(
                controller: controller.surnameController,
                hint: "surname".tr,
                icon: Icon(FontAwesomeIcons.userCircle),
                obscure: false,
                func: (String? val ) {return ValidatorMixin().validateText(val, true,maxLength: 255,minLenght: 1); },

              )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: DatePickerWidget(
                controller: controller.ageController,
                icon: Icon(FontAwesomeIcons.calendarCheck),
                hint: "birthday".tr,
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
                hint: "email".tr,
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
                hint: "password".tr,
                icon: Icon(FontAwesomeIcons.lock),
                obscure: true,
                func: (String? val ) {return ValidatorMixin().validateText(val, true,minLenght: 4, maxLength: 255); },
                keyboard:TextInputType.emailAddress
              )
            ),


            Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
              child: CitySelectorWidget(cityController: controller.cityController,cityIdController: controller.cityIdController,),
            ),
            GetX<RegisterController>(
                builder: (controller){
                  return  Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20, vertical: 20),
                      child: Row(
                        children: [
                          Expanded(child: GestureDetector(
                            child: Text("i_accept_pt".tr,style: TextStyle(color: KColors.kMiddleBlue),),
                            onTap: (){
                                Get.toNamed(Routes.PRIVACY_TERM);
                            },
                          )),
                          Checkbox(
                            onChanged: (bool? value) {
                              controller.agreed.value = value != null ? value : false;
                            },
                            value: controller.agreed.value,
                            checkColor: KColors.kLightBlue,
                          ),
                        ],
                      )
                  );
                }

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

    _buttonAction() {
      if(registerFormKey.currentState!.validate()){
        if(controller.agreed.value == true){
          return controller.authController.register(
            controller.emailController.text.trim(),
            controller.passwordController.text.trim(),
            controller.nameController.text.trim(),
            controller.surnameController.text.trim(),
            controller.ageController.text.trim(),
            controller.cityController.text.trim(),
            controller.cityIdController.text.trim(),
          );
        }
        else{
          GlobalMixin.warningSnackBar('Hangout', 'privacy_agree'.tr);

        }

      }
    }
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _welcome(),
              _form('register'.tr, _buttonAction),
              SafeArea(
                child: GestureDetector(
                    onTap: (){
                      Get.offNamed(Routes.LOGIN);
                    },
                    child: Text('login'.tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: KColors.kDarkViolet),)),
              ),
              SizedBox(height: 20,)
            ],
          ),
        )
    );
  }
}
