import 'package:flutter/foundation.dart';
import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chats = [
    ChatModel(userImageUrl: "",
      userName: "saif dawoud",
      lastMessage: "Get me out",
    ),
    ChatModel(userImageUrl: "",
      userName: "Dawoud",
      lastMessage: "ok",
    )
  ];
}
