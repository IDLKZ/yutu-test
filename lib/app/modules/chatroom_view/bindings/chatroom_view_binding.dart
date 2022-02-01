import 'package:get/get.dart';

import '../controllers/chatroom_view_controller.dart';

class ChatroomViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatroomViewController>(
      () => ChatroomViewController(),
    );
  }
}
