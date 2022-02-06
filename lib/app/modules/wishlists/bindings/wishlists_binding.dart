import 'package:get/get.dart';

import '../controllers/wishlists_controller.dart';

class WishlistsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistsController>(
      () => WishlistsController(),
    );
  }
}
