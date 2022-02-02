import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/data/providers/chats_provider.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/modules/change_profile/views/change_profile_view.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:findout/app/widgets/bottom_widget.dart';
import 'package:findout/app/widgets/post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import '../../../data/models/posts_model.dart';
import '../../../data/models/users_model.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();
  UserController _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    Widget _header(Users? user) {
      return Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/profile_bg.png'),
                        fit: BoxFit.cover)),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0)),
                      color: Colors.white,
                    )),
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: GlobalMixin.getImage(
                    user?.imageUrl),
                backgroundColor: Colors.transparent,
              ),
              user?.id ==_userController.user?.id
              ?Positioned(
                right: 30,
                bottom: MediaQuery.of(context).size.height * 0.07,
                child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                    child: Icon(FontAwesomeIcons.cog)
                ),
              ):SizedBox(),
            ],
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${user?.fullname() ?? ""}",
                    style: TextStyle(
                        color: KColors.kDarkViolet,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "${GlobalMixin.cityName(user?.city) ?? ""}/${user?.getAge() ?? ""}"),
                ),
              ],
            ),
          ),
          user?.id !=_userController.user?.id
              ?Container(
            child: GetX<ProfileController>(
              builder: (controller){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){ChatProvider().addNewConnection(user?.id);}, icon: Icon(FontAwesomeIcons.comment)),
                    controller.isBanned.value
                        ? IconButton(onPressed: (){controller.clearBan();}, icon: Icon(FontAwesomeIcons.userLock))
                        : IconButton(onPressed: (){controller.banUser();}, icon: Icon(FontAwesomeIcons.unlockAlt)),
                  ],
                );
              },),
          )
              :SizedBox(),

        ],
      );
    }

    Widget _cardList(Users? user) {
      return Container(
        child: FirestoreQueryBuilder(
          query: FirebaseFirestore.instance
              .collection("posts")
              .where("author",
                  isEqualTo: user?.id)
              .orderBy("date", descending: true),
          pageSize: 2,
          builder: (BuildContext context,
              FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot,
              Widget? child) {
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
                return PostWidget(post: post, uid: snapshot.docs[index].id);
              },
            );
          },
        ),
      );
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Users?>(
        future: UsersProvider().getUsers(controller.userId.value),
        builder: (context, snapshot) {
          if (!snapshot.hasError) {
            if (snapshot.hasData) {
              return Column(children: [
                _header(snapshot.data),
                Expanded(
                  child: _cardList(snapshot.data),
                )
              ]);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
