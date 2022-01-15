import 'package:findout/app/data/providers/categories_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final TextEditingController titleRu = TextEditingController();
  final TextEditingController titleEn = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Map<String,dynamic> prepareDate(){
    return {
      "titleRu":titleRu.text.trim(),
      "titleEn":titleEn.text.trim(),
      "status":"1"
    };
  }

  Future <void> createCategory()async {
    if (formKey.currentState?.validate() == true) {
      if (await CategoriesProvider().createCategory(prepareDate())) {
        formKey.currentState?.reset();
      }
    }
  }


  @override
  void onClose() {
    super.onClose();
    titleEn.dispose();
    titleRu.dispose();
  }
}
