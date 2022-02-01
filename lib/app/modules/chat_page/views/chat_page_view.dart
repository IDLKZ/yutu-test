import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/data/models/chats_model.dart';
import 'package:findout/app/data/models/users_model.dart';
import 'package:findout/app/data/providers/chats_provider.dart';
import 'package:findout/app/data/providers/users_provider.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/widgets/bottom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/chat_page_controller.dart';

class ChatPageView extends GetView<ChatPageController> {

  @override
  Widget build(BuildContext context) {

    Widget _showDialog(BuildContext context,String? chat_id, String? friend_id) {
      return AlertDialog(
        title: Text("Выберите действие"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.userLock,color: Colors.black,),
                    title: Text("Добавить в черный список",style: TextStyle(color: Colors.black),),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                 await ChatProvider().clearMessages(chat_id, friend_id);
                  Get.back();
                },
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.trash,color: Colors.redAccent),
                    title: Text("Удалить переписку",style: TextStyle(color: Colors.redAccent),),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Отмена"))
        ],
      );
    }

    Widget _header(String imageUrl) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height*0.28,
            decoration: BoxDecoration(
               color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetX<UserController>(
                    builder: (_userController){
                          return GestureDetector(
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(_userController.user?.imageUrl??'https://img2.wtftime.ru/store/2020/07/23/O04h39gB.jpg'),
                              ),
                              title: Text("${_userController.user?.fullname()}"),

                            ),
                          );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Мессенджер",style: TextStyle(color: KColors.kDarkViolet,fontSize: 28,fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.edit,color: KColors.kDarkViolet))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
    };

    Widget _singleChat(UserChat userChat){
      return GestureDetector(
        onTap: (){
          Get.toNamed(Routes.CHATROOM_VIEW,arguments: {"chat_id":userChat.chat_id,"friendId":userChat.connection});
          },
        child: Container(
          padding: EdgeInsets.only( bottom: 20),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1,
                      color: KColors.kMiddleGrayColor
                  )
              )
          ),
          child: StreamBuilder<Users?>(
            stream: UsersProvider().teammate(userChat.connection),
            builder: (context, snapshot) {
              if(!snapshot.hasError && snapshot.hasData){
                return GestureDetector(
                  onLongPress: (){
                    showDialog(context: context, builder: (c) => _showDialog(context,userChat.chat_id, userChat.connection));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(snapshot.data?.imageUrl??'https://img2.wtftime.ru/store/2020/07/23/O04h39gB.jpg'),
                      // child: Image(image: AssetImage('assets/images/ava.png'),),
                    ),
                    title: Text("${snapshot.data?.fullname()}",style: TextStyle(color: KColors.kDarkViolet,fontSize: 20,fontWeight: FontWeight.bold),),
                    subtitle: StreamBuilder<ChatMessages?>(
                      stream: ChatProvider().getLastMessage(userChat.chat_id),
                      builder: (context, snapshot) {
                        if(!snapshot.hasError && snapshot.hasData){
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("${GlobalMixin.truncateText(snapshot.data?.message??"", 10)}",style: TextStyle(fontSize: 14),),
                          );
                        }
                        else{
                          return Text("");
                        }
                      }
                    ),
                    trailing: userChat.totalUnread! > 0
                        ? Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: KColors.kMiddleBlue
                      ),
                      child: Text("${userChat.totalUnread}", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                    )
                        :SizedBox(),

                  ),
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }

            }
          ),
        ),
      );
    }

    Widget _listChat(){
      return Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0)
            ),
            color: KColors.kChatColor,
          ),
          child: FirestoreQueryBuilder(
            query: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).collection("chats").orderBy("last_time"),
          pageSize: 4,
          builder: (BuildContext context, FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot, Widget? child) {
            if (snapshot.isFetching) {
              return Center(child: const CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('error ${snapshot.error}');
            }
            return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: snapshot.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                    }
                    UserChat userChat = UserChat.fromJson(snapshot.docs[index].data());
                    return _singleChat(userChat);
                  },
                )
            );
          }
      )
        ),
      );
    }


    return Scaffold(

      body: Column(
        children: [
          _header('assets/images/ava.png'),
          _listChat()
        ],
      ),
      bottomNavigationBar: BottomNavigator(),

    );
  }
}
