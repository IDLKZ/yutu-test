import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../controllers/image_controller.dart';
import '../../../helpers/global_mixin.dart';
import '../../../helpers/kcolors.dart';
import '../../../helpers/validator_mixins.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/advanced_input.dart';
import '../../../widgets/datepicker_widget.dart';
import '../../../widgets/select_picker.dart';
import '../controllers/post_edit_controller.dart';

class PostEditView extends GetView<PostEditController> {
  ImageController _imageController = Get.put<ImageController>(ImageController());

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
                    : "http://via.placeholder.com/350x150",)
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
    return GetX<PostEditController>(builder: (controller) {
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
                  hintText: "categories".tr,
                  labelText:"select_category".tr,
                  listItem:controller.items.value
              ),

            ),
            //Category

            //Title
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvancedInput(
                icon:Icon(Icons.title),
                hint:"title".tr,
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
                  hint:"description".tr,
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
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: controller.cityController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: const TextStyle(fontSize: 20, color: Colors.black),
                    hintText: 'city'.tr,
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
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    filled: true,
                    fillColor: KColors.kLightGray,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconTheme(
                        data: const IconThemeData(color: KColors.kMiddleBlue),
                        child: Icon(FontAwesomeIcons.globe),
                      ),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return await GlobalMixin.getSuggestions(pattern);
                },
                itemBuilder: (context, Map<String, String> suggestion) {
                  return ListTile(
                    title: Text(suggestion['name']!),
                  );
                },
                onSuggestionSelected: (Map<String, String> suggestion) {
                  controller.cityController.text = suggestion['name'] as String;
                },

              ),

            ),
            //Place

            //Location
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvancedInput(
                icon:Icon(Icons.location_on),
                hint:"location".tr,
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
                hint: "date".tr,
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
                  hint:"persons".tr,
                  controller:controller.personController,
                  obscure:false,
                  keyboard:TextInputType.number,
                  func:(val) => ValidatorMixin().validateText(val, true,
                      maxLength: 255, isInt: true, minInt: 1, maxInt: 10)),
            ),
            //Count of person

            _button("update".tr, () => controller.onUpdate()),
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
    return Scaffold(
        body: _columnShow(context)
    );
  }

}
