import 'package:findout/app/controllers/image_controller.dart';
import 'package:findout/app/data/models/categories_model.dart';
import 'package:findout/app/data/providers/categories_provider.dart';
import 'package:findout/app/data/providers/posts_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../helpers/global_mixin.dart';

class PostCreateController extends GetxController {
  //TODO: Implement PostCreateController
  Rx<CategoriesList?>categoriesList = Rxn<CategoriesList>();
  //Form
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController personController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ImageController _imageController = Get.find<ImageController>();

  Rx<List<Map<String, dynamic>>> items = Rx<List<Map<String,dynamic>>>([]);



  @override
  void onInit() {
    super.onInit();
    categoriesList.bindStream(CategoriesProvider().getCategoriesStream());
    ever(categoriesList,_setCategoryList);
  }

  _setCategoryList(CategoriesList? categoriesList){
    if(categoriesList != null){
      if(categoriesList.categoriesList != null){
        categoriesList.categoriesList?.forEach((category){
          items.value.add(
            {
              "value":category.id,
              "label":category.titleRu,
            }
          );
        });
      }
    }
  }


  Future<void> onSave()async{
    if(formKey.currentState != null){
      if(formKey.currentState!.validate() && dateController.text.isNotEmpty && _imageController.selectedImageUrl.value.isNotEmpty){
        await PostsProvider().createPost(prepareData());
        formKey.currentState?.reset();
        dateController.text = "";
        _imageController.selectedImageUrl.value = "";
      }
      else{
        GlobalMixin.warningSnackBar("Упс", "Заполните все поля");
      }
    }



  }



  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    titleController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    placeController.dispose();
    dateController.dispose();
    personController.dispose();
  }


  Map<String,dynamic> prepareData({bool isUpdated = false}){
    Map <String,dynamic> data = {};
    data["image"] = _imageController.selectedImageUrl.value;
    data["author"] = FirebaseAuth.instance.currentUser?.uid;
    data["category"] = categoryController.text.trim();
    data["title"] = titleController.text.trim();
    data["description"] = descriptionController.text.trim();
    data["place"] = placeController.text.trim();
    data["persons"] = int.parse(personController.text.trim());
    data["date"] = GlobalMixin.convertToDateFormatController(dateController)?.millisecondsSinceEpoch;
    isUpdated == true
        ? data["updated_at"] = DateTime.now().millisecondsSinceEpoch
        :data["created_at"] = DateTime.now().millisecondsSinceEpoch;
    data["status"] = 1;
    return data;



  }
}
