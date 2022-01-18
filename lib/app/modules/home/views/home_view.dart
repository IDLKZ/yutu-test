import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/data/models/categories_model.dart';
import 'package:findout/app/data/providers/posts_provider.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../controllers/user_controller.dart';
import '../../../data/models/posts_model.dart';
import '../../../data/models/users_model.dart';
import '../../../helpers/global_mixin.dart';
import '../../../helpers/kcolors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  UserController _userController = Get.find<UserController>();
  PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    Widget _header(String imageUrl, String name) {
      return Container(
        padding: const EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height * 0.35,
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
                            onTap: () {
                              Get.toNamed(Routes.POST_CREATE);
                            },
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

    Widget _categoryList() {
      return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 0, right: 20, left: 20),
        child: SizedBox(
          height: 30,
          child: GetX<HomeController>(builder: (controller) {
            if (controller != null) {
              if (controller.categoryList.value != null) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      controller.categoryList.value?.categoriesList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: (){
                          controller.activeCategory.value = controller.categoryList.value?.categoriesList![index].id;
                          },
                          child: Column(
                            children: [
                              Text(
                        controller.categoryList.value?.categoriesList![index].titleRu ?? "",
                        style:  TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                        ),
                      ),
                            ],
                          )),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
        ),
      );
    }

    Widget _card(Posts? post) {
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
                FutureBuilder<Users?>(
                 future: post?.getUser(),
                  builder: (context,snapshot){
                   if(snapshot.connectionState == ConnectionState.done){
                     return Row(
                       children: [
                         const CircleAvatar(
                           radius: 30,
                           backgroundImage: AssetImage('assets/images/ava.jpg'),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 10.0),
                           child: Column(
                             children: [
                               Text(
                                 "${snapshot.data?.name}",
                                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                 textAlign: TextAlign.left,
                               ),
                               SizedBox(
                                 height: 5,
                               ),
                               Text(
                                 '${snapshot.data?.city}, ${snapshot.data?.age} лет ${controller.activeCategory.value}',
                                 style: TextStyle(color: KColors.kSpaceGray),
                               )
                             ],
                           ),
                         )
                       ],
                     );
                   }
                   else{
                     return CircularProgressIndicator();
                   }
                  },
                ),
                SizedBox(height: 10,),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(post?.image??'assets/images/card-img-1.png'),
                          fit: BoxFit.contain)),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    GlobalMixin.truncateText(
                        '${post?.title}',
                        60),
                    textAlign: TextAlign.left,
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
                    children:  [
                      Icon(FontAwesomeIcons.userAlt),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${post?.persons} ${controller.activeCategory.value}',
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
                        '${post?.getTime()}',
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

    Widget _cardList(){
      return GetX<HomeController>(
        builder: (controller){
          return RefreshIndicator(
            child: PaginateFirestore(
              isLive: false,
              itemsPerPage: 20,
              itemBuilder: (context, documentSnapshots, index) {
                return   _card(Posts.fromJson(documentSnapshots[index].data() as Map<String,dynamic>,uid: documentSnapshots[index].id));
              },
              // orderBy is compulsary to enable pagination
              query: controller.postsQuery.value,
              listeners: [
                refreshChangeListener,
              ],
              itemBuilderType: PaginateBuilderType.listView,
            ),
            onRefresh: () async {
              refreshChangeListener.refreshed = true;
            },
          );
        },

      );

    }


    return Scaffold(
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetX<UserController>(
            builder: (controller) {
              return _header('assets/images/ava.jpg',
                  "Привет, ${controller.user?.name ?? ""}");
            },
          ),
          _categoryList(),
          Expanded(
            child: _cardList()
          )
        ],
      ),
    );
  }
}
