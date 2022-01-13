import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/controllers/connection_controller.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AuthController>(
          () => AuthController(),
      fenix: true
    );
    Get.put<UserController>(
      UserController(),
      permanent: true
    );
    Get.put<ConnectionController>(
          ConnectionController(),
      permanent: true
    );
  }

}