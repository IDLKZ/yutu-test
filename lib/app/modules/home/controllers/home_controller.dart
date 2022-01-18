import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/providers/categories_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/models/categories_model.dart';

class HomeController extends GetxController {
  Rx<CategoriesList?> categoryList = Rxn<CategoriesList>();
  Rx<String?> activeCategory = Rxn<String?>("");
  Rx<Query> postsQuery = Rx<Query>(FirebaseFirestore.instance.collection("posts").orderBy("date",descending: true));
  @override
  void onInit() {
    super.onInit();
    categoryList.bindStream(CategoriesProvider().getCategoriesStream());
    ever(activeCategory, setActiveCategory);
  }

  setActiveCategory(String? active){
    if(active != null){
      postsQuery.value = active.isNotEmpty
          ? FirebaseFirestore.instance.collection("posts").where("category",isEqualTo: active).orderBy("date",descending: true)
          : postsQuery.value = FirebaseFirestore.instance.collection("posts").orderBy("date",descending: true);

      ;
    }
    else{
      postsQuery.value = FirebaseFirestore.instance.collection("posts").orderBy("date",descending: true);
    }
  }

  @override
  void onReady()async {
    super.onReady();
  }

  @override
  void onClose() {}



}
