class Wishlists {
  List<Wishlist>? wishlists;

  Wishlists({this.wishlists});

  Wishlists.fromJson(Map<String, dynamic> json) {
    if (json['wishlists'] != null) {
      wishlists = <Wishlist>[];
      json['wishlists'].forEach((v) {
        wishlists?.add(Wishlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (wishlists != null) {
      data['wishlists'] = wishlists?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wishlist {
  String? user;
  String? post;

  Wishlist({this.user, this.post});

  Wishlist.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user'] = user;
    data['post'] = post;
    return data;
  }
}
