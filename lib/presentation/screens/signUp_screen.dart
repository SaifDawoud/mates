import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mates/presentation/widgets/shared_components.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../widgets/rounded_button.dart';
import '../widgets/password_field.dart';
import '../screens/login_screen.dart';
import '../../providers/auth.dart';
import 'confirmation_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signUp_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController bioController;
  TextEditingController confirm;
  var form = GlobalKey<FormState>();
  bool isLoading = false;
  bool isValid = false;
  bool isVerified = false;
  File pic;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirm = TextEditingController();
    bioController = TextEditingController();

    super.initState();
  }

  void submit() {
    isValid = form.currentState.validate();

    form.currentState.save();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirm.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.black,
        progressIndicator: CircularProgressIndicator(),
        child: SingleChildScrollView(
            child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding: EdgeInsets.all(4),
                  height: 200,
                  child: Stack(
                    children: [
                      Center(
                          child: pic != null
                              ? CircleAvatar(
                                  radius: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(pic),
                                            fit: BoxFit.cover)),
                                  ),
                                )
                              : CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                                  radius: 50,
                                )),
                      Align(
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: getProfileImage,
                        ),
                        alignment: AlignmentDirectional.bottomEnd,
                      )
                    ],
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Required Field";
                    } else {
                      return null;
                    }
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), hintText: 'name'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Required Field";
                    }
                    if (!val.contains("@gmail.com")) {
                      return "You Have To Use Your Gmail";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline), hintText: ' Email'),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: PasswordField(
                    controller: passwordController,
                    hint: "Password",
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: PasswordField(
                    controller: confirm,
                    hint: "Confirm Password",
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Required Field";
                    } else {
                      return null;
                    }
                  },
                  controller: bioController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.work_outline),
                      hintText: ' Write your job title'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: RoundedButton(
                  onPressed: () async {
                    try {
                      submit();
                      if (isValid) {
                        setState(() {
                          isLoading = !isLoading;
                        });
                        await auth
                            .signUp(
                                nameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                confirm.text.trim(),
                                pic,
                                bioController.text)
                            .then((value) {
                          setState(() {
                            isLoading = !isLoading;
                          });
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return ConfirmationScreen();
                          }));
                        });
                      }
                    } catch (e) {
                      if (e
                          .toString()
                          .contains("The getter 'path' was called on null")) {
                        setState(() {
                          isLoading = !isLoading;
                        }); buildSnackBar(context:context ,text: "Pick your profile image");

                      } else {
                        setState(() {
                          isLoading = !isLoading;
                        });
                        buildSnackBar(context:context ,text: "Something Went Wrong!! try again");

                        print(e);
                      }
                    }
                  },
                  borderColor: Colors.blue,
                  fillinColor: Colors.blue,
                  child: Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      child: Text('LOG IN'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        )),
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
