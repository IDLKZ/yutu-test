import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/providers/wishlists_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class WishlistsController extends GetxController {
  //TODO: Implement WishlistsController
  
  CollectionReference _postRef = FirebaseFirestore.instance.collection("posts");
  Rx<Query> postsQuery = Rx<Query>(FirebaseFirestore.instance.collection("posts").where(FieldPath.documentId, whereIn: ["123"]));
  Rx<List>data = Rx<List>([]);
  Rx<int> currentTime = Rx<int>(0);
  @override
  void onInit()async {
    super.onInit();
    currentTime.value = await GlobalMixin.getTimestamp();
    data.value = await WishlistsProvider().getListPost();
    if(data.value.length > 0){
      try{
        print(currentTime.value);
        dynamic queries = _postRef.where(FieldPath.documentId, whereIn: data.value).where("date",isGreaterThan: currentTime.value);
        postsQuery.value = queries;
      }
      catch(e){
        print(e);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}



  getQuery<Query>(){
    return postsQuery.value;
  }
}
