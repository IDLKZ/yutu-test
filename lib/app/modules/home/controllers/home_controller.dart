import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/providers/categories_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';

import '../../../data/models/categories_model.dart';

class HomeController extends GetxController {
  Rx<CategoriesList?> categoryStream = Rxn<CategoriesList>();
  Rx<String?> activeCategory = Rxn<String?>("");
  Rx<List<Category>> categoriesList = Rx<List<Category>>([Category(id: "",titleRu:"Все",titleEn: "All")]);
  Rx<Query> postsQuery = Rx<Query>(FirebaseFirestore.instance.collection("posts").orderBy("date",descending: true));

  @override
  void onInit() {
    super.onInit();
    categoryStream.bindStream(CategoriesProvider().getCategoriesStream());
    ever(activeCategory, setActiveCategory);
    ever(categoryStream,addCategoriesList);
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


   getQuery<Query>(){
    //return  FirebaseFirestore.instance.collection("posts").where('title',isGreaterThanOrEqualTo: "Рест").where('title', isLessThanOrEqualTo:"Рест"+ '\uf8ff');
    return postsQuery.value;
  }

  @override
  void onReady()async {
    super.onReady();
  }

  @override
  void onClose() {}



}
