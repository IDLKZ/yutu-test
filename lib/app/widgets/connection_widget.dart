import 'package:findout/app/controllers/connection_controller.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ConnectionWidget extends StatelessWidget {

  final  isConnected = Get.find<ConnectionController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetX<ConnectionController>(
          builder: (controller){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.tired, size: 50,),
                SizedBox(height: 10,),
                Text(controller.isConnected.value ? 'OK' : 'Проверьте интернет соединение'),
                ElevatedButton(onPressed: (){Get.offAllNamed(AppPages.INITIAL);}, child: Text("home"))
              ],
            );
          },
        ),
      ),
    );
  }
}
