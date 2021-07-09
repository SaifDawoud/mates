import 'package:flutter/material.dart';
import 'package:mates/models/team_model.dart';
import 'package:provider/provider.dart';

import '../widgets/team_card.dart';
import '../screens/create_team_screen.dart';
import '../../providers/Team_provider.dart';


class TeamsPage extends StatefulWidget {
  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {




  @override
  Widget build(BuildContext context) {
    final teams = Provider.of<TeamProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(

          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder<List<Team>>(future: teams.getAllTeams(),builder: (context,snapshot){

            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child:CircularProgressIndicator());
            }
            if(snapshot.data.isEmpty){return Center(child:Text('No Teams Yet! Add Some'));
            }
            else{
             return ListView.builder(
                physics:BouncingScrollPhysics() ,
                itemCount: teams.teams.length??0,
                itemBuilder: (BuildContext context, index) {
                  return TeamCard(createdTeam:teams.teams[index],);
                },
              );
            }
          },)
        ),
      ),

    );
  }
}
