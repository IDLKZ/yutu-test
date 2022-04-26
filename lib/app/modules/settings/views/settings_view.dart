import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../helpers/global_mixin.dart';
import '../../../helpers/kcolors.dart';
import '../../../helpers/validator_mixins.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/advanced_input.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  UserController _userController = Get.find<UserController>();
  AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {


    Widget _prompt(){
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child:Form(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){Get.back();},
                          child: Icon(
                              Icons.close_rounded
                          ),
                        ),
                      ],
                    ),
                    Text("sure_to_delete".tr,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: KColors.kDarkViolet)),
                    SizedBox(height: 20,),
                    AdvancedInput(
                      icon:Icon(Icons.title),
                      hint: "enter_to_delete".tr,
                      controller:controller.text,
                      obscure:false,
                      func: (val){
                        return ValidatorMixin().validateText(val, true);
                      },
                      hintStyle: TextStyle(fontSize: 12),
                      maxLength: 4,
                      maxLines: 2,
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: (){Get.back();},
                          child: Text("cancel".tr,style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(KColors.kChatColor)
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            controller.deleteUser();
                          },
                          child: Text("delete".tr,style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(KColors.kError)
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ) ,
            ),
          ),
        ),
      );

    }



    Widget _header(String? image, String? name) {
      return Container(
        padding: const EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: const BoxDecoration(
          color: KColors.kRGBABlue,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(child: IconButton(
                    alignment: Alignment.topLeft,
                      onPressed: (){Get.offAllNamed(Routes.HOME);},
                      icon: Icon(FontAwesomeIcons.angleLeft,color: Colors.black,))

                  ),
                  Expanded(child: Text(
                    "setting".tr,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),),

                ],
              ),
              SizedBox(height: 15,),
              Center(
                child: GestureDetector(
                  onTap: () => Get.offAllNamed(Routes.PROFILE),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: GlobalMixin.getImage(image),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  name ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _cardLists() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(5),
              child: ListTile(
                tileColor: Colors.white60,
                onTap: (){Get.toNamed(Routes.CHANGE_PROFILE);},
                leading: Icon(FontAwesomeIcons.user,color: Colors.black,),
                title: Text("change_profile".tr),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(5),
              child: ListTile(
                onTap: (){Get.toNamed(Routes.WISHLISTS);},
                leading: Icon(FontAwesomeIcons.heart,color: Colors.black,),
                title: Text("liked_posts".tr),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(5),
              child: ListTile(
                onTap: (){Get.toNamed(Routes.BANS);},
                leading: Icon(FontAwesomeIcons.lock,color: Colors.black,),
                title: Text("blacklists".tr),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(5),
              child: ListTile(
                onTap: (){Get.toNamed(Routes.PRIVACY_TERM);},
                leading: Icon(FontAwesomeIcons.shieldAlt,color: Colors.black,),
                title: Text("privacy_term".tr),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(5),
              child: ListTile(
                onTap: (){_authController.logout();},
                leading: Icon(Icons.logout,color: Colors.black,),
                title: Text("logout".tr),
              ),
            ),
            Divider(height: 5,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(5),
              child: ListTile(
                onTap: (){
                  Get.dialog(
                      Material(child: _prompt(),color: Colors.transparent,)
                  );
                },
                leading: Icon(FontAwesomeIcons.userMinus,color: KColors.kError,),
                title: Text("delete_account".tr,style: TextStyle(
                    color: KColors.kError
                ),),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          _header(
              _userController.user?.imageUrl, _userController.user?.fullname()),
          Expanded(child: _cardLists())
        ],
      ),
    );
  }
}
