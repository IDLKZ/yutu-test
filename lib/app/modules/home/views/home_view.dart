import 'package:findout/app/routes/app_pages.dart';
import 'package:findout/app/widgets/advanced_input.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../controllers/user_controller.dart';
import '../../../data/models/posts_model.dart';
import '../../../data/models/users_model.dart';
import '../../../helpers/global_mixin.dart';
import '../../../helpers/kcolors.dart';
import '../../../helpers/validator_mixins.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {

  @override
  Widget build(BuildContext context) {


    Widget _searchForm(){
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child:Form(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){Get.back();},
                          child: Icon(
                              Icons.close_rounded
                          ),
                        ),
                      ],
                    ),
                    Text("Поиск по постам",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: KColors.kDarkViolet)),
                    SizedBox(height: 20,),
                    AdvancedInput(
                      icon:Icon(Icons.title),
                      hint: "Наименование",
                      controller:controller.title,
                      obscure:false,
                      func: (val){
                        return ValidatorMixin().validateText(val, true);
                      },
                      maxLength: 100,
                      ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: (){controller.searchPosts();Get.back();},
                          child: Text("Поиск",style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(KColors.kMiddleBlue)
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){Get.back();},
                          child: Text("Отмена",style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(KColors.kError)
                          ),

                        ),
                      ],
                    )
                  ],
                ),
              ) ,
            ),
          ),
        ),
      );

    }

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
                    onTap: () => Get.toNamed(Routes.PROFILE),
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
                       Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: (){
                            Get.dialog(
                              Material(child: _searchForm(),color: Colors.transparent,)
                            );
                          },
                          child: CircleAvatar(
                              backgroundColor: KColors.kDarkenGray,
                              radius: 20,
                              child: Icon(
                                Icons.search,
                                size: 36,
                                color: Colors.black,
                              )),
                        ),
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
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          backgroundColor: KColors.kDarkenGray,
                          radius: 20,
                          child: GestureDetector(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                            },
                            child: Icon(
                              Icons.power_settings_new,
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
          height: 50,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoriesList.value.length,
              itemBuilder: (context,index){
                return GetX<HomeController>(
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
                                      color: controller.categoriesList.value[index].id.toString() == controller.activeCategory.value ? KColors.kRGBABlue : Colors.black
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

    Widget _card(Posts? post, String? uid) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.POST_VIEW, arguments: uid);
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
                            image: CachedNetworkImageProvider(
                                post?.image??"http://via.placeholder.com/350x150",
                                ),
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
      return GetBuilder<HomeController>(
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
           Expanded(child: _cardList()),
        ],
      ),
    );
  }
}
