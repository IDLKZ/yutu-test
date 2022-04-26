import 'package:get/get.dart';

import '../controllers/privacy_term_controller.dart';

class PrivacyTermBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyTermController>(
      () => PrivacyTermController(),
    );
  }
}
