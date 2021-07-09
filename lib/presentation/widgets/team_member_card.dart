import 'package:flutter/material.dart';

import'../../presentation/screens/user_profile_screen.dart';
class TeamMemberCard extends StatelessWidget {
  final String memberName;

  TeamMemberCard({this.memberName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( onTap:(){Navigator.of(context).pushNamed(UserProfileScreen.routeName);},
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border(
                  left: BorderSide(color: Color.fromRGBO(142, 238, 238, 1),width: 2),
                  top: BorderSide(color: Color.fromRGBO(142, 238, 238, 1),width: 2),
                  bottom: BorderSide(color: Color.fromRGBO(142, 238, 238, 1),width: 2),
                  right: BorderSide(color: Color.fromRGBO(142, 238, 238, 1),width: 2))),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 25,
            ),
            title: Text(memberName??"name"),
          ),
        ),
      ),
    );
  }
}
