import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../controllers/image_controller.dart';
import '../../../helpers/kcolors.dart';
import '../../../helpers/validator_mixins.dart';
import '../../../routes/app_pages.dart';
import '../controllers/post_edit_controller.dart';

class PostEditView extends GetView<PostEditController> {

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
        Expanded(
            child: _form())

      ],
    );
  }

  Widget _input(Icon icon, String hint, TextEditingController controller,
      bool obscure, TextInputType keyboard, String? Function(String?) func,
      {int maxLines = 1, int? maxLength}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        validator: func,
        controller: controller,
        keyboardType: keyboard,
        obscureText: obscure,
        maxLines: maxLines,
        maxLength: maxLength,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: const TextStyle(fontSize: 20, color: Colors.black),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 3),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(20)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(20)),
            filled: true,
            fillColor: KColors.kLightGray,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconTheme(
                data: const IconThemeData(color: KColors.kMiddleBlue),
                child: icon,
              ),
            )),
      ),
    );
  }

  Widget _select() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SelectFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: const TextStyle(fontSize: 20, color: Colors.black),
            hintText: "Выберите категорию",
            focusedBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 3),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(20)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(20)),
            filled: true,
            fillColor: KColors.kLightGray,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconTheme(
                data: const IconThemeData(color: KColors.kMiddleBlue),
                child: Icon(FontAwesomeIcons.boxes),
              ),
            )),
        controller: controller.categoryController,
        validator: (val) => ValidatorMixin().validateText(val, true),
        icon: Icon(Icons.format_shapes),
        labelText: 'Категория',
        style: TextStyle(fontSize: 18),
        items: controller.items.value,
        onChanged: (val) => null,
        onSaved: (val) => null,
      ),
    );
  }

  Widget _datepicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DateTimeField(
        format: DateFormat("dd.MM.yyyy HH:mm"),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: const TextStyle(fontSize: 20, color: Colors.black),
            hintText: "Выберите время",
            focusedBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 3),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(20)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(20)),
            filled: true,
            fillColor: KColors.kLightGray,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconTheme(
                data: const IconThemeData(color: KColors.kMiddleBlue),
                child: Icon(FontAwesomeIcons.calendarCheck),
              ),
            )),
        controller: controller.dateController,
        validator: (val) => ValidatorMixin().validateDate(val, true),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: controller.post.value?.date??DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 30)));
          if (date != null) {
            final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (context, childWidget) {
                  return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: childWidget!);
                });
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
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
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            _select(),
            SizedBox(
              height: 20,
            ),
            _input(
              Icon(Icons.title),
              "Наименование",
              controller.titleController,
              false,
              TextInputType.text,
                  (val) =>
                  ValidatorMixin().validateText(val, true, maxLength: 100),
              maxLength: 100,
            ),
            SizedBox(
              height: 20,
            ),
            _input(
                Icon(Icons.message),
                "Описание",
                controller.descriptionController,
                false,
                TextInputType.text,
                    (val) => ValidatorMixin()
                    .validateText(val, true, maxLength: 1000),
                maxLines: 4,
                maxLength: 1000
            ),
            SizedBox(
              height: 20,
            ),
            _input(
              Icon(Icons.location_on),
              "Локация",
              controller.placeController,
              false,
              TextInputType.text,
                  (val) =>
                  ValidatorMixin().validateText(val, true, maxLength: 255),
            ),
            SizedBox(
              height: 20,
            ),
            _datepicker(),
            SizedBox(
              height: 20,
            ),
            _input(
                Icon(FontAwesomeIcons.users),
                "Кол-во людей",
                controller.personController,
                false,
                TextInputType.number,
                    (val) => ValidatorMixin().validateText(val, true,
                    maxLength: 255, isInt: true, minInt: 1, maxInt: 10)),
            SizedBox(
              height: 20,
            ),
            _button("Обновить", () => controller.onUpdate()),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _columnShow(context)
    );
  }

}
