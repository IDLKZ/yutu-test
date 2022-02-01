import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Chats{
  Array? connection;
  final date = DateTime.now().toIso8601String();

  Chats({
    this.connection
  });


  Chats.fromJson(Map<String, dynamic> json) {
    connection = json["connection"];
  }

  Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
    data["connection"] = connection;
     return data;
  }



}

class ChatMessages{
  String? sender;
  String? receiver;
  String? message;
  bool? isRead;
  int? date;


  getDate(){
    return  DateFormat("dd.MM.yyyy HH:mm").format(DateTime.fromMillisecondsSinceEpoch(this.date??0));

  }



  ChatMessages.fromJson(Map<String, dynamic> json) {
    sender = json["sender"];
    receiver = json["receiver"];
    message = json["message"];
    isRead = json["isRead"];
    date = json["date"];
  }



}