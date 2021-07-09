import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/team_member_card.dart';
import '../../providers/Team_provider.dart';

class ViewMembersScreen extends StatefulWidget {
  static const String routeName = 'view_member_screen';

  @override
  _ViewMembersScreenState createState() => _ViewMembersScreenState();
}

class _ViewMembersScreenState extends State<ViewMembersScreen> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final teams = Provider.of<TeamProvider>(context);
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: isSearching
            ? TextField()
            : Text('Team Members ${teams.members.length}',
                style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: isSearching
                ? Icon(
                    Icons.search_off_outlined,
                    size: 30,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.search_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
            onPressed: () {
              setState(() {
                isSearching ? isSearching = false : isSearching = true;
              });
            },
          )
        ],
      ),
      body: isSearching
          ? Center(
              child: Text('Type the Member Name To Search For'),
            )
          : ListView.builder(itemBuilder:(context,index)=>TeamMemberCard(memberName:teams.members[index] ,) ,itemCount: teams.members.length,),
    );
  }
}
