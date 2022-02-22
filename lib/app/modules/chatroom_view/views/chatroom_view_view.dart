import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findout/app/data/models/chats_model.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/helpers/validator_mixins.dart';
import 'package:findout/app/widgets/emoji_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/advanced_input.dart';
import '../controllers/chatroom_view_controller.dart';

class ChatroomViewView extends GetView<ChatroomViewController> {
  @override
  Widget build(BuildContext context) {
    
    Widget message(ChatMessages chatMessages) {
      bool isMyMessage =
          chatMessages.sender == FirebaseAuth.instance.currentUser?.uid;
      return Padding(
        padding: isMyMessage
            ? EdgeInsets.fromLTRB(Get.width * 0.2, 10, 0, 10)
            : EdgeInsets.fromLTRB(0, 10, Get.width * 0.2, 10),
        child: Align(
          alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isMyMessage ? KColors.kMyMessages : KColors.kFriendMessages,
              borderRadius: isMyMessage
                  ? BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))
                  : BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Align(
                    alignment:Alignment.centerLeft,
                    child: Text(
                      "${chatMessages.message}",
                      style: isMyMessage
                          ? TextStyle(color: Colors.black,fontSize: 18)
                          : TextStyle(color: Colors.black,fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${chatMessages.getDate()}",
                          style: isMyMessage
                              ? TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12

                          )
                              : TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          )),
                      SizedBox(width: 5,),
                      isMyMessage ?
                      Icon(
                        chatMessages.isRead == true ? FontAwesomeIcons.checkDouble :FontAwesomeIcons.check ,
                        size: 12,
                        color: Colors.lightBlueAccent,
                      )
                          :SizedBox()
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget chatList() {
      return FirestoreQueryBuilder(
          query: controller.getQuery(),
          pageSize: 4,
          builder: (BuildContext context,
              FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot,
              Widget? child) {
            if (snapshot.isFetching) {
              return Center(child: const CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  reverse: true,
                  itemCount: snapshot.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                    }
                    ChatMessages chatMessages = ChatMessages.fromJson(snapshot.docs[index].data());
                    return message(chatMessages);
                  },
                ));
          });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff89D2F1),
          title: GetX<ChatroomViewController>(
            builder: (controller) {
              return ListTile(
                onTap: (){
                  if(controller.teammate.value?.email != null){
                    Get.toNamed(Routes.PROFILE,arguments: controller.teammate.value?.id);
                  }
                },
                leading: CircleAvatar(
                  backgroundImage: GlobalMixin.getImage(controller.teammate.value?.imageUrl),
                ),
                title: Text(
                  controller.teammate.value?.fullname() ?? "",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: IconButton(
                onPressed: () {
                  Get.offAllNamed(Routes.CHAT_PAGE);
                },
                icon: Icon(FontAwesomeIcons.angleLeft,color: Colors.black,),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: chatList()),
            GetX<ChatroomViewController>(
              builder: (_chatroomController){
                return Container(
                  color: KColors.kLightGray,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    child: _chatroomController.isBanned.value
                    ?Text("you_are_in_banlist".tr)
                    : Row(
                      children: [
                        Expanded(
                          child: Form(
                          key: controller.formKey,
                          child: AdvancedInput(
                            controller: controller.message,
                            icon: IconButton(
                              onPressed: () {
                                controller.focusNode.unfocus();
                                controller.showEmoji.value = true;
                              },
                              icon: Icon(FontAwesomeIcons.smile,color: Color(
                                  0xff848383),),
                            ),
                            hint: "Write a message",
                            obscure: false,
                            maxLines: 1,
                            func: (val) {
                              return ValidatorMixin()
                                  .validateText(val, true, maxLength: 1000);
                            },
                            focusNode: controller.focusNode,
                            underline: true,
                          ),
                        )
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff9ed9f3),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.sendMessages();
                            },
                            icon: Icon(FontAwesomeIcons.paperPlane,color: Colors.white,size: 20,),
                          ),
                        ),
                      ],
                    )

                );
              },
            ),


            GetX<ChatroomViewController>(
              builder: (controller){
                if(controller.showEmoji.value){
                  return Expanded(
                      child: EmojiPickerWidget(
                        textEditingController: controller.message,
                      ));
                }
                else{
                  return SizedBox();
                }
              },),
          ],
        ));
  }
}
