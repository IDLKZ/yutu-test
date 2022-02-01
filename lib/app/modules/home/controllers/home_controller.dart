import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/providers/categories_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/categories_model.dart';



class HomeController extends GetxController {
  Rx<CategoriesList?> categoryStream = Rxn<CategoriesList>();
  Rx<String?> activeCategory = Rxn<String?>("");
  Rx<List<Category>> categoriesList = Rx<List<Category>>([Category(id: "",titleRu:"Все",titleEn: "All")]);
  Rx<Query> postsQuery = Rx<Query>(FirebaseFirestore.instance.collection("posts").orderBy("date",descending: true));
  final TextEditingController title = TextEditingController();

  @override
  void onInit()async {
    super.onInit();
    categoryStream.bindStream(CategoriesProvider().getCategoriesStream());
    ever(activeCategory, setActiveCategory);
    ever(categoryStream,addCategoriesList);

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

  }
//Custom function
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
  
  searchPosts(){
    Query query = FirebaseFirestore.instance.collection("posts");
    if(title.text.isNotEmpty){
      print(title.text);
      query =
        query.where("title",isGreaterThanOrEqualTo: title.text.trim())
        .where("title",isLessThan: title.text.trim() + 'z');
      postsQuery.value = query;
      update();
    }
    //query


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
    return postsQuery.value;
  }
  //Custom Function
  @override
  void onReady()async {
    super.onReady();
  }

  @override
  void onClose() {}



}
