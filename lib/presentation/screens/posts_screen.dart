import 'package:flutter/material.dart';
import 'package:mates/models/team_model.dart';
import 'package:provider/provider.dart';
import '../widgets/posts_card.dart';
import '../../providers/post_provider.dart';

class PostsScreen extends StatefulWidget {
  Team createdTeam;

  PostsScreen(this.createdTeam);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  var form = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isValid = false;
  TextEditingController postBodyController = TextEditingController();

  void submit() {
    isValid = form.currentState.validate();

    form.currentState.save();
  }

  @override
  void dispose() {
    postBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: postsProvider.getPosts(widget.createdTeam.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PostsCard(
                        post: postsProvider.posts[index],
                        team:widget.createdTeam,
                       scaffoldKey: scaffoldKey

                      );
                    },
                    itemCount: postsProvider.posts.length,
                  );
                }
              },
            )),
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
    scaffoldKey.currentState.showBottomSheet((context) => BottomSheet(
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
                            'Create Post',
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
                                  postProvider.addPost(widget.createdTeam.id,
                                      postBodyController.text);
                                  Navigator.of(context).pop();
                                  postBodyController.clear();
                                }
                              },
                              child: Text("Post"))
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
