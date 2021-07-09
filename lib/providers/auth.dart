import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mates/cache_helper.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import '../presentation/screens/login_screen.dart';

import '../models/user_model.dart';

class Auth with ChangeNotifier {

  String token;
  MyUser currentUser = MyUser();
  String deviceType='android';
  bool get isAuth => token != null ? true : false;
  Dio dio = Dio();


  Future<void> signUp(String userName, String email, String userPassword,
      String confirm, File userImage, String bio) async {
    final url = 'https://boiling-shelf-43809.herokuapp.com/user/signup';
    try {
     // print("deviceToken::::$deviceToken");
      String imageName = userImage.path.split('/').last;
      FormData formData = FormData.fromMap({
        "name": userName,
        "email": email,
        "password": userPassword,
        "confirmPassword": confirm,
        "userBio": bio,
        "deviceType":deviceType,
       // "deviceToken":deviceToken,
        "": await MultipartFile.fromFile(userImage.path,
            filename: imageName, contentType: MediaType('image', 'jpg'))
      });
      Response res = await dio.post(url, data: formData);

      currentUser.name = res.data['newUser']['name'];
      currentUser.email = res.data['newUser']['email'];
      currentUser.image = res.data['newUser']['url'];
      currentUser.id = res.data['newUser']["id"];
      currentUser.bio = res.data["newUser"]["bio"];
      print(res.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> editProfile(
      String name, String email, String bio, File userImage) async {
    final url = 'https://boiling-shelf-43809.herokuapp.com/user/editProfile';
    try {
      String imageName = userImage.path.split('/').last;
      FormData formData = FormData.fromMap({
        "name": name,
        "email": email,
        "bio": bio,
        "": await MultipartFile.fromFile(userImage.path,
            filename: imageName, contentType: MediaType('image', 'jpg'))
      });
      Response res = await dio.put(url,
          data: formData, options: Options(headers: {'authorization': token}));
      print(res.data);
    } catch (e) {
      print(e);
    }
  }

  void getProfile(String userId) async {
    Response res = await dio.get(
        "https://boiling-shelf-43809.herokuapp.com/user/$userId/profile",
        options: Options(headers: {'authorization': token}));
    print(res.data);
    currentUser.name = res.data['profile']['name'];
    currentUser.email = res.data['profile']['email'];
    currentUser.image = res.data['profile']['url'];
    currentUser.id = res.data['profile']["id"];
    currentUser.bio = res.data["profile"]["bio"];
    notifyListeners();
  }

  Future<void> verifyEmail(String email, String code) async {
    try {
      Response res = await dio.post(
          "https://boiling-shelf-43809.herokuapp.com/user/verifyCode",
          data: {"email": email, "code": code});
      token = res.data['token'];
      if (token != null) {
        final userData = json.encode({
          "token": token,
          "userName": res.data['newUser']['name'],
          "userEmail": res.data['newUser']['email'],
          "userId": res.data['newUser']["id"],
          "imageUrl": res.data['newUser']['url'],
          "userBio": res.data["newUser"]["bio"]
        });
        CacheHelper.saveData(key: "userData", value: userData);
      }

      print(res);
    } catch (e) {
      print(e);
    }
  }

  Future<void> logIn(String email, String userPassword) async {
    final url = 'https://boiling-shelf-43809.herokuapp.com/user/signin';
    try {
      Response res = await dio.post(url, data: {
        "email": email,
        "password": userPassword,
      });
      print(res.data);
      token = res.data["token"];
      currentUser.name = res.data['user']['name'];
      currentUser.email = res.data['user']['email'];
      currentUser.id = res.data['user']['id'];
      currentUser.image = res.data['user']['url'];
      currentUser.bio = res.data['user']["bio"];
      if (token != null) {
        final userData = json.encode({
          "token": token,
          "userName": res.data['user']['name'],
          "userEmail": res.data['user']['email'],
          "userId": res.data['user']['id'],
          "imageUrl": res.data['user']['url'],
          "userBio": res.data['user']['bio']
        });
        CacheHelper.saveData(key: "userData", value: userData);
      }
      print(token);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> tryAutoLogin() async {
    if (!CacheHelper.sharedPreferences.containsKey("userData")) {
      return false;
    } else {
      final sharedUserData = json.decode(CacheHelper.getData(key: "userData"))
          as Map<String, Object>;
      token = sharedUserData["token"];
      currentUser.name = sharedUserData['userName'];
      currentUser.email = sharedUserData['userEmail'];
      currentUser.id = sharedUserData['userId'];
      currentUser.image = sharedUserData['imageUrl'];
      currentUser.bio = sharedUserData['userBio'];
      return true;
    }
  }

  void logOut(BuildContext context) {
    token = null;
    CacheHelper.sharedPreferences.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }
}
