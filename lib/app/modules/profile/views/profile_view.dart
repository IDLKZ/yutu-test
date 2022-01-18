import 'package:findout/app/modules/change_profile/views/change_profile_view.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../data/models/posts_model.dart';
import '../../../data/models/users_model.dart';
import '../../../helpers/global_mixin.dart';
import '../../../helpers/kcolors.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();
  @override
  Widget build(BuildContext context) {

    Widget _header(String imageUrl) {
      return Stack(
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
              backgroundImage: AssetImage(imageUrl),
              backgroundColor: Colors.transparent,
          ),
          Positioned(
            right: 30,
            bottom: MediaQuery.of(context).size.height*0.07,
            child: GestureDetector(
              onTap: () => Get.to(ChangeProfileView()),
              child: Image.asset('assets/images/settings_img.png')
            ),
          )
        ],
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _header('assets/images/ava.png'),
          Expanded(
            child: _cardList(),
          )
        ],
      ),
    );
  }
}
