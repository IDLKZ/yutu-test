import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/models/chats_model.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatProvider extends GetConnect {

  final CollectionReference _userRef = FirebaseFirestore.instance.collection("users");
  final CollectionReference _chatRef = FirebaseFirestore.instance.collection("chats");
  final auth = FirebaseAuth.instance;


   addNewConnection(String? friendID)async{
     if(FirebaseAuth.instance.currentUser?.uid != friendID){
       String? chat_id;
       List initial = [auth.currentUser?.uid, friendID];
       for(var item in initial){
         initial = List.from(initial.reversed);
         final resultChat = await _chatRef.where("connection",isEqualTo: initial).get();
         if(resultChat.docs.length > 0){
           resultChat.docs.forEach((e){
             chat_id = e.id;
           }
           );
         }
       }
       if(chat_id == null){
         final userChat = await _userRef.doc(auth.currentUser?.uid).collection("chats").where("connection",isEqualTo: friendID).get();
         userChat.docs.forEach((element) {
           chat_id = element.id;
         });
         if(chat_id != null){
           final chatDoc = await _chatRef.doc(chat_id).set(
               {
                 "connection":[
                   auth.currentUser?.uid,
                   friendID,
                 ],
               }
           );
         }
         else{
           final chatDoc = await _chatRef.add(
               {
                 "connection":[
                   auth.currentUser?.uid,
                   friendID,
                 ],
               }
           );
           chat_id = chatDoc.id;
         }
       }
       final connectionWithUser =  await _userRef.doc(auth.currentUser?.uid).collection("chats").doc(chat_id).get();
       if(!connectionWithUser.exists){
         _userRef.doc(auth.currentUser?.uid).collection("chats").doc(chat_id).set(
             {
               "chat_id":chat_id,
               "connection":friendID,
               "last_time":DateTime.now().millisecondsSinceEpoch,
               "totalUnread":0
             }
         );
       }

       if(chat_id != null){
         Get.toNamed(Routes.CHATROOM_VIEW,arguments: {"chat_id":chat_id,"friendId":friendID});
       }
     }






  }


  Stream<ChatMessages?> getLastMessage(String? chatId) {
    return _chatRef.doc(chatId).collection("chats").orderBy("date",descending: true).limit(1).snapshots().map((event){
      return event.docs.length > 0 ? ChatMessages.fromJson(event.docs.first.data()) : null;
    });
   }


   Future clearMessages(String? chat_id, String? friend_id)async{
     try{
       await _userRef.doc(auth.currentUser?.uid).collection('chats').doc(chat_id).delete();
       await _userRef.doc(friend_id).collection('chats').doc(chat_id).delete();
       await _chatRef.doc(chat_id).delete();
     }
     catch(e){
       GlobalMixin.warningSnackBar("Упс", "Что-то пошло не так");
     }

   }




}