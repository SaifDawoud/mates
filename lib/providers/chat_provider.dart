import 'package:flutter/foundation.dart';
import '../models/chat_model.dart';
class ChatProvider with ChangeNotifier{
  List<ChatModel> chats=[ChatModel(userName: "saif dawoud",time: "4:00",currentMessage: "Get me out",),ChatModel(userName: "Dawoud",time: "8:00",currentMessage: "ok",)];

}