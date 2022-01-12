import 'package:cloud_firestore/cloud_firestore.dart';
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
      Get.offNamed(Routes.HOME);
      // } else {
      //   Get.defaultDialog(
      //     title: 'Подтвердите почту',
      //     middleText: 'Добро пожаловать на FindOut, пожалуйста, подтвердите свой адрес электронной почты!'
      //   );
      // }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Упс...', 'Такого пользователя не существует', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Упс...', 'Неверный пароль!', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
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
        "name": name,
        "surname": surname,
        "age": age,
        "city": city
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
        Get.snackbar('Упс...', 'Пароль слишком слаб', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Упс...', 'Такая почта уже используется', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
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
