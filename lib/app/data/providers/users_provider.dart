import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/users_model.dart';

class UsersProvider extends GetConnect {

  final CollectionReference _userRef = FirebaseFirestore.instance.collection("users");


  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Users.fromJson(map);
      if (map is List) return map.map((item) => Users.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Users?> getUsers(String? id) async {
    DocumentSnapshot userDoc = await _userRef.doc(id).get();
    if(userDoc.exists){
      return Users.fromJson(userDoc.data() as Map<String,dynamic>);
    }
  }

  Stream<Users?> currentUser(){
      return _userRef.doc(FirebaseAuth.instance.currentUser?.uid).snapshots().map((event){
        print(event.data());
        return Users.fromJson(event.data() as Map<String,dynamic>);
      });
  }

  Future<Response<Users>> postUsers(Users users) async =>
      await post('users', users);
  Future<Response> deleteUsers(int id) async => await delete('users/$id');
}
