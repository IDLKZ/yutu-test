import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/users_model.dart';

class UsersProvider extends GetConnect {

  final CollectionReference _userRef = FirebaseFirestore.instance.collection("users");
  final fAuth = FirebaseAuth.instance.currentUser;

  Future<Users?> getUsers(String? id) async {
    DocumentSnapshot userDoc = await _userRef.doc(id).get();
    if(userDoc.exists){
      return Users.fromJson(userDoc.data() as Map<String,dynamic>);
    }
  }

  Future<Users?> getUsersByEmail(String? email) async {
    QuerySnapshot userDoc = await _userRef.where("email",isEqualTo: email).get();
    try{
      return Users.fromJson(userDoc.docs.first.data() as Map<String,dynamic>);
    }
    catch(e){
      print(e);
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
  }


}
