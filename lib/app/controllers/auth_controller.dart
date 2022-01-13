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

  void login(String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // if(userCredential.user!.emailVerified){
      if(userCredential.user?.uid == 'uK2jaVl6HUNE8uYRajjrWB0bF9k2'){
        Get.offNamed(Routes.DASHBOARD);
      } else {
        Get.offNamed(Routes.HOME);
      }

      // } else {
      //   Get.defaultDialog(
      //     title: 'Подтвердите почту',
      //     middleText: 'Добро пожаловать на FindOut, пожалуйста, подтвердите свой адрес электронной почты!'
      //   );
      // }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        GlobalMixin.warningSnackBar('Упс...', 'Такого пользователя не существует');
      } else if (e.code == 'wrong-password') {
        GlobalMixin.warningSnackBar('Упс...', 'Неверный пароль!');
      }
    } catch(e) {
      Get.snackbar('Упс...', 'Что-то пошло не так', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void register(String email, String password, String name, String surname, int age, String city) async {
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
        "isAdmin":true,
        "status":0,
      });
      Get.toNamed(Routes.HOME);
      // await userCredential.user!.sendEmailVerification();
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
        GlobalMixin.warningSnackBar('Упс...', 'Пароль слишком слаб');
      } else if (e.code == 'email-already-in-use') {
        GlobalMixin.warningSnackBar('Упс...', 'Такая почта уже используется');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Упс...', 'Что-то пошло не так', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kError, colorText: Colors.white);
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offNamed(Routes.LOGIN);
  }
}
