import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = 'user_profile_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/user.jpg'))),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'ranina hossny',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Divider(
            thickness: 2,
            endIndent: 30,
            indent: 30,
            color: Colors.grey,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                textColor: Colors.white,
                child: Icon(
                  Icons.chat_outlined,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                textColor: Colors.white,
                child: Icon(
                  Icons.video_call_outlined,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text('Email@Email.com',
              textAlign: TextAlign.start,
              style: TextStyle( fontSize: 20))
        ]),
      ),
    );
  }
}
