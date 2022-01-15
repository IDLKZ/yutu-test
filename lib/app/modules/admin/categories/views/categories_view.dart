import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/modules/admin/categories/views/add_view.dart';
import 'package:findout/app/modules/admin/categories/views/edit_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/categories_controller.dart';
class CategoriesView extends GetView<CategoriesController> {


  _categoriesList(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [

            ],
          );
        },
      ),
    );
  }


  _categoryCard(){
    return Card(
      color: KColors.kAdminBgColor,
      child: ListTile(
        onTap: ()=>Get.to(()=>EditCategoryView()),
        leading: Icon(FontAwesomeIcons.layerGroup, color: Colors.white,),
        title: Text('Categories', style: TextStyle(color: Colors.white),),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete, color: Colors.white,),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.kAdminBgColor,
      appBar: AppBar(
        backgroundColor: KColors.kAdminBgColor,
        title: Text('Админ-Панель'),
        actions: [
          IconButton(
              onPressed: () => Get.find<AuthController>().logout(),
              icon: Icon(Icons.logout)
          )
        ],
      ),

      body: _categoriesList(),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(()=>AddCategoryView()),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
