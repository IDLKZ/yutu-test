import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UsersController extends GetxController {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Пользователи');

  void change() {
    if (customIcon.icon == Icons.search) {
      customIcon = const Icon(Icons.cancel);
      customSearchBar = const ListTile(
        leading: Icon(
          Icons.search,
          color: Colors.white,
          size: 28,
        ),
        title: TextField(
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
      update();
    }
  }
}
