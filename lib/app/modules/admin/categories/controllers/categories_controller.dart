import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final TextEditingController titleRu = TextEditingController();
  final TextEditingController titleEn = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    super.onClose();
    titleEn.dispose();
    titleRu.dispose();
  }
}
