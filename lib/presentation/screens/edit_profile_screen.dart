import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:mates/providers/auth.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static String routeName = "edit_Profile_screen";

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File pic;
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    nameController.text = auth.currentUser.name;
    bioController.text = auth.currentUser.bio;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                //circle avatar position
                height: 210.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      //cover photo
                      child: Container(
                        height: 160.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              4.0,
                            ),
                            topRight: Radius.circular(
                              4.0,
                            ),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://cdn.dribbble.com/users/1552574/screenshots/12001214/media/2d37e6a859623880ec44d2645e119220.jpg?compress=1&resize=800x600"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Stack(
                        children: [
                          pic != null
                              ? CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: FileImage(pic),
                                )
                              : CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage:
                                      NetworkImage(auth.currentUser.image),
                                ),
                          Positioned(
                            child: IconButton(
                              onPressed: getProfileImage,
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              color: Colors.grey,
                            ),
                            bottom: 3,
                            right: 3,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: nameController,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: bioController,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: RaisedButton.icon(
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromRGBO(64, 123, 255, 1),
                    onPressed: () {
                      auth
                          .editProfile(nameController.text,
                              auth.currentUser.email, bioController.text, pic)
                          .then(
                              (value) => auth.getProfile(auth.currentUser.id));
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      size: 35,
                      color: Colors.white,
                    ),
                    label: Text('Edit Done')),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getProfileImage() async {
    FilePickerResult myFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (myFile != null) {
      setState(() {
        pic = File(myFile.files.first.path);
      });
    }
  }
}
