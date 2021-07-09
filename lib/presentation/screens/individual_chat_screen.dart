import 'package:flutter/material.dart';
import '../../models/chat_model.dart';
import '../../presentation/widgets/emoji_container.dart';

class IndividualChat extends StatefulWidget {
  static String routeName = "IndividualChat";
  final ChatModel individualChat;

  IndividualChat(this.individualChat);

  @override
  _IndividualChatState createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  bool showEmoji = false;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 70,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
              )
            ],
          ),
        ),
        title: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(widget.individualChat.userName,
                      style: TextStyle(
                          fontSize: 18.5, fontWeight: FontWeight.bold)),
                ),
                FittedBox(
                    child: Text("Last Seen today a 12:00",
                        style: TextStyle(fontSize: 13))),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.videocam,
              ),
              onPressed: () {}),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Stack(
            children: [
              ListView(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Card(
                                margin: EdgeInsets.only(
                                    left: 2, right: 2, bottom: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            showEmoji = !showEmoji;
                                          });
                                        },
                                        icon:
                                            Icon(Icons.emoji_emotions_outlined),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.attach_file),
                                              onPressed: () {}),
                                          IconButton(
                                              icon: Icon(Icons.camera_alt),
                                              onPressed: () {}),
                                        ],
                                      ),
                                      hintText: "Type a Message",
                                      contentPadding: EdgeInsets.all(5)),
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, right: 5, left: 2),
                          child: CircleAvatar(
                            radius: 25,
                            child: IconButton(
                              icon: Icon(
                                Icons.mic,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                    showEmoji ? EmojiContainer(controller) : Container()
                  ],
                ),
              ),
            ],
          ),
          onWillPop: () {
            if (showEmoji) {
              setState(() {
                showEmoji = false;
              });
            } else {
              Navigator.of(context).pop();
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }
}
