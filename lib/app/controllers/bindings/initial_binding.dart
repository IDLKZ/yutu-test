import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/controllers/connection_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AuthController>(
          () => AuthController(),
    );
    Get.put<ConnectionController>(
          ConnectionController(),
    );
  }

}