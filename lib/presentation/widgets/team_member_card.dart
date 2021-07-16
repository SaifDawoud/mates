import 'package:flutter/material.dart';
import 'package:mates/models/member_model.dart';
import 'package:mates/presentation/screens/individual_chat_member_screen.dart';

import '../../presentation/screens/user_profile_screen.dart';

class TeamMemberCard extends StatelessWidget {
  final MemberModel memberData;

  TeamMemberCard({this.memberData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(UserProfileScreen.routeName);
      },
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border(
                  left: BorderSide(
                      color: Color.fromRGBO(142, 238, 238, 1), width: 2),
                  top: BorderSide(
                      color: Color.fromRGBO(142, 238, 238, 1), width: 2),
                  bottom: BorderSide(
                      color: Color.fromRGBO(142, 238, 238, 1), width: 2),
                  right: BorderSide(
                      color: Color.fromRGBO(142, 238, 238, 1), width: 2))),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(memberData.imageUrl),
              radius: 25,
            ),
            title: Text(memberData.name ?? "name"),
            trailing: IconButton(onPressed: () { Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){return IndividualMemberChat(memberData);})); }, icon: Icon(Icons.message_outlined),),
          ),
        ),
      ),
    );
  }
}
