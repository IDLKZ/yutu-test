
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app_pages.dart';

class GuestMiddleware extends GetMiddleware{
  @override
  // TODO: implement priority
  int? get priority => 2;
  @override
  RouteSettings? redirect(String? route) {
    if(FirebaseAuth.instance.currentUser != null){
      return const RouteSettings(name:Routes.HOME);
    }
  }
}