import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/models/users_model.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class UsersController extends GetxController {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Пользователи');
  Rx<bool> isSearch = false.obs;
  TextEditingController queryStr = TextEditingController();
  PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();
  Rx<Query> usersQuery = Rx<Query>(FirebaseFirestore.instance.collection("users").orderBy("name"));


  searchPosts(){
    Query query = FirebaseFirestore.instance.collection("users");
    if(queryStr.text.isNotEmpty){
      query =
          query.where("name",isGreaterThanOrEqualTo: queryStr.text.trim())
              .where("name",isLessThan: queryStr.text.trim() + 'z');
      usersQuery.value = query;
    } else {
      usersQuery.value = FirebaseFirestore.instance.collection("users").orderBy("name");
    }
    update();
  }

  getQuery<Query>(){
    return usersQuery.value;
  }

  userCard(Users user,String? id){
    if(user.isAdmin == false) {
      return Card(
        color: KColors.kAdminBgColor,
        child: ListTile(
          onTap: ()=> {},
          leading: CircleAvatar(
            radius: 15,
            backgroundImage: GlobalMixin.getImage(user.imageUrl),
          ),
          title: Text('${user.name ?? ""}', style: TextStyle(color: Colors.white),),
          subtitle: Text('${user.surname ?? ""}', style: TextStyle(color: Colors.white),),
          trailing: IconButton(
            onPressed: () {UsersProvider().deleteUser(user.id);},
            icon: Icon(Icons.delete, color: Colors.white,),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void change() {
    if (customIcon.icon == Icons.search) {
      customIcon = const Icon(Icons.cancel);
      customSearchBar = ListTile(
        leading: GestureDetector(
          onTap: (){searchPosts();},
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: TextField(
          onTap: (){searchPosts();},
          controller: queryStr,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'поиск по имени...',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
      update();
    } else {
      customIcon = const Icon(Icons.search);
      customSearchBar = const Text('Пользователи');
      usersQuery.value = FirebaseFirestore.instance.collection("users").orderBy("name");
      queryStr.value = TextEditingValue.empty;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    queryStr.addListener(() {searchPosts();});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    queryStr.dispose();
  }
}
