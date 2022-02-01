
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmojiPickerWidget extends StatelessWidget {
  late TextEditingController textEditingController;

  EmojiPickerWidget({required this.textEditingController});



  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        this.textEditingController.text += emoji.emoji;
      },
      onBackspacePressed: () {
       if(textEditingController.text.isNotEmpty){
         textEditingController.text = textEditingController.text.characters.skipLast(1).toString();
       }
      },
      config: Config(
          columns: 7,
          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
          verticalSpacing: 0,
          horizontalSpacing: 0,
          initCategory: Category.RECENT,
          bgColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          progressIndicatorColor: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecentsText: "No Recents",
          noRecentsStyle:
          const TextStyle(fontSize: 20, color: Colors.black26),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL
      ),
    );
  }
}
