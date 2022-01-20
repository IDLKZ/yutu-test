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
  int? age;
  String? city;
  String? email;
  String? phone;
  String? imageUrl;
  bool? isAdmin = false;
  int? status = 0;

  String fullname(){
    return  (this.name??"") +" "+ (this.surname??"");
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
