import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/providers/banlists_provider.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controllers/user_controller.dart';
import '../../../data/models/chats_model.dart';
import '../../../data/models/users_model.dart';

class ChatroomViewController extends GetxController {
  //TODO: Implement ChatroomViewController
  UserController _userController = Get.find<UserController>();
  final formKey = GlobalKey<FormState>();
  String? chatId;
  String? friendId;
  final CollectionReference _userRef = FirebaseFirestore.instance.collection("users");
  final CollectionReference _chatRef = FirebaseFirestore.instance.collection("chats");
  final currentUser = FirebaseAuth.instance.currentUser;
  Rx<bool> firstMessage = Rx<bool>(true);
  Rx<bool> showEmoji = Rx<bool>(false);
  Rx<Users?> teammate = Rxn<Users>();
  Rx<Chats>? chat;
  Rx<bool> isBanned = Rx<bool>(false);
  TextEditingController message = TextEditingController();
  final focusNode = FocusNode();
  Rx<bool> presence = Rx<bool>(false);
  @override
  void onInit()async {
    super.onInit();
      dynamic args = Get.arguments;
      chatId = args["chat_id"];
      friendId = args["friendId"];
      teammate.bindStream(UsersProvider().teammate(friendId));

      if(await BanlistsProvider().isFriendBanned(friendId) || await BanlistsProvider().banned(friendId)){
        isBanned.value = true;
      }

      if(chatId != null && friendId != null){focusNode.addListener(() {
          if(focusNode.hasFocus){
            showEmoji.value = false;
          }
        });
         await _chatRef.doc(chatId).collection("chats").where("receiver",isEqualTo: currentUser?.uid).get().then((value){value.docs.forEach((element) {element.reference.update({"isRead":true});});});
         await _userRef.doc(currentUser?.uid).collection("chats").doc(chatId).update({"last_time":FieldValue.serverTimestamp(), "totalUnread":0}
        );
       final early = await _userRef.doc(friendId).collection("chats").doc(chatId).get();
       if(early.exists){
         firstMessage.value = false;
       }
      }
  }

  getQuery(){
    return _chatRef.doc(chatId).collection("chats").orderBy("date",descending: true);
  }



  @override
  void onReady() {
    super.onReady();
    presence.value = true;
    if(presence.value){
      _chatRef.doc(chatId).collection("chats").snapshots().forEach((element) {
        for(var item in element.docs){
          if(item.data()["receiver"] == currentUser?.uid && item.data()["isRead"] == false){
            item.reference.update({"isRead":true});
          }
        }
      });
    }

  }

  sendMessages() async{
    if(formKey.currentState?.validate() == true){
      String msg =  message.text;
      message.text = "";
      try{
        if(firstMessage.value){
          await _userRef.doc(friendId).collection("chats").doc(chatId).set(
              {
                "chat_id":chatId,
                "connection":currentUser?.uid,
                "last_time":FieldValue.serverTimestamp(),
                "totalUnread":0
              }
          );
          firstMessage.value = false;
        }
        await _chatRef.doc(chatId).collection("chats").add(
            {
              "sender":currentUser?.uid,
              "receiver":friendId,
              "message":msg.trim(),
              "date":FieldValue.serverTimestamp(),
              "isRead":false
            }
        );

        final totalUnRead = await _chatRef.doc(chatId).collection("chats").where("receiver",isLessThanOrEqualTo: friendId).where("isRead",isEqualTo: false).get();
        await _userRef.doc(friendId).collection("chats").doc(chatId).update({"totalUnread":totalUnRead.docs.length,"last_time":FieldValue.serverTimestamp(),});
        Users? toFriend = await UsersProvider().getUsers(friendId);
        if(toFriend != null){
          if(toFriend.device_token != null){
            String myName = _userController.user?.fullname() ?? "";
            String title = "?????????? ?????????????????? " + myName;
            String body = GlobalMixin.truncateText(msg.trim(), 50);
            await FCMSender.sendNotification(toFriend.device_token.toString(), "?????????? ??????????????????", {"title":title,"body":body});
          }
        }
        

      }
      catch(e){
        GlobalMixin.warningSnackBar("??????", "???????????????????? ??????????");
        print(e);
      }
    }
  }


  @override
  void onClose() {
    presence.value = false;
      message.dispose();
  }



}
