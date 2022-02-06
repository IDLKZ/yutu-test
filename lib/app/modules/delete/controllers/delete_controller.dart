import 'package:findout/app/data/providers/users_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController {
  //TODO: Implement DeleteController

  @override
  void onInit()async {
    super.onInit();
    print("starting....");
    await UsersProvider().deleteUser(FirebaseAuth.instance.currentUser?.uid);
    await FirebaseAuth.instance.currentUser?.delete();
    print("done");

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
