import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helpers/kcolors.dart';
import '../controllers/delete_controller.dart';

class DeleteView extends GetView<DeleteController> {
  DeleteController _deleteController = Get.find<DeleteController>();


  @override
  Widget build(BuildContext context) {
    _deleteController.refresh();
    Widget _welcome(BuildContext context) {
      return Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.45,
            // width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg-login.png'),
                    fit: BoxFit.fill
                )
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 95, left: 20),
            child: const Text(
              'Удаление аккаунта....',
              style: TextStyle(fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: KColors.kDarkViolet),
            ),
          )
        ],
      );
    }


    return Scaffold(
      body: Column(
        children: [
          _welcome(context),
          Center(child: CircularProgressIndicator(),)
        ],
      ),
    );
  }
}
