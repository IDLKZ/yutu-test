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
  Rx<String> userEmail = Rx<String>("");
  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    String? args = Get.arguments;

    try{
      if(args.toString() != "null" && args.toString().isNotEmpty){
        userEmail.value = args.toString();
      }
      else{
        userEmail.value = _userController.user?.email??"";
      }
    }
    catch(e){
      print(e);
    }
  }


}
