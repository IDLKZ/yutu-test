import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:intl/intl.dart';

class UsersList {
  late List<Users>? users;

  UsersList({required this.users});

  UsersList.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users?.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? id;
  String? name;
  String? surname;
  String? age;
  int? city;
  String? email;
  String? phone;
  String? imageUrl;
  bool? isAdmin = false;
  int? status = 0;

  String fullname(){
    return  (this.name??"") +" "+ (this.surname??"");
  }

   String getAge(){
     return (DateTime.now().toUtc().difference(GlobalMixin.convertToDate(this.age)).inDays/365).floor().toString() + " лет";
  }

  Users(
      {this.id,
      this.name,
      this.surname,
      this.age,
      this.city,
      this.email,
      this.phone,
      this.imageUrl,
      this.isAdmin,
      this.status});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    age = json['age'];
    city = json['city'];
    email = json['email'];
    phone = json['phone'];
    imageUrl = json['imageUrl'];
    isAdmin = json['isAdmin'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['age'] = age;
    data['city'] = city;
    data['email'] = email;
    data['phone'] = phone;
    data['imageUrl'] = imageUrl;
    data['isAdmin'] = isAdmin;
    data['status'] = status;
    return data;
  }

}

class UserChat{
  String? chat_id;
  String? connection;
  Timestamp? last_time;
  int? totalUnread;

  UserChat({
    this.chat_id,
    this.connection,
    this.last_time,
    this.totalUnread,
  });

  UserChat.fromJson(Map<String, dynamic> json){
    chat_id = json["chat_id"];
    connection = json["connection"];
    last_time = json["last_time"];
    totalUnread = json["totalUnread"];
  }



}
