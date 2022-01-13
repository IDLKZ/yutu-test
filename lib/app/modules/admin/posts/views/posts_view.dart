import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/widgets/cardPost_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/posts_controller.dart';

class PostsView extends GetView<PostsController> {

  Widget _card() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: KColors.kLightGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding:
          const EdgeInsets.only(top: 10, bottom: 10, right: 3, left: 3),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/ava.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: const [
                        Text(
                          'Дина Искакова',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Нур-Султан, 23 лет',
                          style: TextStyle(color: KColors.kSpaceGray),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.delete),
                  )
                ],
              ),
              Container(
                height: 220,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/card-img-1.png'),
                        fit: BoxFit.contain)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  GlobalMixin.truncateText(
                      'Хочу сходить на фильм “Человек-паук: Нет пути домой”',
                      60),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Row(
                  children: const [
                    Icon(FontAwesomeIcons.userAlt),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '4',
                      style:
                      TextStyle(fontSize: 16, color: KColors.kSpaceGray),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(FontAwesomeIcons.calendarAlt),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '16 декабря, 21:00',
                      style:
                      TextStyle(fontSize: 16, color: KColors.kSpaceGray),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.kAdminBgColor,
      appBar: AppBar(
        backgroundColor: KColors.kAdminBgColor,
        title: Text('Посты'),
        actions: [
          IconButton(
              onPressed: () => Get.find<AuthController>().logout(),
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index){
            return _card();
            // return CardPost(url, name, city, age, cardImg, cardTitle, countPeople, date);
          },
        ),
      ),
    );
  }
}
