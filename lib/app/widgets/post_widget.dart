import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../data/models/posts_model.dart';
import '../data/models/users_model.dart';
import '../helpers/global_mixin.dart';
import '../helpers/kcolors.dart';
import '../routes/app_pages.dart';

class PostWidget extends StatelessWidget {
  Posts? post;
  String? uid;
  PostWidget({@required this.post,@required this.uid});



  @override
  Widget build(BuildContext context) {
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
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data?.fullname()}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${GlobalMixin.cityName(snapshot.data?.city) ?? ""}, ${snapshot.data?.getAge()}',
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
                      borderRadius: BorderRadius.circular(30.0),
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
}
