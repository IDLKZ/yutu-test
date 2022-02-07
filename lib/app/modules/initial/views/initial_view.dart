import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/modules/admin/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helpers/kcolors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/initial_controller.dart';

class InitialView extends GetView<InitialController> {

  UserController _userController = Get.find<UserController>();

  Widget _welcome(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.45,
          // width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg-login.png'),
                  fit: BoxFit.fill
              )
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 95, left: 20),
          child:  Text(
            'welcome'.tr,
            style: TextStyle(fontSize: 44,
                fontWeight: FontWeight.bold,
                color: KColors.kDarkViolet),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           _welcome(context),
            Center(child: CircularProgressIndicator(),)
        ],
      ),
    );
  }
}
