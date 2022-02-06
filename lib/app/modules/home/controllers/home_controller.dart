import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/data/providers/categories_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/categories_model.dart';



class HomeController extends GetxController {
  UserController _userController = Get.find<UserController>();
  Rx<CategoriesList?> categoryStream = Rxn<CategoriesList>();
  Rx<String?> activeCategory = Rxn<String?>("");
  Rx<int> currentTime = Rx<int>(DateTime.now().millisecondsSinceEpoch);
  Rx<List<Category>> categoriesList = Rx<List<Category>>([Category(id: "",titleRu:"Все",titleEn: "All")]);
  Rx<Query> postsQuery = Rx<Query>(FirebaseFirestore.instance.collection("posts").where("city",isEqualTo: Get.find<UserController>().user?.city).where("date",isGreaterThanOrEqualTo: DateTime.now().millisecondsSinceEpoch).orderBy("date",descending: true));
  final TextEditingController title = TextEditingController();
  @override
  void onInit()async {
    super.onInit();
    currentTime.value = await GlobalMixin.getTimestamp();
    postsQuery.value = FirebaseFirestore.instance.collection("posts").where("city",isEqualTo: _userController.user?.city).where("date",isGreaterThanOrEqualTo: currentTime.value).orderBy("date",descending: true);
    categoryStream.bindStream(CategoriesProvider().getCategoriesStream());
    ever(activeCategory, setActiveCategory);
    ever(categoryStream,addCategoriesList);
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

  }
//Custom function
  setActiveCategory(String? active){

    if(active.toString().isNotEmpty && active.toString() != "null"){
      postsQuery.value = FirebaseFirestore.instance.collection("posts").where("city",isEqualTo: _userController.user?.city).where("category",isEqualTo: active).where("date",isGreaterThanOrEqualTo: currentTime.value).orderBy("date",descending: true);
    }
    else{
      postsQuery.value = FirebaseFirestore.instance.collection("posts").where("city",isEqualTo: _userController.user?.city).where("date",isGreaterThanOrEqualTo: currentTime.value).orderBy("date",descending: true);
    }
    getQuery();
    update();
    categoriesList.refresh();

  }
  
  searchPosts()async{
    Query query = FirebaseFirestore.instance.collection("posts");
    if(title.text.isNotEmpty){
      query = query.where("title",isGreaterThanOrEqualTo: title.text.trim()).where("title",isLessThan: title.text.trim() + 'z');
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
    categoriesList.refresh();
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
