import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../data/models/posts_model.dart';
import '../../../widgets/post_widget.dart';
import '../controllers/wishlists_controller.dart';

class WishlistsView extends GetView<WishlistsController> {


  Widget _cardList() {
    return Expanded(
      child: GetX<WishlistsController>(
        builder: (controller){
          return Container(
            child: FirestoreQueryBuilder(
              query: controller.getQuery(),
              pageSize: 2,
              builder: (BuildContext context, FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot, Widget? child) {
                if (snapshot.isFetching) {
                  return Center(child: const CircularProgressIndicator());
                }
                if(!snapshot.hasData){
                  if (snapshot.hasError) {
                    return Center(child: CircularProgressIndicator(color: Colors.red,),);
                  }
                }
                return ListView.builder(
                  itemCount: snapshot.docs.length,
                  itemBuilder: (context, index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                    }
                    final post = Posts.fromJson(snapshot.docs[index].data());
                    return PostWidget(post:post,uid: snapshot.docs[index].id);
                  },
                );


              },
            ),
          );
        },

      ),
    );
  }



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('liked_posts'.tr,style: TextStyle(color: Colors.black,fontSize: 16),),
        centerTitle: true,
        backgroundColor: KColors.kRGBABlue,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.angleLeft,color: Colors.black,),
          onPressed: (){
            Get.offAllNamed(Routes.SETTINGS);
          },
        ),
      ),

      body: Column(
        children: [
          _cardList(),
        ],
      )
    );
  }
}
