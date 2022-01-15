import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

import '../../controllers/user_controller.dart';

class AuthMiddleware extends GetMiddleware{
  @override
  // TODO: implement priority
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    if(FirebaseAuth.instance.currentUser == null){
      return const RouteSettings(name:Routes.LOGIN);
    }
    else if(Get.find<UserController>().user?.isAdmin == true) {
      return const RouteSettings(name:Routes.DASHBOARD);
    }
  }





}