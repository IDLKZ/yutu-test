import 'package:findout/app/controllers/location_controller.dart';
import 'package:findout/app/routes/app_pages.dart';
import 'package:findout/app/widgets/advanced_input.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:findout/app/widgets/post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/user_controller.dart';
import '../../../data/models/posts_model.dart';
import '../../../data/models/users_model.dart';
import '../../../helpers/global_mixin.dart';
import '../../../helpers/kcolors.dart';
import '../../../helpers/validator_mixins.dart';
import '../../../widgets/bottom_widget.dart';
import '../../../widgets/datepicker_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {

  @override
  Widget build(BuildContext context) {
    Widget _searchForm(){
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
                    Text("search_post".tr,style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: KColors.kDarkViolet)),
                    SizedBox(height: 20,),
                    DatePickerWidget(
                        controller:controller.startTime,
                        firstDate: DateTime(2022),
                        lastDate: DateTime.now().add(Duration(days: 14)),
                        hint:"start_time".tr,
                        icon:Icon(FontAwesomeIcons.clock),
                        func: (val){},
                        format: DateFormat("dd.MM.yyyy HH:mm"),
                    ),
                    SizedBox(height: 15,),
                    DatePickerWidget(
                      controller:controller.endTime,
                      firstDate: DateTime(2022),
                      lastDate: DateTime.now().add(Duration(days: 14)),
                      hint:"end_time".tr,
                      icon:Icon(FontAwesomeIcons.clock),
                      func: (val){},
                      format: DateFormat("dd.MM.yyyy HH:mm"),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: controller.cityController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: const TextStyle(fontSize: 18, color: Colors.black),
                            hintText: 'select_city'.tr,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.transparent, width: 3),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.transparent, width: 1),
                                borderRadius: BorderRadius.circular(20)),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(20)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(20)),
                            filled: true,
                            fillColor: KColors.kLightGray,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: IconTheme(
                                data: const IconThemeData(color: KColors.kMiddleBlue),
                                child: Icon(FontAwesomeIcons.globe),
                              ),
                            ),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return await GlobalMixin.getSuggestions(pattern);
                        },
                        itemBuilder: (context, Map<String, String> suggestion) {
                          return ListTile(
                            title: Text(suggestion['name']!),
                          );
                        },
                        onSuggestionSelected: (Map<String, String> suggestion) {
                          controller.cityController.text = suggestion['name'] as String;
                        },
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: (){controller.searchPosts();Get.back();},
                          child: Text("search".tr,style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(KColors.kMiddleBlue)
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){Get.back();},
                          child: Text("cancel".tr,style: TextStyle(color: Colors.white),),
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

    Widget _header(String? image,String name) {
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
                    onTap: () => Get.toNamed(Routes.PROFILE),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: GlobalMixin.getImage(image),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
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
                    'main'.tr,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                       Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: (){
                            Get.dialog(
                              Material(child: _searchForm(),color: Colors.transparent,)
                            );
                          },
                          child: CircleAvatar(
                              backgroundColor: KColors.kDarkenGray,
                              radius: 20,
                              child: Icon(
                                Icons.search,
                                size: 36,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          backgroundColor: KColors.kDarkenGray,
                          radius: 20,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.POST_CREATE);
                            },
                            child: Icon(
                              Icons.add,
                              size: 36,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget _categoryList() {
      return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 0, right: 20, left: 20),
        child: SizedBox(
          height: 50,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoriesList.value.length,
              itemBuilder: (context,index){
                       return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                            onTap: (){
                              controller.activeCategory.value = controller.categoriesList.value[index].id.toString();
                            },
                            child: Column(
                              children: [
                                Text(
                                  Get.find<LocationController>().locale.value == "en"
                                      ?(controller.categoriesList.value[index].titleEn ?? "")
                                  :(controller.categoriesList.value[index].titleRu ?? ""),
                                  style:  TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: controller.categoriesList.value[index].id.toString() == controller.activeCategory.value ? KColors.kRGBABlue : Colors.black
                                  ),
                                ),
                              ],
                            )),
                      );
              },

            ),
          ),
        ),
      );
    }


    Widget _cardList() {
      return GetBuilder<HomeController>(
        builder: (controller){
            return Container(
              child: FirestoreQueryBuilder(
                query: controller.getQuery(),
                pageSize: 2,
                builder: (BuildContext context, FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot, Widget? child) {
                  if (snapshot.isFetching) {
                    return Center(child: const CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return ListView.builder(
                    itemCount: snapshot.docs.length,
                    itemBuilder: (context, index) {
                      if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                        snapshot.fetchMore();
                      }
                      final post = Posts.fromJson(snapshot.docs[index].data());
                      return PostWidget(post:post,uid: snapshot.docs[index].id);
                    },
                  );


                },
              ),
            );

        },

      );
    }

    Widget _column(){
     return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetX<UserController>(
            builder: (controller) {
              return _header(controller.user?.imageUrl, "${'hello'.tr}, ${controller.user?.fullname() ?? ""}");
            },
          ),
          GetX<HomeController>(
            builder: (controller) {
              return _categoryList();
            },
          ),

          Expanded(child: _cardList()),
        ],
      );
    }



    return Scaffold(
      extendBody: true,
      body: _column(),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
