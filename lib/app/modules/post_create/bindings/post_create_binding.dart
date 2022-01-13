import 'package:get/get.dart';

import '../controllers/post_create_controller.dart';

class PostCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostCreateController>(
      () => PostCreateController(),
    );
  }
}
