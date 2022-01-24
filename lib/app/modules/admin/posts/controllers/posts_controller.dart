import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../data/models/categories_model.dart';
import '../../../../data/providers/categories_provider.dart';

class PostsController extends GetxController {
  //TODO: Implement PostsController
  Rx<CategoriesList?> categoryStream = Rxn<CategoriesList>();
  Rx<Query> postsQuery = Rx<Query>(FirebaseFirestore.instance.collection("posts").orderBy("date",descending: true));
  Rx<List<Category>> categoriesList = Rx<List<Category>>([Category(id: "",titleRu:"Все",titleEn: "All")]);
  Rx<String?> activeCategory = Rxn<String?>("");

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
    return postsQuery.value;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
