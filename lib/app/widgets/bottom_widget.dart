import 'package:findout/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/kcolors.dart';

class BottomNavigator extends StatelessWidget {
  Color? backColor;
  Color? activeColor;
  Color? activeText;
  Color? nonActiveText;
  Color? nonActiveColor;
  List<Map<String,dynamic>> listsItem = [
    {"icon":Icons.apps_outlined,"page":Routes.HOME},
    {"icon":FontAwesomeIcons.comment,"page":Routes.CHAT_PAGE},
    {"icon":FontAwesomeIcons.user,"page":Routes.PROFILE},
  ];

  BottomNavigator({
    this.backColor = KColors.kBottomBar,
    this.activeColor = KColors.kLightBlue,
    this.activeText = Colors.white,
    this.nonActiveText = Colors.black,
    this.nonActiveColor = Colors.transparent
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
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
            color:this.backColor
        ),
        child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: listItem(ModalRoute.of(context)?.settings.name),
        ),

      ),

    );
  }
}
