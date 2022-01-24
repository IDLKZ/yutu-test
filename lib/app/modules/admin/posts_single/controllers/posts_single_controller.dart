import 'package:get/get.dart';

import '../../../../controllers/image_controller.dart';
import '../../../../data/models/posts_model.dart';
import '../../../../data/providers/posts_provider.dart';
import '../../../../routes/app_pages.dart';

class PostsSingleController extends GetxController {
  //TODO: Implement PostsSingleController
  String? uid = Get.arguments;
  Rx<Posts?> post = Rx<Posts?>(null);
  ImageController _imageController = Get.put(ImageController());

  @override
  void onInit()async {
    super.onInit();
    post.value = await PostsProvider().getPost(uid);

  }


  deletePost() async{
    _imageController.deleteFile(post.value?.image??"");
    bool? result = await PostsProvider().deletePosts(uid);
    if(result == true){
      Get.offAllNamed(Routes.POSTS);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
