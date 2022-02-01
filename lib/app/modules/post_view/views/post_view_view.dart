import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/modules/post_edit/views/post_edit_view.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../data/models/categories_model.dart';
import '../../../data/models/posts_model.dart';
import '../../../data/models/users_model.dart';
import '../../../data/providers/chats_provider.dart';
import '../../../helpers/kcolors.dart';
import '../controllers/post_view_controller.dart';

class PostViewView extends GetView<PostViewController> {

  Widget _editDeletePost() {
    if (Get.find<UserController>().auth.currentUser!.uid ==
        controller.post.value?.author) {
      return Positioned(
        right: 20,
        bottom: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.POST_EDIT, arguments: controller.uid);
              },
              child: CircleAvatar(
                backgroundColor: KColors.kDarkenGray,
                radius: 25,
                child: Icon(
                  FontAwesomeIcons.edit,
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                    title: "Вы уверены?",
                    middleText: "Удаленный пост невозможно восстановить",
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: (){controller.deletePost(); Get.back();},
                              child: Text("Удалить",style: TextStyle(color: Colors.white),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(KColors.kError)
                              ),

                          ),
                          ElevatedButton(
                              onPressed: () => {Get.back()},
                              child: Text("Отмена",style: TextStyle(color: Colors.white),),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(KColors.kLightBlue)
                          ),

                          ),
                        ],
                      )
                    ]);
              },
              child: CircleAvatar(
                backgroundColor: KColors.kDarkenGray,
                radius: 25,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Positioned(
        right: 20,
        bottom: 0,
        child: CircleAvatar(
          backgroundColor: KColors.kDarkenGray,
          radius: 25,
          child: Icon(
            FontAwesomeIcons.solidHeart,
            color: Colors.red,
          ),
        ),
      );
    }
  }

  Widget _floatButton(){
    if(FirebaseAuth.instance.currentUser?.uid != controller.post.value?.author){
      return FloatingActionButton.extended(
        onPressed: () {
          ChatProvider().addNewConnection(controller.post.value?.author);
        },
        label: Row(
          children: const [
            Text(
              "Написать",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(FontAwesomeIcons.arrowRight)
          ],
        ),
        // icon: const Icon(Icons.thumb_up),
        backgroundColor: KColors.kMiddleBlue,
      );
    }
    else{
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<PostViewController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.425,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  controller.post.value?.image ??"http://via.placeholder.com/350x150",),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.425,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0)),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 30,
                      child: GestureDetector(
                        onTap: () {
                          Get.offAllNamed(Routes.HOME);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: KColors.kLightGray,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(FontAwesomeIcons.chevronLeft),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 30,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 7, right: 15),
                        decoration: BoxDecoration(
                            color: KColors.kRGBABlue,
                            borderRadius: BorderRadius.circular(35)),
                        child: FutureBuilder<Users?>(
                          future: controller.post.value?.getUser(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage('assets/images/ava.jpg'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${snapshot.data?.fullname()}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${GlobalMixin.cityName(snapshot.data?.city) ?? ""}  ${snapshot.data?.getAge() ?? ""}',
                                          style: TextStyle(
                                              color: KColors.kSpaceGray),
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
                      ),
                    ),
                    _editDeletePost()
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<Category?>(
                                future: controller.post.value?.getCategory(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Text(
                                      '${snapshot.data?.titleRu ?? ""}',
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w600),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${controller.post.value?.title ?? ""}",
                                style: TextStyle(
                                    fontSize: 16, color: KColors.kSpaceGray),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                height: 20,
                                thickness: 2,
                              ),
                              Text(
                                "${controller.post.value?.description ?? ""}",
                                style: TextStyle(
                                    fontSize: 16, color: KColors.kSpaceGray),
                              ),
                              const Divider(
                                height: 20,
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: KColors.kDarkenGray,
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.location_on_outlined,
                                        color: KColors.kMiddleBlue,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Локация',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: KColors.kAdminBgColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${GlobalMixin.cityName(controller.post.value?.city) ?? ""} / ${controller.post.value?.place ?? ""}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: KColors.kDarkenGray,
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        FontAwesomeIcons.calendarAlt,
                                        color: KColors.kMiddleBlue,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Дата',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: KColors.kDarkenGray,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${controller.post.value?.getTime() ?? ""}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: KColors.kDarkenGray,
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        FontAwesomeIcons.userCircle,
                                        color: KColors.kMiddleBlue,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Кол-во свободных мест',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: KColors.kDarkenGray,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${controller.post.value?.persons ?? ""}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: _floatButton(),

    );
  }
}
