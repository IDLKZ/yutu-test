import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/models/users_model.dart';
import 'package:findout/app/data/providers/banlists_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bans_controller.dart';

class BansView extends GetView<BansController> {
  PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    Widget _userCard(Users? user){
      return user != null
      ?Card(
        child: ListTile(
          trailing:IconButton(icon: Icon(FontAwesomeIcons.unlock),onPressed: (){
            controller.deleteBan(user.id);
          }),
          title: Text(user.fullname()),
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: GlobalMixin.getImage(user.imageUrl),
          ) ,
        ),
      )
          : SizedBox();
    }


    Widget _bannedList(){
      return GetX<BansController>(
        builder: (controller){
          return Container(
            child:
            controller.bannedList.value.length != 0
                ?
            (!controller.isLoading.value
                ? RefreshIndicator(
              child: PaginateFirestore(
                isLive: true,
                itemsPerPage: 20,
                itemBuilder: (context, documentSnapshots, index) {
                  return _userCard(Users.fromJson(documentSnapshots[index].data() as Map<String,dynamic>));
                },
                // orderBy is compulsary to enable pagination
                query: FirebaseFirestore.instance.collection('users').where(FieldPath.documentId, whereIn: controller.bannedList.value),
                listeners: [
                  refreshChangeListener,
                ],
                itemBuilderType: PaginateBuilderType.listView,
              ),
              onRefresh: () async {
                refreshChangeListener.refreshed = true;
              },
            )
                : Center(child: CircularProgressIndicator(),)
            )
            :Center(
              child: SizedBox(),),
          );

        },

      );


    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.kMiddleBlue,
        title: Text('blacklists'.tr,style: TextStyle(color: Colors.black,fontSize: 16),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.angleLeft,color: Colors.black,),
          onPressed: (){
            Get.offAllNamed(Routes.SETTINGS);
          },
        ),
      ),
      body: Container(
        child:_bannedList(),
      )
    );
  }
}
