import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../helpers/kcolors.dart';

class AppBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  String? title;

   AppBarAdmin({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: KColors.kAdminBgColor,
      title: Text(this.title??"Панель управления"),
      actions: [
        IconButton(
            onPressed: () => Get.find<AuthController>().logout(),
            icon: Icon(Icons.logout)
        )
      ],
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(Get.height*0.1);
  }
}
