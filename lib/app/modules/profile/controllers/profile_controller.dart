import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/models/users_model.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  Rx<String?> activeCategory = Rxn<String?>("");
  Rx<Users?> currentUser = Rxn<Users?>(null);
  UserController _userController = Get.find<UserController>();
  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    String? userEmail = Get.arguments;

    try{
      if(userEmail.toString() != "null" && userEmail.toString().isNotEmpty){
        currentUser.value = await UsersProvider().getUsersByEmail(userEmail);
        if(currentUser.value == null){
          Get.back();
        }
      }
      else{
        currentUser.value = _userController.user;
      }
    }
    catch(e){
      print(e);
    }
  }


}
