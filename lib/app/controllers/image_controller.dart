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
  Rx<bool>imageUploaded = Rx<bool>(false);
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

  Future <void> pickImage(ImageSource source,{bool delete = true})async {
    try {
      final selectedFile = await picker.pickImage(source: source,imageQuality: 60);
      imageUploaded.value = true;
      if (selectedFile != null) {
        selectedImagePath.value = selectedFile.path;
        bool isModerate = true;
        bool result = isModerate ? await uploadImage(File(selectedFile.path), basename(selectedFile.path),delete:delete) : false;
        if (result) {
          Get.snackbar('success'.tr, 'image_is_ready'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kSuccess, colorText: Colors.white);
        }
        else {
          selectedImageUrl.value = "";
        }
      }
    }
    catch (e) {
      print(e);
    }
    imageUploaded.value = false;
  }


  Future <bool> uploadImage(File imageFile,String fileName,{bool delete = true})async{
    try {
      if(selectedImageUrl.value.isNotEmpty && delete){
        await deleteFile(selectedImageUrl.value);
      }
      TaskSnapshot taskSnapshot =  await FirebaseStorage.instance.ref('uploads/$fileName').putFile(imageFile);
      selectedImageUrl.value = await taskSnapshot.ref.getDownloadURL();
      Get.snackbar('success'.tr, 'image_is_uploaded'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kSuccess, colorText: Colors.white);
      return true;
    } on FirebaseException catch (e) {
      print(e.code);
      Get.snackbar('oops'.tr, 'something_went_wrong'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
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
      Get.snackbar('oops'.tr, 'something_went_wrong'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
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
          Get.snackbar('oops'.tr, 'incorrect_image'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
          return false;
        }
      }
      else{
        Get.snackbar('oops'.tr, 'something_went_wrong'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
        return false;
      }
    }
    catch(e){
      Get.snackbar('oops'.tr, 'something_went_wrong'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: KColors.kWarning, colorText: Colors.white);
      print(e);
      return false;
    }
  }


}