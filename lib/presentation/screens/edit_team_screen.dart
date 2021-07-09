import 'package:flutter/material.dart';
import 'package:mates/models/team_model.dart';
import 'package:provider/provider.dart';

import '../widgets/rounded_button.dart';
import '../../providers/Team_provider.dart';

class EditTeamScreen extends StatefulWidget {
  static const String routeName = 'edit_team';
  Team createdTeam;

  EditTeamScreen(this.createdTeam);

  @override
  _EditTeamScreenState createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teams = Provider.of<TeamProvider>(context);

    nameController.text = widget.createdTeam.name;
    descriptionController.text = widget.createdTeam.description;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Team'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Team Name :',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          )),
                      Container(
                          margin: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                labelText:
                                    'Only Letters,numbers and spaces are allowed'),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Team Description :',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          )),
                      Container(
                          margin: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: descriptionController,
                          )),
                    ],
                  )),
              SizedBox(
                height: 35,
              ),
              RoundedButton(
                child: Text(
                  'Edit',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  teams.editTeam(teamId: widget.createdTeam.id,
                    teamDescription: descriptionController.text,
                    teamName: nameController.text,
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                borderColor: Color.fromRGBO(142, 238, 238, 1),
                fillinColor: Color.fromRGBO(142, 238, 238, 1),
              ),
            ],
          ),
        ),
       );
  }
}
