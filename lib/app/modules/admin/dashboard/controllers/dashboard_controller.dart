import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';

class DashboardController extends GetxController {
  late Rx<int> categories = 0.obs;
  late Rx<int> posts = 0.obs;
  late Rx<int> users = 0.obs;

  Stream<QuerySnapshot> categoriesStream = FirebaseFirestore.instance.collection('categories').snapshots();
  Stream<QuerySnapshot> postsStream = FirebaseFirestore.instance.collection('posts').snapshots();
  Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  // countDocuments() async {
  //
  //   QuerySnapshot cats = await FirebaseFirestore.instance.collection('categories').get();
  //   List<DocumentSnapshot> myCats = cats.docs;
  //   QuerySnapshot posts = await FirebaseFirestore.instance.collection('posts').get();
  //   List<DocumentSnapshot> myPosts = posts.docs;
  //   QuerySnapshot users = await FirebaseFirestore.instance.collection('users').where('isAdmin', isEqualTo: false).get();
  //   List<DocumentSnapshot> myUsers = users.docs;
  //
  //   this.categories.value = myCats.length;
  //   this.posts.value = myPosts.length;
  //   this.users.value = myUsers.length;
  //   update();
  // }

  @override
  void onInit() {
    // countDocuments();
    super.onInit();
  }

}
