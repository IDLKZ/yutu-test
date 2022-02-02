import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/modules/change_profile/views/change_profile_view.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:findout/app/widgets/bottom_widget.dart';
import 'package:findout/app/widgets/post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import '../../../data/models/posts_model.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();
  @override
  Widget build(BuildContext context) {

    Widget _header() {
      return Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height*0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/profile_bg.png'),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0)
                      ),
                      color: Colors.white,
                    )
                ),
              ),
              CircleAvatar(
                  radius: 100,
                  backgroundImage: GlobalMixin.getImage(controller.currentUser.value?.imageUrl),
                  backgroundColor: Colors.transparent,
              ),
              Positioned(
                right: 30,
                bottom: MediaQuery.of(context).size.height*0.07,
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                  child: Image.asset('assets/images/settings_img.png')
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${controller.currentUser.value?.fullname()??""}",style: TextStyle(color: KColors.kDarkViolet, fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${GlobalMixin.cityName(controller.currentUser.value?.city)??""}/${controller.currentUser.value?.getAge()??""}"),
                ),
              ],
            ),
          )
        ],
      );
    }

    Widget _cardList(){
          return Container(
            child: FirestoreQueryBuilder(
              query: FirebaseFirestore.instance.collection("posts").where("author",isEqualTo: FirebaseAuth.instance.currentUser?.uid).orderBy("date",descending: true),
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
                    return PostWidget(post:post,uid:snapshot.docs[index].id);
                  },
                );
              },
            ),
      );
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _header(),
          Expanded(
            child: _cardList(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
