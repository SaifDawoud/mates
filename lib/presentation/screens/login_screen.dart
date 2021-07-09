import 'package:flutter/material.dart';
import 'package:mates/presentation/widgets/shared_components.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../widgets/rounded_button.dart';
import '../widgets/password_field.dart';
import './signUp_screen.dart';
import './home_screen.dart';
import '../../providers/auth.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController;
  TextEditingController passwordController;
  var form = GlobalKey<FormState>();

  bool isLoading = false;
  bool isValid = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submit() {
    isValid = form.currentState.validate();

    form.currentState.save();
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
            children: [
              Container(
                  padding: EdgeInsets.all(4),
                  height: 200,
                  child: Image.asset("assets/images/intro.png")),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'LOG IN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: emailController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Required Field";

                    }
                    if(!val.contains("@gmail.com")){
                      return "You Have To Use Your Gmail";
                    }
                    else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline), hintText: 'Your Email'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: PasswordField(
                    controller: passwordController,
                    hint: "Password",
                  )),
              SizedBox(height: 30),
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
                        await auth.logIn(emailController.text.trim(),
                            passwordController.text.trim());
                        if (auth.isAuth != null) {
                          setState(() {
                            isLoading = !isLoading;
                          });
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        }
                      }
                    } catch (e) {
                      setState(() {
                        isLoading = !isLoading;
                      });

                     buildSnackBar(context:context ,text: "Something Went Wrong!! try again");
                      print(e);
                    }
                  },
                  borderColor: Colors.blue,
                  fillinColor: Colors.blue,
                  child: Text(
                    'LOG IN',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      child: Text('Sign Up'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignUpScreen.routeName);
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
}
