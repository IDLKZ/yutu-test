import 'package:findout/app/controllers/image_controller.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeProfileController extends GetxController {
  UserController user = Get.find<UserController>();
  ImageController _imageController = Get.find<ImageController>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   nameController.text = user.user?.name??"";
   surnameController.text = user.user?.surname??"";
   ageController.text = user.user?.age.toString()??'';
   cityController.text = user.user?.city.toString()??"";
   emailController.text = user.user?.email??"";
  }

  static const List<Map> languagesApp = [
    {"title":"Рус.","code":"ru"},
    // {"title":"Kaz.","code":"kz"},
    {"title":"Eng.","code":"en"},
  ];


  updateUser(){
    if(formKey.currentState!.validate()){
      UsersProvider().updateUser(prepareData());
      FirebaseAuth.instance.currentUser?.updatePassword(passwordController.text);
      GlobalMixin.successSnackBar("Отлично", "Успешно обновлено!");
      Get.offAllNamed(Routes.PROFILE);
    }
  }


  Map<String,dynamic> prepareData(){
    Map<String,dynamic> data = {
      "name":nameController.text.trim(),
      "surname":surnameController.text.trim(),
      "city":int.parse(cityController.text.trim()),
      "age":ageController.text.trim(),
    };
    if(_imageController.selectedImageUrl.value.isNotEmpty){
      data.assign("imageUrl", _imageController.selectedImageUrl.value);
    }
    return data;
  }



  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cityController.dispose();
    ageController.dispose();
  }
}
