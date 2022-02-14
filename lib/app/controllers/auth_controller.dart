import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void resetPassword(String email) async {
    if(GetUtils.isEmail(email)){
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: 'Проверьте почту',
          middleText: 'На вашу почту отправлено письмо с подтверждением'
        );
        Timer.periodic(new Duration(seconds: 3), (timer) {
          Get.back();
          Get.toNamed(Routes.LOGIN);
        });
      } catch(e) {
        print(e);
      }
    } else {
      Get.defaultDialog(
          title: 'Error',
          middleText: 'Error!'
      );
    }
  }

  void login(String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // if(userCredential.user!.emailVerified){
      //   GlobalMixin.successSnackBar('FindOut!', 'return_back'.tr);
      // } else {
      //   Get.defaultDialog(
      //     title: 'Подтвердите почту',
      //     middleText: 'Добро пожаловать на FindOut, пожалуйста, подтвердите свой адрес электронной почты!'
      //   );
      // }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        GlobalMixin.warningSnackBar('oops'.tr, 'account_doesnt_exist'.tr);
      } else if (e.code == 'wrong-password') {
        GlobalMixin.warningSnackBar('oops'.tr, 'incorrect_password'.tr);
      }
    } catch(e) {
      Get.snackbar('oops'.tr, 'something_went_wrong'.tr, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void register(String email, String password, String name, String surname, String age, String city) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      users.doc(userCredential.user!.uid).set({
        "id":userCredential.user!.uid,
        "email":email,
        "name": name,
        "surname": surname,
        "phone":"",
        "age": age,
        "city": city,
        "isAdmin":false,
        "status":0,
      });
      GlobalMixin.successSnackBar('FindOut!', 'return_back'.tr);
      // Get.offAllNamed(AppPages.INITIAL);
      await userCredential.user!.sendEmailVerification();
      // Get.defaultDialog(
      //     title: 'Подтвердите почту',
      //     middleText: 'На вашу почту отправлена ссылка. Перейдите чтобы завершить регистрацию!',
      //     onConfirm: (){
      //       Get.back();
      //       Get.offNamed(Routes.LOGIN);
      //     },
      //     textConfirm: 'Понятно'
      // );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        GlobalMixin.warningSnackBar('oops'.tr, 'weak_password'.tr);
      } else if (e.code == 'email-already-in-use') {
        GlobalMixin.warningSnackBar('oops'.tr, 'email_in_used'.tr);
      }
    } catch (e) {
      print(e);
      Get.snackbar('oops'.tr, 'something_went_wrong'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kError, colorText: Colors.white);
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
