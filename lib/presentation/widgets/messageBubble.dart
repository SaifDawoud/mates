import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;

  MessageBubble({this.isMe});

  @override
  Widget build(BuildContext context) {
    return Material(elevation:5 ,

        color: isMe ? Colors.blue : Colors.amberAccent,
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft:
                    Radius.circular(20),
                bottomRight: Radius.circular(20),

                bottomLeft:
                Radius.circular(20))
            : BorderRadius.only(

                bottomRight:
                Radius.circular(20),
                topRight:
                Radius.circular(20),
                bottomLeft: Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text('Message Demo',textAlign: TextAlign.center,),
      ),

    );
  }
}
