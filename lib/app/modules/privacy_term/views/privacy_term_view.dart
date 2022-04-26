import 'package:findout/app/helpers/kcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/privacy_term_controller.dart';

class PrivacyTermView extends GetView<PrivacyTermController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.kMiddleBlue,
        title: Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10,),
          Text(
            "privacy_term".tr,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Column(
            children: [
              SizedBox(height: 20,),
              Text("term_of_use".tr, style: TextStyle(fontSize: 18),),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text("term_of_use_text".tr),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 20,),
              Text("privacy_policy".tr, style: TextStyle(fontSize: 18),),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text("privacy_policy_text".tr),
              ),
            ],
          ),
        ],
      )
    );
  }
}
