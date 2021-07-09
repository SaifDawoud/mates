import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/rounded_button.dart';
import '../../providers/Team_provider.dart';

class CreateTeamScreen extends StatefulWidget {
  static const String routeName = 'create_team';

  @override
  _CreateTeamScreenState createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();
  var form=GlobalKey<FormState>();
  bool isValid=false;
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void submit() {
    isValid = form.currentState.validate();

    form.currentState.save();
  }
  @override
  Widget build(BuildContext context) {
    final teams = Provider.of<TeamProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Team'),
        ),
        body: SingleChildScrollView(
          child: Form(key: form,
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
                              validator: (val){
                                if(val.isEmpty){
                                  return "Required Field";
                                }else{
                                  return null;
                                }
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                  ),
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
                              validator: (val){
                                if(val.isEmpty){
                                  return "Required Field";
                                }else{
                                  return null;
                                }
                              },
                               )),
                      ],
                    )),
                SizedBox(
                  height: 35,
                ),
                RoundedButton(
                  child: Text(
                    'Create',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    submit();
                    if(isValid) {
                      Navigator.of(context).pop();
                      teams.addTeam(
                          teamDescription: descriptionController.text,
                          teamName: nameController.text,
                          teamImage: teams.teamImage).then((value) =>
                      teams.teamImage = null);
                    }
                  },
                  borderColor: Color.fromRGBO(142, 238, 238, 1),
                  fillinColor: Color.fromRGBO(142, 238, 238, 1),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "create_team",
          onPressed:teams.openFileManagerTeam,
          child: Icon(Icons.camera_alt),
        ));
  }
}
