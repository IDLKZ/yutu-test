import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/models/categories_model.dart';
import '../../../../data/providers/categories_provider.dart';

class PostsController extends GetxController {
  //TODO: Implement PostsController
  Rx<CategoriesList?> categoryStream = Rxn<CategoriesList>();
  Rx<Query> postsQuery = Rx<Query>(FirebaseFirestore.instance.collection("posts").orderBy("date",descending: true));
  Rx<List<Category>> categoriesList = Rx<List<Category>>([Category(id: "",titleRu:"Все",titleEn: "All")]);
  Rx<String?> activeCategory = Rxn<String?>("");
  Rx<List<Map<String, dynamic>>> categoriesItems = Rx<List<Map<String,dynamic>>>([]);
  final TextEditingController filterCategory = TextEditingController();
  final TextEditingController filterDateStart = TextEditingController();
  final TextEditingController filterDateEnd = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    categoryStream.bindStream(CategoriesProvider().getCategoriesStream());
    // ever(activeCategory, setActiveCategory);
    ever(categoryStream,_setCategoryList);
    ever(categoryStream,addCategoriesList);
  }

  filterByDate(TextEditingController category, TextEditingController dateStart, TextEditingController dateEnd){
    if(!dateStart.text.isEmpty && !dateEnd.text.isEmpty){
      if(!category.text.isEmpty){
        postsQuery.value = FirebaseFirestore.instance.collection('posts').where('category', isEqualTo: category.text.trim().toString()).orderBy("date",descending: true).where('date', isGreaterThanOrEqualTo: GlobalMixin.convertToDateFormatControllerToMilliseconds(dateStart))
            .where('date', isLessThan: GlobalMixin.convertToDateFormatControllerToMilliseconds(dateEnd));
      } else {
        postsQuery.value = FirebaseFirestore.instance.collection('posts').where('date', isGreaterThanOrEqualTo: GlobalMixin.convertToDateFormatControllerToMilliseconds(dateStart))
            .where('date', isLessThan: GlobalMixin.convertToDateFormatControllerToMilliseconds(dateEnd));
      }
    } else {
      postsQuery.value = FirebaseFirestore.instance.collection("posts").orderBy("date",descending: true);
    }
    getQuery();
    update();
    Get.back();
  }

  setActiveCategory(String? active){

    if(active.toString().isNotEmpty && active.toString() != "null"){
      postsQuery.value = FirebaseFirestore.instance.collection("posts").where("category",isEqualTo: active).orderBy("date",descending: true);
    }
    else{
      postsQuery.value = FirebaseFirestore.instance.collection("posts").orderBy("date",descending: true);
    }
    getQuery();
    update();
  }

  addCategoriesList(CategoriesList? _categoriesList){
    if(_categoriesList != null){
      if(_categoriesList.categoriesList != null){
        _categoriesList.categoriesList?.forEach((element) {
          categoriesList.value.add(element);
        });
      }
    }
  }

  _setCategoryList(CategoriesList? categoriesList){
    if(categoriesList != null){
      if(categoriesList.categoriesList != null){
        categoriesList.categoriesList?.forEach((category){
          categoriesItems.value.add(
              {
                "value":category.id,
                "label":category.titleRu,
              }
          );
        });
      }
    }
  }

  getQuery<Query>(){
    return postsQuery.value;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    filterDateStart.dispose();
    filterDateEnd.dispose();
  }
}
