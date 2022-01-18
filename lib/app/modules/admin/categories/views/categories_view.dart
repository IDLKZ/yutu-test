import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/data/models/categories_model.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/modules/admin/categories/views/add_view.dart';
import 'package:findout/app/modules/admin/categories/views/edit_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {

  PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();

  _categoriesList(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child:RefreshIndicator(
        child: PaginateFirestore(
          isLive: true,
          itemsPerPage: 20,
          itemBuilder: (context, documentSnapshots, index) {
            return _categoryCard(Category.fromJson(documentSnapshots[index].data() as Map<String,dynamic>,),documentSnapshots[index].id);
          },
          // orderBy is compulsary to enable pagination
          query: FirebaseFirestore.instance.collection('categories').orderBy('titleRu'),
          listeners: [
            refreshChangeListener,
          ],
          itemBuilderType: PaginateBuilderType.listView,
        ),
        onRefresh: () async {
          refreshChangeListener.refreshed = true;
        },
      ),
    );
  }


  _categoryCard(Category category,String? id){
    return Card(
      color: KColors.kAdminBgColor,
      child: ListTile(
        onTap: ()=>controller.changeCategory(id),
        leading: Icon(FontAwesomeIcons.layerGroup, color: Colors.white,),
        title: Text('${category.titleRu ?? ""}', style: TextStyle(color: Colors.white),),
        subtitle: Text('${category.titleEn ?? ""}', style: TextStyle(color: Colors.white),),
        trailing: IconButton(
          onPressed: () {controller.deleteCategory(id);},
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
