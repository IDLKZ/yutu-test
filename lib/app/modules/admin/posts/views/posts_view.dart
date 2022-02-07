import 'package:cached_network_image/cached_network_image.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:findout/app/controllers/auth_controller.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:findout/app/widgets/appbar_admin.dart';
import 'package:findout/app/widgets/cardPost_widget.dart';
import 'package:findout/app/widgets/select_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/posts_model.dart';
import '../../../../data/models/users_model.dart';
import '../../../../helpers/validator_mixins.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/advanced_input.dart';
import '../../../../widgets/bottom_widget.dart';
import '../../../../widgets/post_widget.dart';
import '../controllers/posts_controller.dart';

class PostsView extends GetView<PostsController> {

  @override
  Widget build(BuildContext context) {



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
                return GetX<PostsController>(
                    builder:(controller){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                            onTap: (){
                              controller.activeCategory.value = controller.categoriesList.value[index].id.toString();
                            },
                            child: Column(
                              children: [
                                Text(
                                  controller.categoriesList.value[index].titleRu ?? "",
                                  style:  TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: controller.categoriesList.value[index].id.toString() == controller.activeCategory.value ? KColors.kRGBABlue : Colors.white
                                  ),
                                ),
                              ],
                            )),
                      );
                    }
                );
              },

            ),
          ),
        ),
      );
    }

    Widget _post(Posts? post,String? uid){
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.POSTS_SINGLE, arguments: uid);
          },
          child: Card(
            color: KColors.kLightGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding:
              const EdgeInsets.all(10),
              child: Column(
                children: [
                  FutureBuilder<Users?>(
                    future: post?.getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:GlobalMixin.getImage(snapshot.data?.imageUrl),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data?.fullname()}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${GlobalMixin.cityName(snapshot.data?.city) ?? ""}, ${snapshot.data?.getAge()}',
                                    style: TextStyle(color: KColors.kSpaceGray),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              post?.image??"http://via.placeholder.com/350x150",
                            ),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        GlobalMixin.truncateText('${GlobalMixin.truncateText(post?.title??"", 50)}', 60),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined,color:KColors.kMiddleBlue ,size: 25,),
                        Text("${GlobalMixin.cityName(post?.city)}",style: TextStyle(
                            fontSize: 16, color: KColors.kMiddleBlue,fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.userAlt),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${post?.persons}',
                          style: TextStyle(
                              fontSize: 16, color: KColors.kSpaceGray),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(FontAwesomeIcons.calendarAlt),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${post?.getTime()}',
                          style: TextStyle(
                              fontSize: 16, color: KColors.kSpaceGray),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _cardList() {
      return GetBuilder<PostsController>(
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
                    return _post(post,snapshot.docs[index].id);
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
          // _categoryList(),
          Expanded(child: _cardList()),
        ],
      );
    }



    return Scaffold(
      backgroundColor: KColors.kAdminBgColor,
      appBar: AppBar(
        backgroundColor: KColors.kAdminBgColor,
        title: Text('Посты'),
        actions: [
          IconButton(
              onPressed: () => Get.defaultDialog(
                title: 'Filter',
                content: Column(
                  children: [
                    SelectPicker(
                        controller: controller.filterCategory,
                        func: (val){return ValidatorMixin().validateText(val, true);},
                        icon: Icon(FontAwesomeIcons.boxes),
                        hintText: "Категория",
                        labelText:"Выберите категорию",
                        listItem:controller.categoriesItems.value
                    ),
                    DateTimeField(
                      format: DateFormat('dd-MM-yyyy HH:mm'),
                      controller: controller.filterDateStart,
                      decoration: InputDecoration(
                          icon: Icon(Icons.date_range),
                          label: Text('Выберите дату (от)'),
                      ),
                      onShowPicker: (context, currentValue) async{
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                    SizedBox(height: 5,),
                    DateTimeField(
                      format: DateFormat('dd-MM-yyyy HH:mm'),
                      controller: controller.filterDateEnd,
                      decoration: InputDecoration(
                          icon: Icon(Icons.date_range),
                          label: Text('Выберите дату (до)')
                      ),
                      onShowPicker: (context, currentValue) async{
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    )
                  ],
                ),
                onConfirm: (){
                  controller.filterByDate(controller.filterCategory, controller.filterDateStart, controller.filterDateEnd);
                }
              ),
              icon: Icon(Icons.filter)
          )
        ],
      ),
      extendBody: true,
      body: _column(),
    );
  }
}
