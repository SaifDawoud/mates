import 'package:flutter/material.dart';
import 'package:mates/models/post_model.dart';
import 'package:mates/models/team_model.dart';
import 'package:mates/presentation/screens/replies_screen.dart';
import 'package:mates/presentation/widgets/sheet_item.dart';
import 'package:mates/providers/post_provider.dart';
import 'package:provider/provider.dart';

class PostsCard extends StatefulWidget {
  Post post;
  Team team;
  final scaffoldKey;

  PostsCard({this.post, this.team, this.scaffoldKey});

  @override
  _PostsCardState createState() => _PostsCardState();
}

class _PostsCardState extends State<PostsCard> {
  TextEditingController postBodyController = TextEditingController();
  bool isValid = false;
  var form = GlobalKey<FormState>();

  void submit() {
    isValid = form.currentState.validate();

    form.currentState.save();
  }

  void showBottomSheet(BuildContext context, scaffoldKey) {
    widget.scaffoldKey.currentState.showBottomSheet((context) => BottomSheet(
          builder: (BuildContext context) {
            PostProvider postProvider = Provider.of(context, listen: false);
            return Container(
              height: 200,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: Form(
                key: form,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'edit Post',
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return "post body Should not Be Empty";
                          } else {
                            return null;
                          }
                        },
                        controller: postBodyController,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 2,
                        decoration: InputDecoration(
                            hintText: "Inform Your Team Mates With Updates"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                postBodyController.clear();
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                submit();
                                if (isValid) {
                                  postProvider.editPost(
                                      widget.post.id, postBodyController.text);
                                  Navigator.of(context).pop();
                                  postBodyController.clear();
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
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    PostProvider postProvider = Provider.of(context, listen: false);
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.creatorImage),
                  radius: 25,
                ),
                title: Text(widget.post.creatorName),
                subtitle: Text(
                  "${widget.post.date}",
                  style: TextStyle(fontSize: 12),
                ),
                trailing: PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: SheetItem(
                          icon: Icon(Icons.edit),
                          label: Text('Edit post'),
                        ),
                        value: "edit",
                      ),
                      PopupMenuItem(
                        child: SheetItem(
                          icon: Icon(Icons.delete),
                          label: Text('Delete post'),
                        ),
                        value: "delete",
                      )
                    ];
                  },
                  onSelected: (selected) {
                    if (selected == "edit") {
                      showBottomSheet(context, widget.scaffoldKey);
                    } else {
                      postProvider.deletePost(widget.post.id);
                    }
                  },
                )),
            Center(child: Text(widget.post.body, textAlign: TextAlign.center)),
            SizedBox(height: 10),
            Divider(
              endIndent: 0,
              height: 10,
              thickness: 1,
              color: Colors.blueGrey,
              indent: 25,
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return RepliesScreen(
                      currentPost: widget.post,
                    );
                  }));
                },
                icon: Icon(Icons.reply_outlined),
                label: Text('Reply')),
          ],
        ),
      ),
    );
  }
}
