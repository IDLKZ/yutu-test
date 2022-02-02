import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/data/providers/banlists_provider.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/models/users_model.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  Rx<String?> activeCategory = Rxn<String?>("");
  Rx<Users?> currentUser = Rxn<Users?>(null);
  UserController _userController = Get.find<UserController>();
  Rx<String> userId = Rx<String>("");
  Rx<bool> isBanned = Rx<bool>(false);

  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    String? args = Get.arguments;
    try{
      if(args.toString() != "null" && args.toString().isNotEmpty){
        userId.value = args.toString();
        isBanned.value = await BanlistsProvider().isFriendBanned(args);
      }
      else{
        userId.value = _userController.user?.id??"";
      }
    }
    catch(e){
      print(e);
    }
  }


  banUser()async{
    await BanlistsProvider().banPerson(userId.value);
    isBanned.value = await BanlistsProvider().isFriendBanned(userId.value);
  }

  clearBan()async{
    await BanlistsProvider().deleteBan(userId.value);
    isBanned.value = await BanlistsProvider().isFriendBanned(userId.value);
  }

}
