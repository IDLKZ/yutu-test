import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/widgets/input_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {

  const ChangeProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _header(String imageUrl) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height*0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/profile_bg.png'),
                    fit: BoxFit.cover
                )
            ),
            child: Container(
                height: MediaQuery.of(context).size.height*0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0)
                  ),
                  color: Colors.white,
                )
            ),
          ),
          CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(imageUrl),
            backgroundColor: Colors.transparent,
          ),
          Positioned(
            right: 30,
            bottom: MediaQuery.of(context).size.height*0.07,
            child: GestureDetector(
                onTap: (){},
                child: DropdownButton<String>(
                  value: 'ru',
                  icon: const Icon(Icons.language, color: Colors.black,),
                  iconSize: 24,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: KColors.kMiddleBlue,
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? newValue) async {
                    String newLang = newValue ?? "ru";

                    await GlobalMixin.setShared("langLocale", newLang);
                  },
                  items: ChangeProfileController.languagesApp.map((value) {
                    return DropdownMenuItem<String>(
                      value: value["code"],
                      child: Text(value["title"] ?? "Рус"),
                    );
                  }).toList(),
                )
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

    Widget _form(String label, Function() func) {
      return Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: InputWidget(
                  const Icon(Icons.account_circle),
                  'Name',
                  controller.nameController,
                  false,
                  TextInputType.text,
                  (val){return ValidatorMixin().validateText(val, true,maxLength: 255);},
                  true
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InputWidget(
                  const Icon(Icons.account_circle),
                  'Surname',
                  controller.surnameController,
                  false,
                  TextInputType.text,
                  (val){return ValidatorMixin().validateText(val, true,maxLength: 255);},
                  true
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InputWidget(
                  const Icon(Icons.ac_unit),
                  'Age',
                  controller.ageController,
                  false,
                  TextInputType.number,
                  (val){return ValidatorMixin().validateText(val, true,isInt: true);},
                  true
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InputWidget(
                  const Icon(Icons.share_location),
                  'City',
                  controller.cityController,
                  false,
                  TextInputType.text,
                  (val){return ValidatorMixin().validateText(val, true,maxLength: 255);},
                  true
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InputWidget(
                  const Icon(Icons.email),
                  'Email',
                  controller.emailController,
                  false,
                  TextInputType.emailAddress,
                  (val){return ValidatorMixin().validateText(val, true,email: true,maxLength: 255);},
                  false
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InputWidget(
                  const Icon(Icons.lock),
                  'Password',
                  controller.passwordController,
                  true,
                  TextInputType.visiblePassword,
                  (val){return ValidatorMixin().validateText(val, true,minLenght: 6,maxLength: 255);},
                  true
              ),
            ),
            const SizedBox(height: 20,),
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
      if (controller.formKey.currentState!.validate()) {

      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header('assets/images/ava.png'),
            _form('Change', () => null)
          ],
        ),
      ),
    );
  }
}

