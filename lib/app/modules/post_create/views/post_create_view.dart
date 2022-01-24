import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:findout/app/controllers/image_controller.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:findout/app/widgets/advanced_input.dart';
import 'package:findout/app/widgets/select_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../helpers/kcolors.dart';
import '../../../widgets/datepicker_widget.dart';
import '../controllers/post_create_controller.dart';
import 'dart:io';

class PostCreateView extends GetView<PostCreateController> {
  ImageController _imageController =
      Get.put<ImageController>(ImageController());

  Widget _showDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Загрузите изображение"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            GestureDetector(
              onTap: () {
                _imageController.pickImage(ImageSource.camera);
                Get.back();
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.camera_alt_rounded),
                  title: Text("Сделать фото"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _imageController.pickImage(ImageSource.gallery);
                Get.back();
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Загрузить с галереи"),
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
            child: Text("Отмена"))
      ],
    );
  }

  Widget _imageContainer(
      BuildContext context, ImageController _imageController) {
    return GestureDetector(
      onTap: () {
        !_imageController.imageUploaded.value
            ? showDialog(context: context, builder: (c) => _showDialog(context))
            : null;
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0)),
            image: DecorationImage(
                image: _imageController.imageUploaded.value == false
                    ? NetworkImage(_imageController
                            .selectedImageUrl.value.isNotEmpty
                        ? _imageController.selectedImageUrl.value
                        : 'https://enviragallery.com/wp-content/uploads/2016/06/How-to-Optimize-Your-Images-for-the-Web-Step-by-Step.png')
                    : NetworkImage("https://i.stack.imgur.com/PLbzc.gif"),
                fit: BoxFit.cover)),
      ),
    );
  }

  Widget _columnShow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: GetX<ImageController>(builder: (_imageController) {
              return Stack(
                children: [
                  _imageContainer(context, _imageController),
                  Positioned(
                    top: 50,
                    left: 30,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: KColors.kLightGray,
                          borderRadius: BorderRadius.circular(8)),
                      child: GestureDetector(
                        child: Icon(FontAwesomeIcons.chevronLeft),
                        onTap: () {
                          Get.offAllNamed(Routes.HOME);
                        },
                      ),
                    ),
                  ),
                  _imageController.selectedImageUrl.value.isNotEmpty
                      ? Positioned(
                          top: 50,
                          right: 30,
                          child: GestureDetector(
                            onTap: () {
                              _imageController.deleteFile(
                                  _imageController.selectedImageUrl.value);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: KColors.kLightGray,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(Icons.clear),
                            ),
                          ),
                        )
                      : SizedBox(),
                  !_imageController.imageUploaded.value
                      ? Positioned(
                          right: 20,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (c) => _showDialog(context));
                            },
                            child: const CircleAvatar(
                              backgroundColor: KColors.kDarkenGray,
                              radius: 25,
                              child: Icon(
                                FontAwesomeIcons.image,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              );
            })),
        const SizedBox(
          height: 10,
        ),
        _form()
      ],
    );
  }

  Widget _select() {
    return SelectPicker(icon: Icon(FontAwesomeIcons.sourcetree), controller: controller.categoryController, func: (val)=>ValidatorMixin().validateText(val,true), labelText: "Категория", hintText: 'Выберите категорию', listItem: controller.items.value);
  }

  Widget _datepicker() {
      return DatePickerWidget(
        controller: controller.dateController,
        func: (val)=>ValidatorMixin().validateDate(val, true),
        hint: "Выберите время",
        icon:Icon(FontAwesomeIcons.clock),
      );
  }

  Widget _button(String text, Function() func) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed: func,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.arrow_forward)
          ],
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(KColors.kMiddleBlue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          )),
        ),
      ),
    );
  }

  Widget _form() {
    return GetX<PostCreateController>(builder: (controller) {
      return Expanded(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                _select(),
                SizedBox(
                  height: 20,
                ),
                AdvancedInput(
                  icon:Icon(Icons.title),
                  hint:"Наименование",
                  controller:controller.titleController,
                  obscure:false,
                  func:(val) =>
                      ValidatorMixin().validateText(val, true, maxLength: 100),
                  keyboard:TextInputType.text,
                  maxLength: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                AdvancedInput(
                    icon:Icon(Icons.message),
                    hint:"Описание",
                    controller:controller.descriptionController,
                    obscure:false,
                    func:(val) => ValidatorMixin()
                        .validateText(val, true, maxLength: 1000),
                    keyboard:TextInputType.text,
                    maxLines: 4,
                  maxLength: 1000
                ),
                SizedBox(
                  height: 20,
                ),
                AdvancedInput(
                  icon:Icon(Icons.location_on),
                  hint:"Локация",
                  controller:controller.placeController,
                  obscure:false,
                  keyboard:TextInputType.text,
                  func:(val) =>
                      ValidatorMixin().validateText(val, true, maxLength: 255),
                ),
                SizedBox(
                  height: 20,
                ),
                _datepicker(),
                SizedBox(
                  height: 20,
                ),
                AdvancedInput(
                    icon:Icon(FontAwesomeIcons.users),
                    hint:"Кол-во людей",
                    controller:controller.personController,
                    obscure:false,
                    keyboard:TextInputType.number,
                    func:(val) => ValidatorMixin().validateText(val, true,
                        maxLength: 255, isInt: true, minInt: 1, maxInt: 10)),
                SizedBox(
                  height: 20,
                ),
                _button("Сохранить", () => controller.onSave()),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _columnShow(context));
  }
}
