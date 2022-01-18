import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/modules/admin/categories/controllers/categories_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddCategoryView extends GetView<CategoriesController> {


  @override
  Widget build(BuildContext context) {

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure, String? Function(String?) func) {
      return Container(
        child: TextFormField(
          validator: func,
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: const TextStyle(fontSize: 20, color: Colors.white),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(20)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)
              ),
              filled: true,
              fillColor: KColors.kAdminBgColor,
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
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _input(Icon(Icons.book), 'Наименование на русском', controller.titleRu, false, (val) {
                return ValidatorMixin().validateText(
                    val, true,maxLength: 255);
              }),
              SizedBox(height: 10,),
              _input(Icon(Icons.book), 'Наименование на eng', controller.titleEn, false, (val) {
                return ValidatorMixin().validateText(
                    val, true,maxLength: 255);
              }),
              SizedBox(height: 10,),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: _button(label, func),
                  )
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: KColors.kAdminBgColor,
      appBar: AppBar(
        backgroundColor: KColors.kAdminBgColor,
        title: Text('Создать категорию'),
        actions: [
          IconButton(
              onPressed: () => Get.find<AuthController>().logout(),
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: _form('Добавить', () => controller.createCategory()),
    );
  }
}
