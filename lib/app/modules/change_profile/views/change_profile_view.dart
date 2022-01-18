import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
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
        ],
      );
    }

    return Scaffold(
      body: Column(
        children: [
          _header('assets/images/ava.png'),
          Expanded(
            child: Text('OK'),
          )
        ],
      ),
    );
  }
}
