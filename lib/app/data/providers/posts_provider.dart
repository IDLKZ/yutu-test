import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../helpers/global_mixin.dart';
import '../models/posts_model.dart';

class PostsProvider extends GetConnect {
  final CollectionReference _postRef = FirebaseFirestore.instance.collection("posts");

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Posts.fromJson(map);
      if (map is List) return map.map((item) => Posts.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Posts?> getPosts(int id) async {
    final response = await get('posts/$id');
    return response.body;
  }

  Future<bool> createPost(Map<String,dynamic> data)async{
    try{
      await _postRef.add(data);
      GlobalMixin.successSnackBar("Отлично", "Пост успешно создан!");
      return true;
    }
    catch(e){
      print(e);
      GlobalMixin.warningSnackBar("Упс", "Что-то пошло не так!");
      return false;
    }
  }

  Query getPostsByCategory(String? category){
    return _postRef.where("category",isEqualTo: category).orderBy("date",descending: true);
  }


  Future<Response> deletePosts(int id) async => await delete('posts/$id');


  Stream<PostsList?> getPostsStream(){
    return _postRef.where('status',isEqualTo: 1).snapshots().map((QuerySnapshot querySnapshot){
      return PostsList.fromFirebase(querySnapshot);
    });

  }

}
