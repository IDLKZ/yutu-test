import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/wishlists_model.dart';

class WishlistsProvider extends GetConnect {
  final CollectionReference _wishlistRef = FirebaseFirestore.instance.collection("wishlists");
  final fAuth = FirebaseAuth.instance.currentUser;

  Future toggle(String? post)async{
      try{
        if(!await this.existWish(post)){
          await _wishlistRef.add({
            "user":fAuth?.uid,
            "post":post
          });
        }
        else{
          await this.deleteWishList(post);
        }
      }
      catch(e){
        print(e);
      }
  }

  Future <bool> existWish(String? post)async{
    try{
      QuerySnapshot wish = await _wishlistRef.where("user",isEqualTo: fAuth?.uid).where("post",isEqualTo:post).get();
      return wish.docs.length > 0 ? true : false;
    }
    catch(e){
      print(e);
      return false;
    }
  }


  Future deleteWishList(String? post)async{
    try{
      QuerySnapshot wish = await _wishlistRef.where("user",isEqualTo: fAuth?.uid).where("post",isEqualTo:post).get();
      wish.docs.forEach((element) {
        element.reference.delete();
      });
    }
    catch(e){
      print(e);
    }
  }

  Future <List> getListPost() async{
    List wishlist = [];
    try{
      QuerySnapshot wish = await _wishlistRef.where("user",isEqualTo: fAuth?.uid).get();
      wish.docs.forEach((element) {
        Map<String,dynamic> data = element.data() as Map<String, dynamic>;
        wishlist.add(data["post"]);
      });
      return wishlist;
    }
    catch(e){
      print(e);
      return wishlist;
    }
  }


  Future deleteUserWishlist(String? uid)async{
    final wishlist = await _wishlistRef.where("user",isEqualTo: uid).get();
    wishlist.docs.forEach((element) {
      element.reference.delete();
    });
  }




}
