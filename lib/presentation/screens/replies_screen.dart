import 'package:flutter/material.dart';
import 'package:mates/models/post_model.dart';
import 'package:mates/models/reply_model.dart';
import 'package:mates/presentation/widgets/posts_card.dart';
import 'package:mates/presentation/widgets/reply_card.dart';
import 'package:mates/providers/post_provider.dart';
import 'package:provider/provider.dart';

class RepliesScreen extends StatefulWidget {
  Post currentPost;
  Reply reply;

  RepliesScreen({this.currentPost});

  @override
  _RepliesScreenState createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController replyBodyController;
  bool isValid=false;
  var form=GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    widget.reply = Reply(
        userImageUrl: widget.currentPost.creatorImage,
        date: widget.currentPost.date,
        userName: widget.currentPost.creatorName,
        id: widget.currentPost.id,
        replyBody: widget.currentPost.body);
    replyBodyController=TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    replyBodyController.dispose();
  }
  void submit() {
    isValid = form.currentState.validate();

    form.currentState.save();
  }
  @override
  Widget build(BuildContext context) {
    PostProvider postProvider = Provider.of<PostProvider>(context);
    return Scaffold(key: scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            ReplyCard(
              reply: widget.reply,
            ),
            FutureBuilder(
              future: postProvider.getAllReplies(widget.currentPost.id),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Padding(padding:EdgeInsets.all(20),child: CircularProgressIndicator());
                }
                if (snapShot.data.isEmpty) {
                  return Padding(padding: EdgeInsets.all(20),child: Text('No Replies!!'));
                } else {
                  return Container(
                    width: double.infinity,
                    height: 300,
                    margin: EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ReplyCard(
                          reply: snapShot.data[index],
                          postId: widget.currentPost.id ,scaffoldKey: scaffoldKey,
                        );
                      },
                      itemCount: postProvider.replies.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showBottomSheet(context);
        },
        child: Icon(Icons.create),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {

    scaffoldKey.currentState.showBottomSheet((context) =>  BottomSheet(
      builder: (BuildContext context) {
        PostProvider postProvider=Provider.of(context);
        return Container(
          height: 300,
          padding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Form(  key: form,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Add Reply',
                        style: TextStyle(fontSize: 20),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(validator: (val){if(val.isEmpty){return"Reply body Should not Be Empty";}else{

                    return null;}},
                    controller: replyBodyController,
                    minLines: 1,
                    keyboardType:  TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 2,decoration: InputDecoration(hintText: "Write reply"),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () {
                        replyBodyController.clear();
                        Navigator.of(context).pop();}, child: Text("Cancel")),
                      TextButton(onPressed: () {
                        submit();
                        if(isValid){
                          postProvider.addReply(widget.currentPost.id,replyBodyController.text);
                          Navigator.of(context).pop();
                          replyBodyController.clear();
                        }

                      }, child: Text("Reply"))
                    ],
                  ),
                ]),
          ),
        );
      },
      onClosing: () {
        Navigator.of(context).pop();
      },
    ));
  }
}
