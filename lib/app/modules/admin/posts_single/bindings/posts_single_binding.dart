import 'package:get/get.dart';

import '../controllers/posts_single_controller.dart';

class PostsSingleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostsSingleController>(
      () => PostsSingleController(),
    );
  }
}
