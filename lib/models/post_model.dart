import 'package:flutter/material.dart';

class Post {
  String id;
  List<dynamic> comments;
  String creatorName;
  String creatorImage;
  String date;
  String body;
  String creatorId;
  Post({this.body,this.id,this.comments,this.creatorImage,this.creatorId,this.creatorName,this.date});
}
