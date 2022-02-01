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

import '../../../helpers/kcolors.dart';
import '../../../widgets/datepicker_widget.dart';
import '../controllers/post_create_controller.dart';

class PostCreateView extends GetView<PostCreateController> {
  ImageController _imageController = Get.put<ImageController>(ImageController());

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

  Widget _imageContainer(BuildContext context, ImageController _imageController) {
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
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: Get.height * 0.4,
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
        ),
      ],
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
      return Form(
        key: controller.formKey,
        child: Column(
          children: [
            //Category
            Padding(
                padding:EdgeInsets.all(10),
                child: SelectPicker(
                  controller: controller.categoryController,
                  func: (val){return ValidatorMixin().validateText(val, true);},
                  icon: Icon(FontAwesomeIcons.boxes),
                  hintText: "Категория",
                  labelText:"Выберите категорию",
                  listItem:controller.items.value
                ),

            ),
            //Category

            //Title
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvancedInput(
                icon:Icon(Icons.title),
                hint:"Наименование",
                controller:controller.titleController,
                obscure:false,
                func:(val) =>
                    ValidatorMixin().validateText(val, true, maxLength: 100),
                keyboard:TextInputType.text,
                maxLength: 100,
              ),
            ),
            //Title

            //Description
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvancedInput(
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
            ),
            //Description

            //Place
            Padding(
              padding:EdgeInsets.all(10),
              child: SelectPicker(
                  controller: controller.cityController,
                  func: (val){return ValidatorMixin().validateText(val, true);},
                  icon: Icon(FontAwesomeIcons.globe),
                  hintText: "Место действия",
                  labelText:"Выберите город/область",
                  listItem:GlobalMixin.getListCities(),
              ),

            ),
            //Place

            //Location
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvancedInput(
                icon:Icon(Icons.location_on),
                hint:"Локация",
                controller:controller.placeController,
                obscure:false,
                keyboard:TextInputType.text,
                func:(val) =>
                    ValidatorMixin().validateText(val, true, maxLength: 255),
              ),
            ),
            //Location


            Padding(
                padding:EdgeInsets.all(10),
              child: DatePickerWidget(
                hint: "Дата события",
                controller: controller.dateController,
                func: (val){
                  return ValidatorMixin().validateDate(val, true);
                },
                icon:Icon(FontAwesomeIcons.calendarCheck),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 14)),
              ),
            ),

            //Count of person
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvancedInput(
                  icon:Icon(FontAwesomeIcons.users),
                  hint:"Кол-во людей",
                  controller:controller.personController,
                  obscure:false,
                  keyboard:TextInputType.number,
                  func:(val) => ValidatorMixin().validateText(val, true,
                      maxLength: 255, isInt: true, minInt: 1, maxInt: 10)),
            ),
            //Count of person

            _button("Сохранить", () => controller.onSave()),
            SizedBox(
              height: 20,
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _columnShow(context));
  }
}
