import 'package:findout/app/controllers/connection_controller.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ConnectionWidget extends StatelessWidget {

  final  isConnected = Get.find<ConnectionController>();
  final  user = Get.find<UserController>();

  Widget routing(ConnectionController controller){
    if(controller.isConnected.value != false){
      if(user.user != null){
        //if IS ADMIN
        if(user.user?.isAdmin == true){
          return ElevatedButton(onPressed: (){Get.offAllNamed(Routes.DASHBOARD);}, child: Text("dashboard".tr));
        }
        else{
          return ElevatedButton(onPressed: (){Get.offAllNamed(Routes.HOME);}, child: Text("home".tr));
        }
      }
      else{
        return ElevatedButton(onPressed: (){Get.offAllNamed(Routes.LOGIN);}, child: Text("login".tr));
      }
    }
    else{
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget statusText(ConnectionController controller){
    if(controller.isConnected.value == true){
      return Text("connection_restored".tr,style: TextStyle(color: KColors.kSuccess),);
    }
    else{
      return Text("check_connection".tr,style: TextStyle(color: KColors.kError),);
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetX<ConnectionController>(
          builder: (controller){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(controller.isConnected.value?FontAwesomeIcons.smile : FontAwesomeIcons.tired, size: 50,),
                SizedBox(height: 10,),
                statusText(controller),
                SizedBox(height: 10,),
                routing(controller),
              ],
            );
          },
        ),
      ),
    );
  }
}
