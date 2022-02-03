import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/data/models/users_model.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {

  _usersList(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child:RefreshIndicator(
        child: GetBuilder<UsersController>(
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
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return ListView.builder(
                      itemCount: snapshot.docs.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                          snapshot.fetchMore();
                        }
                        return controller.userCard(Users.fromJson(snapshot.docs[index].data()), snapshot.docs[index].id);
                      },
                    );

                  },
                ),
              );
            }
        ),
        onRefresh: () async {
          controller.refreshChangeListener.refreshed = true;
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.kAdminBgColor,
      appBar: AppBar(
        backgroundColor: KColors.kAdminBgColor,
        title: GetBuilder<UsersController>(
            builder: (_) => controller.customSearchBar
        ),
        actions: [
          IconButton(
            onPressed: controller.change,
            icon: GetBuilder<UsersController>(
                builder: (_) => controller.customIcon
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: _usersList(),
      ),
    );
  }
}
