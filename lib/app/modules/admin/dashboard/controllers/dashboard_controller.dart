import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  Stream<QuerySnapshot> categoriesStream = FirebaseFirestore.instance.collection('categories').snapshots();
  Stream<QuerySnapshot> postsStream = FirebaseFirestore.instance.collection('posts').snapshots();
  Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void onInit() {
    super.onInit();
  }

}
