import 'package:findout/app/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app_pages.dart';

class AdminMiddleware extends GetMiddleware {

  @override
  // TODO: implement priority
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    if(FirebaseAuth.instance.currentUser == null){
      return const RouteSettings(name:Routes.LOGIN);
    }
    else if(Get.find<UserController>().user?.isAdmin == false) {
      return const RouteSettings(name:Routes.HOME);
    }
  }
}