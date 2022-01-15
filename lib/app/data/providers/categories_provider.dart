import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../helpers/global_mixin.dart';
import '../models/categories_model.dart';

class CategoriesProvider extends GetConnect {
  final CollectionReference _categoryRef = FirebaseFirestore.instance.collection("categories");


  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Categories.fromJson(map);
      if (map is List)
        return map.map((item) => Categories.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Categories?> getCategories(int id) async {
    final response = await get('categories/$id');
    return response.body;
  }

  Future<Response<Categories>> postCategories(Categories categories) async =>
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
      GlobalMixin.errorSnackBar("Упс", "Что-то пошло не так");
      return false;

    }


  }
}
