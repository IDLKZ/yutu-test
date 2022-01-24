import 'package:findout/app/controllers/image_controller.dart';
import 'package:findout/app/data/providers/posts_provider.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/models/posts_model.dart';
import '../../../helpers/global_mixin.dart';

class PostViewController extends GetxController {
  //TODO: Implement PostViewController
  String? uid = Get.arguments;
  Rx<Posts?> post = Rx<Posts?>(null);

  ImageController _imageController = Get.put(ImageController());
  @override
  void onInit() async{
    super.onInit();
     post.value = await PostsProvider().getPost(uid);

  }

  deletePost() async{
    _imageController.deleteFile(post.value?.image??"");
    bool? result = await PostsProvider().deletePosts(uid);
    if(result == true){
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
