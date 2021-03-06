import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.kAdminBgColor,
      appBar: AppBar(
        backgroundColor: KColors.kAdminBgColor,
        title: Text('Админ-Панель'),
        actions: [
          IconButton(
              onPressed: () => authC.logout(),
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(Routes.CATEGORIES),
              child: Card(
                color: Color(0xFF2a2c35),
                elevation: 4,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Категории', style: TextStyle(fontSize: 20, color: Colors.white),),
                      StreamBuilder<QuerySnapshot>(
                        stream: controller.categoriesStream,
                        builder: (context, snapshot) {
                          return GetBuilder<DashboardController>(
                              builder: (_) {
                                return Text('${snapshot.data?.docs.length}', style: TextStyle(fontSize: 20, color: Colors.white),);
                              }
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: ()=>Get.toNamed(Routes.POSTS),
              child: Card(
                color: Color(0xFF2a2c35),
                elevation: 4,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Посты', style: TextStyle(fontSize: 20, color: Colors.white),),
                      StreamBuilder<QuerySnapshot>(
                        stream: controller.postsStream,
                        builder: (context, snapshot) {
                          return GetBuilder<DashboardController>(
                              builder: (_) {
                                return Text('${snapshot.data?.docs.length}', style: TextStyle(fontSize: 20, color: Colors.white),);
                              }
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.USERS),
              child: Card(
                color: Color(0xFF2a2c35),
                elevation: 4,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Пользователи', style: TextStyle(fontSize: 20, color: Colors.white),),
                      StreamBuilder<QuerySnapshot>(
                        stream: controller.usersStream,
                        builder: (context, snapshot) {
                          return GetBuilder<DashboardController>(
                              builder: (_) {
                                return Text('${snapshot.data?.docs.length}', style: TextStyle(fontSize: 20, color: Colors.white),);
                              }
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
