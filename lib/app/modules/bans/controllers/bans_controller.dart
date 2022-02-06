import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/providers/banlists_provider.dart';
import 'package:get/get.dart';

import '../../../data/models/users_model.dart';

class BansController extends GetxController {
  //TODO: Implement BansController
  Rx<List<String?>> bannedList = Rx<List<String?>>([]);
  final CollectionReference _userRef = FirebaseFirestore.instance.collection("users");
  Rx<bool> isLoading = Rx<bool>(false);

  @override
  void onInit()async {
    super.onInit();
    bannedList.value = await BanlistsProvider().banLists();
  }



  deleteBan(String? friend)async{
    isLoading.value = true;
    await BanlistsProvider().deleteBan(friend);
    bannedList.value = await BanlistsProvider().banLists();
    isLoading.value = false;
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
