import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/data/models/users_model.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  //TODO: Implement UserController
  final Rx<Users?> _userModel = Rxn<Users?>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _userRef = FirebaseFirestore.instance.collection("users");



  @override
  void onInit() {
    super.onInit();
    final firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    firebaseUser.bindStream(auth.idTokenChanges());
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser,_setUser);
    _userModel.bindStream(UsersProvider().currentUser());
    ever(_userModel, _setUserModel);
  }

  _setUser(User? _user)async{
      Users? userDoc = await UsersProvider().getUsers(_user?.uid);
      user = userDoc;
  }
  _setUserModel(Users? _user)async{
    if(_userModel.value?.isAdmin != _user?.isAdmin){
      user = _user;
    }
    else{
      _userModel.value = _user;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Users? get user{
    return _userModel.value;
  }

  set user(Users? value){
    _userModel.value = value;
    if(value != null){
      if(value.isAdmin == true){
        Get.offAllNamed(Routes.DASHBOARD);
      }
      else{
        Get.offAllNamed(Routes.HOME);
      }
    }
    else{
      Get.find<AuthController>().logout();
    }
  }


}
