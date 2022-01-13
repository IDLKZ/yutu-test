import 'package:findout/app/controllers/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helpers/kcolors.dart';
import '../controllers/post_create_controller.dart';
import 'dart:io';
class PostCreateView extends GetView<PostCreateController> {

  ImageController _imageController = Get.put<ImageController>(ImageController());

  Widget _showDialog(BuildContext context){
    return AlertDialog(
      title: Text("Загрузите изображение"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            GestureDetector(
              onTap: ()async{
                Get.back();
                await _imageController.pickImage(ImageSource.camera);
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.camera_alt_rounded),
                  title: Text("Сделать фото"),
                ),
              ),
            ),
            GestureDetector(
              onTap: ()async{
                Get.back();
                await _imageController.pickImage(ImageSource.gallery);
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Загрузить с галереи"),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context, rootNavigator: true).pop();
        }, child: Text("Отмена"))
      ],
    );
  }

  Widget _imageContainer(BuildContext context,ImageController _imageController){
    return GestureDetector(
          onTap: (){
            !_imageController.imageUploaded.value ? showDialog(
                context: context,
                builder: (c)=>_showDialog(context)
            )
            :null;
          },
          child: Container(
            height: MediaQuery.of(context).size.height*0.55,
            decoration:  BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)),
                 image: DecorationImage(
                    image: _imageController.imageUploaded.value == false ?
                    NetworkImage(_imageController.selectedImageUrl.value.isNotEmpty? _imageController.selectedImageUrl.value :'https://enviragallery.com/wp-content/uploads/2016/06/How-to-Optimize-Your-Images-for-the-Web-Step-by-Step.png')
                     :NetworkImage("https://i.stack.imgur.com/PLbzc.gif")
                     ,
                    fit: BoxFit.cover
                )
            ),
          ),
        );
  }


  Widget _columnShow(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.45,
          child: GetX<ImageController>(
              builder: (_imageController){
               return Stack(
                  children: [
                    _imageContainer(context,_imageController),
                    Positioned(
                      top: 50,
                      left: 30,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: KColors.kLightGray,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Icon(FontAwesomeIcons.chevronLeft),
                      ),
                    ),
                    _imageController.selectedImageUrl.value.isNotEmpty
                     ? Positioned(
                      top: 50,
                      right: 30,
                      child: GestureDetector(
                        onTap: (){
                          _imageController.deleteFile(_imageController.selectedImageUrl.value);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: KColors.kLightGray,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: const Icon(Icons.clear),
                        ),
                      ),
                    )
                    :SizedBox(),
                    !_imageController.imageUploaded.value ?
                    Positioned(
                      right: 20,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (c)=>_showDialog(context)
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: KColors.kDarkenGray,
                          radius: 25,
                          child: Icon(FontAwesomeIcons.image, color: Colors.lightBlueAccent,),
                        ),
                      ),
                    )
                        :SizedBox()
                  ],
                );
             })
        ),
        const SizedBox(height: 10,),

      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _columnShow(context)

    );
  }
}
