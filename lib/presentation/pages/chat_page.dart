import 'package:flutter/material.dart';
import '../../models/chat_model.dart';
import 'package:provider/provider.dart';
import '../../providers/chat_provider.dart';
import '../screens/individual_chat_member_screen.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isMe = false;

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chats = Provider
        .of<ChatProvider>(context)
        .chats;

    return ListView.separated(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return InkWell(onTap: (){
          /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return IndividualChat(chats[index]);
          }));*/
        },
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.purple,
            ),
            title: Text(chats[index].userName),
            subtitle: Text(chats[index].lastMessage),

          ),
        );
      },
      separatorBuilder: (context, i) {
        return
        Divider(
        endIndent: 0,
        height: 10,
        thickness: 1,
        color: Colors.blueGrey,
        indent
        :
        70
        ,
        );
      },
    );
  }
}
