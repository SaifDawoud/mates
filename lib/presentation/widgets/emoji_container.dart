/*
import 'package:flutter/material.dart';
import'package:emoji_picker/emoji_picker.dart';
class EmojiContainer extends StatefulWidget {
  final TextEditingController controller;
  EmojiContainer(this.controller);
  @override
  _EmojiContainerState createState() => _EmojiContainerState();
}

class _EmojiContainerState extends State<EmojiContainer> {
  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          setState(() {
            widget.controller.text = widget.controller.text + emoji.emoji;
          });
        });
  }
}
*/
