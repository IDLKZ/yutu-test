import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/banlists_model.dart';

class BanlistsProvider extends GetConnect {

  final CollectionReference _userRef = FirebaseFirestore.instance.collection("users");
  final CollectionReference _banRef = FirebaseFirestore.instance.collection("banlist");
  final auth = FirebaseAuth.instance;


    banPerson(String? friend) async{
      bool isBanned = await isFriendBanned(friend);
      if(!isBanned){
        await _banRef.doc().set({
          "initiator":auth.currentUser?.uid,
          "banned":friend
        });
      }

    }

    deleteBan(String? friend)async{
      bool isBanned = await isFriendBanned(friend);
      if(isBanned){
       final ban =  await _banRef.where("initiator", isEqualTo: auth.currentUser?.uid).where("banned",isEqualTo: friend).get();
          for(var item in ban.docs){
            item.reference.delete();
          }
      }
    }


    Future <bool> isFriendBanned (String? friend)async{
     final iBanned = await _banRef.where("initiator", isEqualTo: auth.currentUser?.uid).where("banned",isEqualTo: friend).get();
      if(iBanned.docs.length >0){
        return true;
      }
      else{
        return false;
      }
    }

    Future <bool> banned (String? friend)async{
      final iBanned = await _banRef.where("initiator", isEqualTo: friend).where("banned",isEqualTo: auth.currentUser?.uid).get();
      if(iBanned.docs.length >0){
        return true;
      }
      else{
        return false;
      }
    }





}
