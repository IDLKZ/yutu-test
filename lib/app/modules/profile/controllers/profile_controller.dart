import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  Rx<String?> activeCategory = Rxn<String?>("");


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    try{
      FirebaseFirestore.instance.collection("posts").where("author",isEqualTo: FirebaseAuth.instance.currentUser?.uid).orderBy("date",descending: true).get();

    }
    catch(e){
      print(e);
    }
  }
}
