import 'dart:ffi';

import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/widgets/cityselector_widget.dart';
import 'package:findout/app/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../controllers/image_controller.dart';
import '../../../widgets/datepicker_widget.dart';
import '../../../widgets/select_picker.dart';
import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  ImageController _imageController = Get.put<ImageController>(ImageController());


  @override
  Widget build(BuildContext context) {

    Widget _showDialog(BuildContext context) {
      return AlertDialog(
        title: Text("upload_image".tr),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                onTap: () {
                  _imageController.pickImage(ImageSource.camera,delete: false);
                  Get.back();
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.camera_alt_rounded),
                    title: Text("take_photo".tr),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _imageController.pickImage(ImageSource.gallery,delete: false);
                  Get.back();
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.photo),
                    title: Text("upload_gallery".tr),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("cancel".tr))
        ],
      );
    }


    Widget _header(String imageUrl) {
      return GetX<ImageController>(
        builder: (imageController){
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height*0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/profile_bg.png"
                        ),
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
              !_imageController.imageUploaded.value
                  ? CircleAvatar(
                radius: 100,
                backgroundImage:imageController.selectedImageUrl.value.isNotEmpty
                  ?GlobalMixin.getImage(imageController.selectedImageUrl.value)
                  :GlobalMixin.getImage(controller.user.user?.imageUrl ),
                backgroundColor: Colors.transparent,
              )
              :
                  CircleAvatar(
                    radius: 100,
                    child: CircularProgressIndicator(),
                    backgroundColor: Colors.white,
                  )
              ,
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
              ),
              Positioned(
                bottom: 10,
                child:  IconButton(
                  icon: Icon(FontAwesomeIcons.camera,color: Colors.white,),
                  onPressed: (){
                    showDialog(context: context, builder: (c) => _showDialog(context));
                  },
                ),
              )
            ],
          );
        },
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
                  'name'.tr,
                  controller.nameController,
                  false,
                  TextInputType.text,
                  (val){return ValidatorMixin().validateText(val, true,maxLength: 255);},
                  false
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InputWidget(
                  const Icon(Icons.account_circle),
                  'surname'.tr,
                  controller.surnameController,
                  false,
                  TextInputType.text,
                  (val){return ValidatorMixin().validateText(val, true,maxLength: 255);},
                  false
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20,right: 10,left: 10),
              child:DatePickerWidget(
                controller: controller.ageController,
                icon: Icon(FontAwesomeIcons.calendarCheck),
                hint: "birthday".tr,
                func: (val) { ValidatorMixin().validateDate(val, true); },
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime(DateTime.now().year - 18),
                initialDate: GlobalMixin.getBirthDate(controller.ageController.text),
                format:DateFormat("dd.MM.yyyy"),
                time: false,
              )
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 20,right: 25,left: 25),
                child: CitySelectorWidget(cityController: controller.cityController,cityIdController: controller.cityIdController,),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InputWidget(
                  const Icon(Icons.email),
                  'email'.tr,
                  controller.emailController,
                  false,
                  TextInputType.emailAddress,
                  (val){return ValidatorMixin().validateText(val, true,email: true,maxLength: 255);},
                  true
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InputWidget(
                  const Icon(Icons.lock),
                  'password'.tr,
                  controller.passwordController,
                  true,
                  TextInputType.visiblePassword,
                  (val){
                    if(val != null){
                      if(val.length > 0){
                        if(val.length < 4){
                          return "cat_less".tr + " 4";
                        }
                      }
                    }
                  },
                  false
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
            _header('assets/images/ava.png'),
            _form('update'.tr, () => controller.updateUser())
          ],
        ),
      ),
    );
  }
}

