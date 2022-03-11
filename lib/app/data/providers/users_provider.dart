import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/providers/banlists_provider.dart';
import 'package:findout/app/data/providers/chats_provider.dart';
import 'package:findout/app/data/providers/posts_provider.dart';
import 'package:findout/app/data/providers/wishlists_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../models/users_model.dart';

class UsersProvider extends GetConnect {

  final CollectionReference _userRef = FirebaseFirestore.instance.collection("users");
  final CollectionReference _userPostsRef = FirebaseFirestore.instance.collection("posts");
  final fAuth = FirebaseAuth.instance.currentUser;

  Future<Users?> getUsers(String? id) async {
    DocumentSnapshot userDoc = await _userRef.doc(id).get();
    if(userDoc.exists){
      return Users.fromJson(userDoc.data() as Map<String,dynamic>);
    }
  }

  Stream<Users?> currentUser(){
      return _userRef.doc(FirebaseAuth.instance.currentUser?.uid).snapshots().map((event){
        if(event.data() != null){
          return Users.fromJson(event.data() as Map<String,dynamic>);
        }
      });
  }

  Stream<Users?> teammate(String? friendId){
    return _userRef.doc(friendId).snapshots().map((event){
      if(event.data() != null){
        return Users.fromJson(event.data() as Map<String,dynamic>);
      }
    });
  }


  Future<Response<Users>> postUsers(Users users) async =>
    await post('users', users);



  Future updateUser(Map<String,dynamic> data)async{
    await _userRef.doc(fAuth?.uid).update(data);
    try{
      Get.find<UserController>().user = await this.getUsers(fAuth?.uid);
    }
    catch(e){

    }

  }

  Future<bool> deleteUser(String? id) async {
    try{
      await BanlistsProvider().deleteUserFromBan(id);
      await PostsProvider().deleteUserPost(id);
      await WishlistsProvider().deleteUserWishlist(id);
      await ChatProvider().deleteUserChat(id);
      await _userRef.doc(id).delete();
      GlobalMixin.successSnackBar("success".tr, "account_deleted".tr);
      return true;
    }
    catch (e){
      print(e);
      return false;
    }
  }




}
