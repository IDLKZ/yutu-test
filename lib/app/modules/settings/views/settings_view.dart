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
                      maxLength: 4,
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
                  GestureDetector(
                    onTap: () => Get.offAllNamed(Routes.PROFILE),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: GlobalMixin.getImage(image),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name ?? "",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'setting'.tr,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                ],
              )
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
            Card(
              child: ListTile(
                onTap: (){Get.toNamed(Routes.CHANGE_PROFILE);},
                leading: Icon(FontAwesomeIcons.user),
                title: Text("change_profile".tr),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){Get.toNamed(Routes.WISHLISTS);},
                leading: Icon(FontAwesomeIcons.heart),
                title: Text("liked_posts".tr),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){Get.toNamed(Routes.BANS);},
                leading: Icon(FontAwesomeIcons.lock),
                title: Text("blacklists".tr),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){_authController.logout();},
                leading: Icon(FontAwesomeIcons.powerOff),
                title: Text("logout".tr),
              ),
            ),
            Divider(height: 5,),
            Card(
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
