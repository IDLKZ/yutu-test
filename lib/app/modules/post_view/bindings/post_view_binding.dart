import 'package:get/get.dart';

import '../controllers/post_view_controller.dart';

class PostViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostViewController>(
      () => PostViewController(),
    );
  }
}
