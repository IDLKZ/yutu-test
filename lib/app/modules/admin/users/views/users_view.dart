import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.kAdminBgColor,
      appBar: AppBar(
        backgroundColor: KColors.kAdminBgColor,
        title: GetBuilder<UsersController>(
            builder: (_) => controller.customSearchBar
        ),
        actions: [
          IconButton(
            onPressed: controller.change,
            icon: GetBuilder<UsersController>(
                builder: (_) => controller.customIcon
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index){
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage('assets/images/ava.jpg'),
                  ),
                  title: Text('User', style: TextStyle(color: Colors.white),),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Get.defaultDialog(
                            title: 'Action',
                            middleText: 'Are you sure?',
                            onConfirm: (){},
                            textConfirm: 'Yes',
                            textCancel: 'No'
                          );
                        },
                        child: Icon(FontAwesomeIcons.ban, color: Colors.white30,)
                      ), // icon-1
                      GestureDetector(
                          onTap: (){
                            Get.defaultDialog(
                                title: 'Action',
                                middleText: 'Are you sure?',
                                onConfirm: (){},
                                textConfirm: 'Yes',
                                textCancel: 'No'
                            );
                          },
                          child: Icon(Icons.delete, color: Colors.redAccent,)
                      ), // icon-2
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
