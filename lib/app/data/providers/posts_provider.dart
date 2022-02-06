import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/image_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<Posts?> getPost(String? uid) async {
    DocumentSnapshot _post = await _postRef.doc(uid).get();
    if(_post.exists){
      return Posts.fromJson(_post.data() as Map<String,dynamic>);
    }
  }

  Stream<Posts?> getPostStream(String? uid) {
    return _postRef.doc(uid).snapshots().map((DocumentSnapshot documentSnapshot){
       PostsList.fromJson(documentSnapshot.data() as Map<String,dynamic>);
  });
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

  Future<bool> updatePost(Map<String,dynamic> data,String? uid)async{
    try{
      DocumentSnapshot _post = await _postRef.doc(uid).get();
      if(_post.exists){
        await _postRef.doc(uid).update(data);
        GlobalMixin.successSnackBar("Отлично", "Пост успешно изменен!");
        return true;
      }
      else{
        GlobalMixin.warningSnackBar("Упс", "Поста не существует");
        return false;
      }
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


  Future<bool?> deletePosts(String? uid) async{
    try{
      DocumentSnapshot _post = await _postRef.doc(uid).get();
      if(_post.exists){
        await _postRef.doc(uid).delete();
        GlobalMixin.successSnackBar("Отлично", "Пост успешно удален!");
        return true;
      }
      else{
        GlobalMixin.warningSnackBar("Упс", "Поста не существует");
        return false;
      }
    }
    catch(e){
      print(e);
      GlobalMixin.warningSnackBar("Упс", "Что-то пошло не так!");
      return false;
    }
  }


  Stream<PostsList?> getPostsStream(){
    return _postRef.where('status',isEqualTo: 1).snapshots().map((QuerySnapshot querySnapshot){
      return PostsList.fromFirebase(querySnapshot);
    });
  }

  Future deleteUserPost(String? uid)async{
    final allPosts = await _postRef.where("author",isEqualTo:uid).get();
      for(var item in allPosts.docs){
        try{
          Posts _post = Posts.fromJson(item.data() as Map<String,dynamic>);
          _post.image != null ? ImageController().deleteFile(_post.image??"") : null;
          item.reference.delete();
        }
        catch(e){

        }

      }
    }
}
