import 'package:flutter/material.dart';
import 'package:mates/models/reply_model.dart';
import 'package:mates/presentation/widgets/sheet_item.dart';
import 'package:mates/providers/post_provider.dart';
import 'package:provider/provider.dart';

class ReplyCard extends StatefulWidget {
  Reply reply;
  String postId;
  var scaffoldKey;

  ReplyCard({this.reply, this.postId, this.scaffoldKey});

  @override
  _ReplyCardState createState() => _ReplyCardState();
}

class _ReplyCardState extends State<ReplyCard> {
  TextEditingController replyBodyController = TextEditingController();
  bool isValid = false;
  var form = GlobalKey<FormState>();

  void submit() {
    isValid = form.currentState.validate();

    form.currentState.save();
  }

  void showBottomSheet(BuildContext context) {
    widget.scaffoldKey.currentState.showBottomSheet(
      (context) => BottomSheet(
        builder: (BuildContext context) {
          PostProvider postProvider = Provider.of(context, listen: false);
          return Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Form(
              key: form,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Edit Reply',
                          style: TextStyle(fontSize: 20),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Reply body Should not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      controller: replyBodyController,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 2,
                      decoration: InputDecoration(hintText: "Write Reply"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              replyBodyController.clear();
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              submit();
                              if (isValid) {
                                postProvider.editReply(widget.postId,
                                    widget.reply.id, replyBodyController.text);
                                Navigator.of(context).pop();
                                replyBodyController.clear();
                              }
                            },
                            child: Text("Edit"))
                      ],
                    ),
                  ]),
            ),
          );
        },
        onClosing: () {
          Navigator.of(context).pop();
        },
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    );
  }

  @override
  Widget build(BuildContext context) {
    PostProvider postProvider = Provider.of(context);
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.reply.userImageUrl),
                radius: 25,
              ),
              title: Text(widget.reply.userName ?? 'username'),
              subtitle: FittedBox(
                child: Text(
                  "${widget.reply.date ?? "date"}",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              trailing: PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: SheetItem(
                        icon: Icon(Icons.edit),
                        label: Text('Edit Reply'),
                      ),
                      value: "edit",
                    ),
                    PopupMenuItem(
                      child: SheetItem(
                        icon: Icon(Icons.delete),
                        label: Text('Delete Reply'),
                      ),
                      value: "delete",
                    )
                  ];
                },
                onSelected: (selected) {
                  if (selected == "edit") {
                    showBottomSheet(context);
                  } else {
                    postProvider.deleteReply(widget.postId, widget.reply.id);
                  }
                },
              ),
            ),
            Center(
                child: Text(widget.reply.replyBody ?? "body",
                    textAlign: TextAlign.center)),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
