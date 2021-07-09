import 'package:flutter/material.dart';
import 'package:mates/models/file_model.dart';
import 'package:mates/models/team_model.dart';
import 'package:mates/presentation/widgets/files_card.dart';
import 'package:mates/providers/files_provider.dart';
import 'package:provider/provider.dart';

class FilesScreen extends StatelessWidget {
  final Team createdTeam;

  FilesScreen(this.createdTeam);

  @override
  Widget build(BuildContext context) {
    FilesProvider files = Provider.of<FilesProvider>(context);
    return Scaffold(
        body: Container(
          height: 400,
          child: FutureBuilder<List<DeviceFile>>(
            future: files.getAllFiles(createdTeam.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.isEmpty) {
                return Center(child: Text("No Files Yet... Add Some!!"));
              } else {
                return ListView.separated(
                  separatorBuilder: (_, index) => Divider(
                    endIndent: 0,
                    height: 10,
                    thickness: 1,
                    color: Colors.blueGrey,
                    indent: 70,
                  ),
                  itemCount: files.files.length,
                  itemBuilder: (_, index) => FilesCard(fileData:files.files[index]),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            files.openFileManagerUpload(createdTeam.id);
          },
          child: Icon(Icons.upload_outlined),
        ));
  }
}
