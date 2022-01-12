import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../controllers/user_controller.dart';
import '../../../helpers/global_mixin.dart';
import '../../../helpers/kcolors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    Widget _header(String imageUrl, String name) {
      return Container(
        padding: const EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(
          color: KColors.kRGBABlue,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Get.find<AuthController>().logout();
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(imageUrl),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Главная',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                            backgroundColor: KColors.kDarkenGray,
                            radius: 20,
                            child: Icon(
                              Icons.search,
                              size: 36,
                              color: Colors.black,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          backgroundColor: KColors.kDarkenGray,
                          radius: 20,
                          child: GestureDetector(
                            onTap: (){},
                            child: Icon(
                              Icons.add,
                              size: 36,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget _categoryList(List<String> categories) {
      return Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 0, right: 20, left: 20),
        child: SizedBox(
          height: 50,
        ),
      );
    }

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
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/ava.jpg'),
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

    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          GetX<UserController>(
            builder: (controller) {
              return _header('assets/images/ava.jpg',
                  "Привет, ${controller.user.name ?? ""}");
            },
          ),
          Expanded(
            child: ListView.builder(
              physics: const ScrollPhysics(),
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return _card();
              },
            ),
          )
        ],
      ),
    );
  }
}
