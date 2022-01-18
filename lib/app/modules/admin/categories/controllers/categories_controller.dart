import 'package:findout/app/data/models/categories_model.dart';
import 'package:findout/app/data/providers/categories_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../views/edit_view.dart';

class CategoriesController extends GetxController {
  final TextEditingController titleRu = TextEditingController();
  final TextEditingController titleEn = TextEditingController();
  Rx<String?> currentId = "".obs;
  final TextEditingController titleRuEdit = TextEditingController();
  final TextEditingController titleEnEdit = TextEditingController();

  Rx<CategoriesList?> categoriesList = Rxn<CategoriesList>();

  final formKey = GlobalKey<FormState>();

  Map<String,dynamic> prepareDate({bool isUpdate = false}){
    return isUpdate == true
    ?
    {
      "titleRu":titleRuEdit.text.trim(),
      "titleEn":titleEnEdit.text.trim(),
      "status":"1"
    }
     :{
      "titleRu":titleRu.text.trim(),
      "titleEn":titleEn.text.trim(),
      "status":"1"
    };
  }

  Future<void> deleteCategory(String? id)async{
    await CategoriesProvider().deleteCategory(id);
  }

  Future <void> createCategory()async {
    if (formKey.currentState?.validate() == true) {
      if (await CategoriesProvider().createCategory(prepareDate())) {
        formKey.currentState?.reset();
      }
    }
  }


  Future <void> updateCategory()async{
    if (formKey.currentState?.validate() == true) {
      if (await CategoriesProvider().updateCategory(prepareDate(isUpdate: true),currentId.value)) {
      }
    }
    Get.offNamed(Routes.CATEGORIES);

  }


  Future <void> changeCategory(String? id)async {
    formKey.currentState?.reset();
    Category? category = await CategoriesProvider().getCategories(id);
    if(category != null){
      currentId.value = id;
      titleRuEdit.text = category.titleRu??"";
      titleEnEdit.text = category.titleEn??"";
      Get.to(()=>EditCategoryView());
    }
    else{
      GlobalMixin.warningSnackBar("Упс", "Категория не найдена");
    }
  }


  @override
  void onClose() {
    super.onClose();
    titleEn.dispose();
    titleRu.dispose();
  }
}
