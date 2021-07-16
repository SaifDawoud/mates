import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mates/models/member_model.dart';
import '../models/team_model.dart';

import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
class TeamProvider with ChangeNotifier {
  String authToken;
  TeamProvider({this.authToken});
  Dio dio = Dio();
  File teamImage;
  List<Team> _teams = [];
  List<MemberModel> _teamMembers=[];

  List<Team> get teams {
    return [..._teams];
  }
  List<MemberModel> get members {
    return [..._teamMembers];
  }

  Future<List<Team>> getAllTeams()async{
    _teams=[];
    Response res=await dio.get('https://boiling-shelf-43809.herokuapp.com/team/',options: Options(headers:{'authorization':authToken}));
    res.data['allTeam'].forEach((t){_teams.add(Team(name: t['teamName'],date:t['date'],id:t['_id'],imageUrl:t['url'],teamAdmin: t['teamAdmin'],teamMembers: t['teamMember'],teamOwner: t['teamOwner'] ));});
    print("all teams::::::${res.data}");

return teams;


  }

  void viewAllMembers(String teamId)async{
    try{
      _teamMembers=[];
      Response res=await dio.get("https://boiling-shelf-43809.herokuapp.com/team/$teamId/viewMember",options: Options(headers:{'authorization':authToken}));
      print(res.data);
      res.data['memberData'].forEach((m){_teamMembers.add(MemberModel(id: m["id"],name: m["name"],imageUrl: m["url"]));
      notifyListeners();});
    }catch(e){print(e);}

  }

void leaveTeam(String teamId)async{
    try{ Response res=await dio.post('https://boiling-shelf-43809.herokuapp.com/team/$teamId/leave',options: Options(headers:{'authorization':authToken}));
    print(res);
    int teamIndex=_teams.indexWhere((element) => element.id==teamId);
    _teams.removeAt(teamIndex);

    notifyListeners();

    }catch(e){print(e);}

}


  Future<void> openFileManagerTeam() async {
    FilePickerResult myFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (myFile != null) {
      teamImage = File(myFile.files.first.path);


    }}

  Future<void> addTeam (
      {String teamName,
      String teamId,
      String teamDescription,
      File teamImage}) async{
    Team newTeam = Team(
        id: teamId,
        description: teamDescription,
        imageFile: teamImage,
        name: teamName);
     String  imageName=teamImage.path.split('/').last;
    var formData = FormData.fromMap({
      'teamName': newTeam.name,
      'teamDescription':newTeam.description,
      '':await MultipartFile.fromFile(teamImage.path,filename:imageName,contentType: MediaType('image','jpg') )

    });
      try{
        Response res=await dio.post("https://boiling-shelf-43809.herokuapp.com/team/addteam",options:Options(headers: {'authorization':authToken}) ,data:formData );
          newTeam.id=res.data['id'];
        notifyListeners();


      }catch(e){
        print("Erorr::::$e");
      }


  }

  void editTeam({String teamName,String teamId,String teamDescription})async{
try {
  Response res=await dio.put("https://boiling-shelf-43809.herokuapp.com/team/$teamId/editTeam",data: {'teamName': teamName,
    'teamDescription':teamDescription,},options:Options(headers: {'authorization':authToken}));
  await getAllTeams();
  print(res);
}
catch(e){print(e);}
  }

 void deleteTeam(String teamId)async{

    try{
      Response res=await dio.delete('https://boiling-shelf-43809.herokuapp.com/team/$teamId/deleteTeam',options:Options(headers: {'authorization':authToken}) );
      print(res);
    }catch(e){print(e);}
   int teamIndex=_teams.indexWhere((element) => element.id==teamId);
    _teams.removeAt(teamIndex);

    notifyListeners();
 }

 void addMember(String teamId,String userName)async{
   Response res=await dio.post('https://boiling-shelf-43809.herokuapp.com/team/$teamId/invite',options:Options(headers: {'authorization':authToken}) ,data: {"userName":userName} );
   print(res);
   _teamMembers=res.data["team"]["teamMember"];
   notifyListeners();
 }

}
