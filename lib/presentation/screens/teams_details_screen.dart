import 'package:flutter/material.dart';
import 'package:mates/models/file_model.dart';
import 'package:mates/models/team_model.dart';
import 'package:mates/presentation/screens/meet_screen.dart';
import 'package:mates/providers/Team_provider.dart';
import 'package:mates/providers/auth.dart';
import 'package:mates/providers/files_provider.dart';
import '../../providers/post_provider.dart';
import 'package:provider/provider.dart';

import './posts_screen.dart';
import './files_screen.dart';

class TeamsDetailsScreen extends StatefulWidget {
  static const String routeName = 'TeamsDetailsScreen';

  TeamsDetailsScreen({this.createdTeam});

  Team createdTeam;

  @override
  _TeamsDetailsScreenState createState() => _TeamsDetailsScreenState();
}

class _TeamsDetailsScreenState extends State<TeamsDetailsScreen> {
  TextEditingController userNameController = TextEditingController();
  bool isValid = false;
  var form = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void submit() {
    isValid = form.currentState.validate();

    form.currentState.save();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    PostProvider postProvider = Provider.of(context);
    FilesProvider filesProvider=Provider.of(context);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(key: _scaffoldKey,
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text(
              widget.createdTeam.name,
              style: TextStyle(color: Colors.grey),
            ),
            bottom: TabBar(
              indicatorColor: Colors.red,
              onTap: (index) {
                if (index == 0) {
                  postProvider.getPosts(widget.createdTeam.id);
                } else {
                 filesProvider.getAllFiles(widget.createdTeam.id);
                }
              },
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text('Posts',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Tab(
                  child: Text('Files',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(
                    Icons.video_call_rounded,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => MeetScreen(
                            teamName: widget.createdTeam.name,
                            currentUser: auth.currentUser)));
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.person_add,
                  color: Colors.blue,
                ),
                onPressed: () {
                  showBottomSheet(context);
                },
              ),
            ]),
        body: TabBarView(
          children: [PostsScreen(widget.createdTeam), FilesScreen(widget.createdTeam)],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
_scaffoldKey.currentState.showBottomSheet((context) =>  BottomSheet(
  builder: (BuildContext context) {
    TeamProvider teams = Provider.of<TeamProvider>(context, listen: false);
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
                    'Add Member',
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return "User name Should not Be Empty";
                  } else {
                    return null;
                  }
                },
                controller: userNameController,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 2,
                decoration: InputDecoration(
                    hintText: "Type The User Name You Want To Add"),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        userNameController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        submit();
                        if (isValid) {
                          teams.addMember(widget.createdTeam.id,
                              userNameController.text);
                          Navigator.of(context).pop();
                          userNameController.clear();
                        }
                      },
                      child: Text("Add"))
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
