import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesList {
  List<Category>? categoriesList;

  CategoriesList({this.categoriesList});

  CategoriesList.fromJson(Map<String, dynamic> json) {
    if (json['categoriesList'] != null) {
      categoriesList = <Category>[];
      json['categoriesList'].forEach((v) {
        categoriesList?.add(Category.fromJson(v));
      });
    }
  }

  factory CategoriesList.fromFirebase(QuerySnapshot querySnapshot){
    List<Category>? _categoriesList = [];
    querySnapshot.docs.forEach((element) {
      if(element!= null){
        if(element.data() != null){
          _categoriesList.add(Category.fromJson(element.data() as Map<String,dynamic>,uid:element.id));
        }
      }
    });
    return CategoriesList(categoriesList: _categoriesList);

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (categoriesList != null) {
      data['categoriesList'] = categoriesList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? id;
  String? titleRu;
  String? titleEn;
  int? status;

  Category({this.id, this.titleRu, this.titleEn, this.status});

  Category.fromJson(Map<String, dynamic> json,{String? uid}) {
    id = uid;
    titleRu = json['titleRu'];
    titleEn = json['titleEn'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['titleRu'] = titleRu;
    data['titleEn'] = titleEn;
    data['status'] = status;
    return data;
  }
}
