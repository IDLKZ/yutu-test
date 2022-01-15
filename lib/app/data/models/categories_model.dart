class Categories {
  List<CategoriesList>? categoriesList;

  Categories({this.categoriesList});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['categoriesList'] != null) {
      categoriesList = <CategoriesList>[];
      json['categoriesList'].forEach((v) {
        categoriesList?.add(CategoriesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (categoriesList != null) {
      data['categoriesList'] = categoriesList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesList {
  String? id;
  String? titleRu;
  String? titleEn;
  int? status;

  CategoriesList({this.id, this.titleRu, this.titleEn, this.status});

  CategoriesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
