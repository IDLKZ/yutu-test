import 'dart:convert';

import 'package:findout/app/helpers/api_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../helpers/kcolors.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageController extends GetxController{

  //Path of File
  Rx<String> selectedImagePath = Rx<String>("");
  //Size of File
  Rx<String> selectedImageSize = Rx<String>("");
  //Uploaded File URL
  Rx<String> selectedImageUrl  = Rx<String>("");
  //Initialize picker
  final picker = ImagePicker();
  //Initialize storage
  FirebaseStorage storage = FirebaseStorage.instance;

  Future <bool> pickImage(ImageSource source)async {
    try {
      final selectedFile = await picker.pickImage(source: source);
      if (selectedFile!.path != null) {
        selectedImagePath.value = selectedFile.path;
        bool isModerate = await moderateImage(selectedFile,isCheck: true);
        bool result = isModerate ? await uploadImage(File(selectedFile.path), basename(selectedFile.path)) : false;
        if (result) {
          Get.snackbar('Отлично', 'Фото готово', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kSuccess, colorText: Colors.white);
          return true;
        }
        else {
          selectedImageUrl.value = "";
          return false;
        }
      }
      return true;
    }
    catch (e) {
      print(e);
      return false;
    }
  }


  Future <bool> uploadImage(File imageFile,String fileName)async{
    try {
      selectedImageUrl.value.isNotEmpty ? deleteFile(selectedImageUrl.value) : null;
      TaskSnapshot taskSnapshot =  await FirebaseStorage.instance.ref('uploads/$fileName').putFile(imageFile);
      selectedImageUrl.value = await taskSnapshot.ref.getDownloadURL();
      Get.snackbar('Отлично', 'Фото загружено', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kSuccess, colorText: Colors.white);
      return true;
    } on FirebaseException catch (e) {
      print(e.code);
      Get.snackbar('Упс', 'Что-то пошло не так', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
      return false;
    }
  }

  Future deleteFile(String imageUrl)async{
    try{
      await storage.refFromURL(imageUrl).delete();
      selectedImageUrl.value = "";
    }
    catch(e){
      print(e);
      Get.snackbar('Упс', 'Что-то пошло не так', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
    }
  }

  Future <bool> moderateImage(XFile file, {bool isCheck = false})async {
    if(!isCheck){return true;}
    try{
      var url = Uri.parse(ApiConstants.IMAGEURL);
      var request = await http.MultipartRequest('POST',url);
      request.fields['API_KEY']=ApiConstants.IMAGEAPI;
      request.fields['task']=ApiConstants.IMAGEAPITASK;
      request.files.add(await http.MultipartFile.fromPath("file_image", file.path));
      var response =await request.send();
      var responsed =await http.Response.fromStream(response);
      if(response.statusCode == 200){
        dynamic result = jsonDecode(responsed.body);
        if(result["final_decision"] == "OK"){
          return true;
        }
        else{
          Get.snackbar('Упс', 'Фото не соответсвует правилам приложения!', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);

          return false;
        }
      }
      else{
        Get.snackbar('Упс', 'Что-то пошло не так', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
        return false;
      }
    }
    catch(e){
      Get.snackbar('Упс', 'Что-то пошло не так', snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
      print(e);
      return false;
    }
  }


}