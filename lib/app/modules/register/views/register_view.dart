import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    _buttonAction() {
      if(_formKey.currentState!.validate()){
        return authController.register(
            controller.emailController.text.trim(),
            controller.passwordController.text.trim(),
            controller.nameController.text.trim(),
            controller.surnameController.text.trim(),
            int.parse(controller.ageController.text.trim()),
            controller.cityController.text.trim()
        );
      }
    }

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

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure, TextInputType keyboard, String? Function(String?) func){
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          validator: func,
          controller: controller,
          keyboardType: keyboard,
          obscureText: obscure,
          style: const TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: const TextStyle(fontSize: 20, color: Colors.black),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent, width: 3),
                  borderRadius: BorderRadius.circular(20)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(20)
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1),
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
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    child: _input(
                        const Icon(Icons.account_circle),
                        'Name',
                        controller.nameController,
                        false,
                        TextInputType.text,
                            (val){return ValidatorMixin().validateText(val, true,maxLength: 255);}
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _input(
                        const Icon(Icons.account_circle),
                        'Surname',
                        controller.surnameController,
                        false,
                        TextInputType.text,
                            (val){return ValidatorMixin().validateText(val, true,maxLength: 255);}
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _input(
                  const Icon(Icons.ac_unit),
                  'Age',
                  controller.ageController,
                  false,
                  TextInputType.number,
                      (val){return ValidatorMixin().validateText(val, true,isInt: true);}
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _input(
                  const Icon(Icons.share_location),
                  'City',
                  controller.cityController,
                  false,
                  TextInputType.text,
                      (val){return ValidatorMixin().validateText(val, true,maxLength: 255);}
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _input(
                  const Icon(Icons.email),
                  'Email',
                  controller.emailController,
                  false,
                  TextInputType.emailAddress,
                      (val){return ValidatorMixin().validateText(val, true,email: true,maxLength: 255);}
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _input(
                  const Icon(Icons.lock),
                  'Password',
                  controller.passwordController,
                  true,
                  TextInputType.visiblePassword,
                      (val){return ValidatorMixin().validateText(val, true,minLenght: 6,maxLength: 255);}
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

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _welcome(),
              _form('Register', _buttonAction),
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
