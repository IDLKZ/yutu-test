import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/models/users_model.dart';
import 'package:findout/app/data/providers/categories_provider.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'categories_model.dart';

class PostsList {
  late List<Posts>? posts;

  PostsList({@required this.posts});

  factory PostsList.fromFirebase(QuerySnapshot querySnapshot){
    List<Posts>? posts = [];
    querySnapshot.docs.forEach((element) {
      if(element!= null){
        if(element.data() != null){
          posts.add(Posts.fromJson(element.data() as Map<String,dynamic>, uid:element.id));
        }
      }
    });
    return PostsList(posts: posts);

  }

  PostsList.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts?.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  String? id;
  String? image;
  String? author;
  String? category;
  String? title;
  String? description;
  int? city;
  String? place;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? persons;
  int? status;

  Future<Category?> getCategory() async{
   return  CategoriesProvider().getCategories(this.category);
  }

  Future<Users?> getUser(){
      return UsersProvider().getUsers(this.author);

  }

  String? getTime(){
    if(this.date != null){
      return DateFormat("dd MMMM yyyy HH:mm").format(this.date ?? DateTime.now());
    }
  }

  Posts(
      {this.id,
      this.image,
      this.author,
      this.category,
      this.title,
      this.description,
      this.city,
      this.place,
      this.date,
      this.persons,
      this.createdAt,
      this.updatedAt,
      this.status});

  Posts.fromJson(Map<String, dynamic> json,{String? uid}) {
    id = uid;
    image = json['image'];
    author = json['author'];
    category = json['category'];
    title = json['title'];
    description = json['description'];
    city = json['city'];
    place = json['place'];
    date = DateTime.fromMillisecondsSinceEpoch(json["date"]??0 * 1000);
    persons = json['persons'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"]??0 * 1000);
    updatedAt = DateTime.fromMillisecondsSinceEpoch(json["updatedAt"]??0 * 1000);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['author'] = author;
    data['category'] = category;
    data['title'] = title;
    data['description'] = description;
    data['city'] = city;
    data['place'] = place;
    data['date'] = date;
    data["persons"] = persons;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    return data;
  }
}
