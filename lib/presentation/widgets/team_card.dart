import 'package:flutter/material.dart';
import 'package:mates/models/team_model.dart';
import 'package:mates/presentation/screens/edit_team_screen.dart';
import 'package:provider/provider.dart';

import '../screens/teams_details_screen.dart';
import '../widgets/sheet_item.dart';
import '../../providers/Team_provider.dart';
import '../../presentation/screens/view_members_screen.dart';

class TeamCard extends StatelessWidget {
  Team createdTeam;

  TeamCard({
    this.createdTeam,
  });

  void showBottomSheet(BuildContext context) {
    final teams = Provider.of<TeamProvider>(context, listen: false);
    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return BottomSheet(
            builder: (BuildContext context) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            createdTeam.name ?? 'Team Name',
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      SheetItem(
                        icon: Icon(Icons.people_outline),
                        onPressed: () {
                          teams.viewAllMembers(createdTeam.id);
                          Navigator.of(context)
                              .pushNamed(ViewMembersScreen.routeName);
                        },
                        label: Text('View Member'),
                      ),
                      SheetItem(
                        icon: Icon(Icons.subdirectory_arrow_left),
                        onPressed: () {
                          teams.leaveTeam(createdTeam.id);
                          Navigator.of(context).pop();
                        },
                        label: Text('Leave The Teams'),
                      ),

                      //if the user is an admin
                      SheetItem(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return EditTeamScreen(createdTeam);
                          }));
                        },
                        label: Text('Edit Team'),
                      ),
                      SheetItem(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          teams.deleteTeam(createdTeam.id);
                          Navigator.of(context).pop();
                        },
                        label: Text('Delete Team'),
                      ),
                    ]),
              );
            },
            onClosing: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(142, 238, 238, 1)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          createdTeam.imageUrl == null
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              : Container(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      createdTeam.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Text(createdTeam.name ?? 'static',
                  style: TextStyle(
                    fontSize: 20,
                  ))),
          IconButton(
            iconSize: 35,
            padding: EdgeInsets.all(2),
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showBottomSheet(context);
            },
          ),
        ]),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                TeamsDetailsScreen(createdTeam: createdTeam)));
      },
    );
  }
}
