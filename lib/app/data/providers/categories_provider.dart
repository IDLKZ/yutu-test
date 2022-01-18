import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../helpers/global_mixin.dart';
import '../models/categories_model.dart';

class CategoriesProvider extends GetConnect {
  final CollectionReference _categoryRef = FirebaseFirestore.instance.collection("categories");


  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Category.fromJson(map);
      if (map is List)
        return map.map((item) => Category.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Category?> getCategories(String? id) async {
    final category = await _categoryRef.doc(id).get();
    if(category != null){
      if(category.data() != null){
       return Category.fromJson(category.data() as Map<String,dynamic>);
      }
    }

  }

  Future<bool> deleteCategory(String? id) async {
    try{
      await _categoryRef.doc(id).delete();
      GlobalMixin.successSnackBar("Отлично", "Категория успешно удалена!");
      return true;
    }
    catch (e){
      print(e);
      return false;
    }
  }

  Future<Response<Category>> postCategories(Category categories) async =>
      await post('categories', categories);
  Future<Response> deleteCategories(int id) async =>
      await delete('categories/$id');


  Future<bool> createCategory(Map<String,dynamic> categories)async{
    try{
      await _categoryRef.add({'titleRu': categories["titleRu"],'titleEn': categories["titleEn"], 'status': int.parse(categories["status"]),});
      GlobalMixin.successSnackBar("Отлично", "Категория успешно добавлена!");
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> updateCategory(Map<String,dynamic> categories,String? id)async{
    try{
      await _categoryRef.doc(id).update({'titleRu': categories["titleRu"],'titleEn': categories["titleEn"], 'status': int.parse(categories["status"]),});
      GlobalMixin.successSnackBar("Отлично", "Категория успешно обновлена!");
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  Stream<CategoriesList?> getCategoriesStream(){
    return _categoryRef.where('status',isEqualTo: 1).snapshots().map((QuerySnapshot querySnapshot){
      return CategoriesList.fromFirebase(querySnapshot);
    });

  }


}
