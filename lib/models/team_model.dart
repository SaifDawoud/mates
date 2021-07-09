


import 'dart:io';

class Team {
  String name;
  String id;
  String description;
  List<dynamic> teamAdmin;
  List<dynamic>teamMembers;
  String teamOwner;
  String date;
  String imageUrl;
  File imageFile;

  Team({this.id,this.name,this.description,this.imageUrl,this.teamOwner,this.date,this.teamAdmin,this.teamMembers,this.imageFile});
}
