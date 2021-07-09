import 'package:flutter/material.dart';
import 'package:mates/presentation/widgets/rounded_button.dart';
import 'package:mates/providers/auth.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  TextEditingController otpController;
  bool isVerified = false;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Your Email'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'check your email to verify your account',
                textAlign: TextAlign.center,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/message_icon.png'))),
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: otpController,
              ),
              SizedBox(
                height: 20,
              ),
              //saifdawood87@yahoo.com   851696

              //saifd2097@gmail.com 625589
              RoundedButton(
                onPressed: () {
                  auth
                      .verifyEmail(auth.currentUser.email, otpController.text)
                      .then((_) {
                    if (auth.isAuth != null) {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    }
                  });
                },
                child: Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                borderColor: Colors.blue,
                fillinColor: Colors.blue,
              )
            ],
          ),
        ),
      )),
    );
  }
}
