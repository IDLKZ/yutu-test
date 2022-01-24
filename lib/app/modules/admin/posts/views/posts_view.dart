import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/widgets/appbar_admin.dart';
import 'package:findout/app/widgets/cardPost_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../../data/models/posts_model.dart';
import '../../../../data/models/users_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/posts_controller.dart';

class PostsView extends GetView<PostsController> {

  Widget _card(Posts? post, String? uid) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.POSTS_SINGLE, arguments: uid);
        },
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
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                            AssetImage('assets/images/ava.jpg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Text(
                                  "${snapshot.data?.name}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${snapshot.data?.city}, ${snapshot.data?.age} лет',
                                  style: TextStyle(color: KColors.kSpaceGray),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              post?.image ?? 'assets/images/card-img-1.png'),
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    GlobalMixin.truncateText('${post?.title}', 60),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.userAlt),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${post?.persons}',
                        style: TextStyle(
                            fontSize: 16, color: KColors.kSpaceGray),
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
                        style: TextStyle(
                            fontSize: 16, color: KColors.kSpaceGray),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardList() {
    return GetBuilder<PostsController>(
      builder: (controller){
        return Container(
          child: FirestoreQueryBuilder(
            query: controller.getQuery(),
            pageSize: 2,
            builder: (BuildContext context, FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot, Widget? child) {
              if (snapshot.isFetching) {
                return Center(child: const CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('error ${snapshot.error}');
              }
              return ListView.builder(
                itemCount: snapshot.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                    snapshot.fetchMore();
                  }
                  final post = Posts.fromJson(snapshot.docs[index].data());
                  return _card(post, snapshot.docs[index].id);
                },
              );


            },
          ),
        );
      },

    );
  }
  Widget _categoryList() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 0, right: 20, left: 20),
      child: SizedBox(
        height: 50,
        child: Center(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categoriesList.value.length,
            itemBuilder: (context,index){
              return GetX<PostsController>(
                  builder:(controller){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                          onTap: (){
                            controller.activeCategory.value = controller.categoriesList.value[index].id.toString();
                          },
                          child: Column(
                            children: [
                              Text(
                                controller.categoriesList.value[index].titleRu ?? "",
                                style:  TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: controller.categoriesList.value[index].id.toString() == controller.activeCategory.value ? KColors.kRGBABlue : Colors.white
                                ),
                              ),
                            ],
                          )),
                    );
                  }
              );
            },

          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.kAdminBgColor,
      appBar: AppBarAdmin(title: "Посты"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _categoryList(),
          Expanded(child: _cardList()),
        ],
      ),
    );
  }
}
