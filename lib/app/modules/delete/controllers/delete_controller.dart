import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController {
  //TODO: Implement DeleteController

  @override
  void onInit()async {
    try{
      super.onInit();
      await UsersProvider().deleteUser(FirebaseAuth.instance.currentUser?.uid);
      await FirebaseAuth.instance.currentUser?.delete();
    }
    catch(e){
      print(e);
    }
    await Get.find<AuthController>().logout();




  }

  @override
  void onReady()async {
    super.onReady();
  }

  @override
  void onClose() {}
}
