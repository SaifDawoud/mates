import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mates/models/file_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FilesProvider with ChangeNotifier {
  String authToken;

  FilesProvider({this.authToken});

  File pic;
  List<DeviceFile> files = [];
  Dio dio = Dio();

  Future<void> openFileManagerUpload(String teamId) async {
    FilePickerResult myFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (myFile != null) {
      pic = File(myFile.files.first.path);
      String picName = pic.path
          .split("/")
          .last;
      var formData = FormData.fromMap({
        '': await MultipartFile.fromFile(pic.path,
            filename: picName, contentType: MediaType('image', 'jpg'))
      });
      try {
        Response res = await dio.post(
            "https://boiling-shelf-43809.herokuapp.com/file/$teamId/upload",
            options: Options(headers: {'authorization': authToken}),
            data: formData);
        notifyListeners();
        print(res);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<List<DeviceFile>> getAllFiles(String teamId) async {
    files = [];
    try {
      Response res = await dio.get(
          "https://boiling-shelf-43809.herokuapp.com/file/$teamId/allFile",
          options: Options(headers: {'authorization': authToken}));
      print(res);
      res.data["FileUpload"].forEach((f) {
        files.add(DeviceFile(
            id: f["_id"],
            fileName: f["imageName"],
            uploaderName: f["ownerName"],
            size: f["size"],
            url: f["url"]));
      });
      return files;
    } catch (e) {
      print(e);
    }
  }


}