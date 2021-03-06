import 'package:findout/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/kcolors.dart';

class BottomNavigator extends StatelessWidget {
  double height = 60;



  Color? backColor;
  Color? activeColor;
  Color? activeText;
  Color? nonActiveText;
  Color? nonActiveColor;
  List<Map<String,dynamic>> listsItem = [
    {"icon":Icons.apps_outlined,"page":Routes.HOME},
    {"icon":FontAwesomeIcons.comment,"page":Routes.CHAT_PAGE},
    {"icon":FontAwesomeIcons.user,"page":Routes.PROFILE,},
  ];

  BottomNavigator({
    this.backColor = KColors.kBottomBar,
    this.activeColor = KColors.kLightBlue,
    this.activeText = Colors.white,
    this.nonActiveText = Colors.black,
    this.nonActiveColor = Colors.transparent,
    this.height = 70
});

  List<Widget> listItem(String? localPath){
    List<Widget> lists = [];
    for(Map<String,dynamic>item in listsItem){
      lists.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            color: localPath.toString() == item["page"] ?this.activeColor : this.nonActiveColor ,
          ),
          child: IconButton(
              onPressed: (){Get.offAllNamed(item["page"]);},
              icon: Icon(item["icon"]),
            color: localPath.toString() == item["page"] ?this.activeText : this.nonActiveText ,
          ),
        )
      );
    }
    return lists;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      padding: EdgeInsets.only(bottom: 10,top: 5),
      decoration: BoxDecoration(
          color:this.backColor,

      ),
      child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceAround,
        children: listItem(ModalRoute.of(context)?.settings.name),
      ),

    );
  }
}
