import 'package:findout/app/data/providers/posts_provider.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/image_controller.dart';
import '../../../data/models/categories_model.dart';
import '../../../data/models/posts_model.dart';
import '../../../data/providers/categories_provider.dart';
import '../../../helpers/global_mixin.dart';

class PostEditController extends GetxController {
  //TODO: Implement PostCreateController
  Rx<CategoriesList?>categoriesList = Rxn<CategoriesList>();
  //Form
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController cityIdController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController personController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ImageController _imageController = Get.find<ImageController>();

  Rx<List<Map<String, dynamic>>> items = Rx<List<Map<String,dynamic>>>([]);
  String? postUid = Get.arguments;
  Rx<Posts?> post = Rxn<Posts?>();
  @override
  void onInit()async {
    super.onInit();
    post.value = await PostsProvider().getPost(postUid);
    if(post.value == null){
      Get.back();
    }
    _imageController.selectedImageUrl.value = post.value?.image??"";
    categoryController.text = post.value?.category??"";
    titleController.text = post.value?.title??"";
    cityController.text = post.value?.city??"";
    cityIdController.text = post.value?.cityId??"";
    descriptionController.text = post.value?.description??"";
    placeController.text = post.value?.place??"";
    personController.text = post.value?.persons.toString()??"";
    dateController.text = DateFormat("dd.MM.yyyy HH:mm").format(post.value?.date??DateTime.now());
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

  Future<void> onUpdate()async{
    if(formKey.currentState != null){
      if(formKey.currentState!.validate() && dateController.text.isNotEmpty && _imageController.selectedImageUrl.value.isNotEmpty){
        await PostsProvider().updatePost(prepareData(isUpdated:true),postUid);
        formKey.currentState?.reset();
        dateController.text = "";
        _imageController.selectedImageUrl.value = "";
        Get.offAllNamed(Routes.HOME);
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

  Map<String,dynamic> prepareData({bool isUpdated = false}){
    Map <String,dynamic> data = {};
    data["image"] = _imageController.selectedImageUrl.value;
    data["author"] = FirebaseAuth.instance.currentUser?.uid;
    data["category"] = categoryController.text.trim();
    data["title"] = titleController.text.trim();
    data["description"] = descriptionController.text.trim();
    data["city"] = cityController.text.trim();
    data["cityId"] = cityIdController.text.trim();
    data["place"] = placeController.text.trim();
    data["persons"] = int.parse(personController.text.trim());
    data["date"] = GlobalMixin.convertToDateFormatController(dateController)?.millisecondsSinceEpoch;
    isUpdated == true
        ? data["updated_at"] = DateTime.now().millisecondsSinceEpoch
        :data["created_at"] = DateTime.now().millisecondsSinceEpoch;
    data["status"] = 1;
    return data;

  }

  @override
  void onClose() {
    titleController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    cityController.dispose();
    cityIdController.dispose();
    placeController.dispose();
    dateController.dispose();
    personController.dispose();
  }

}
