import 'package:findout/app/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app_pages.dart';

class AdminMiddleware extends GetMiddleware {

  @override
  // TODO: implement priority
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if(Get.find<UserController>().user.isAdmin == true){
      return const RouteSettings(name:Routes.DASHBOARD);
    }
  }
}