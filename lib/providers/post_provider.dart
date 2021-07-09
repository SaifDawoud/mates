import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mates/models/reply_model.dart';
import '../models/post_model.dart';

class PostProvider with ChangeNotifier {
  String authToken;

  PostProvider({this.authToken});

  Dio dio = Dio();
  List<Post> posts = [];
  List<Reply> replies = [];

//posts
  void addPost(String teamId, String postBody) async {
    try {
      Response res = await dio.post(
          "https://boiling-shelf-43809.herokuapp.com/post/$teamId/addPost",
          options: Options(headers: {'authorization': authToken}),
          data: {"postBody": postBody});
      posts = res.data["posts"];
      notifyListeners();
      print(res);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPosts(String teamId) async {
    posts = [];
    try {
      Response res = await dio.get(
        "https://boiling-shelf-43809.herokuapp.com/post/$teamId/allPosts",
        options: Options(headers: {'authorization': authToken}),
      );
      print(res.data);
      res.data['post'].forEach((val) {
        posts.add(Post(
            body: val['body'],
            creatorName: val['ownerName'],
            date: val['date'],
            id: val['_id'],
            creatorId: val['postOwner'],
            comments: val['comments'],
            creatorImage: val['ownerImage']));
      });
    } catch (e) {
      print(e);
    }
  }

  void deletePost(String postId) async {
    try {
      Response res = await dio.delete(
        'https://boiling-shelf-43809.herokuapp.com/post/$postId/deletePost',
        options: Options(headers: {'authorization': authToken}),
      );
      print(res);
      int postIndex = posts.indexWhere((element) => element.id == postId);
      posts.removeAt(postIndex);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void editPost(String postId,String postBody)async{
    try{

      Response res=await dio.put("https://boiling-shelf-43809.herokuapp.com/post/$postId/editPost",options: Options(headers: {'authorization': authToken}),data: {"postBody":postBody});
      print(res);
   final postIndex =posts.indexWhere((element) => element.id==res.data["post"]["_id"]);
   if(postIndex>=0){
     posts[postIndex]=Post(id:res.data["post"]["_id"] ,date:res.data["post"]["date"] ,creatorImage:res.data["post"]["ownerImage"] ,creatorName: res.data["post"]["ownerName"],body:res.data["post"]["body"] ,comments:res.data["post"]["comments"] );
     notifyListeners();
   }
    }catch(e){print(e);}
  }

  //replies

  Future<List<Reply>> getAllReplies(String postId) async {
    replies = [];
    try {
      Response res = await dio.get(
          "https://boiling-shelf-43809.herokuapp.com/post/$postId/allReply",
          options: Options(headers: {'authorization': authToken}));
      print(res);
      res.data["replys"].forEach((r) {
        replies.add(Reply(
            id: r['_id'],
            userName: r['ownerName'],
            userImageUrl: r["ownerImage"],
            replyBody: r["commentBody"],
            date: r["commentDate"]));
      });
      return [...replies.reversed];
    } catch (e) {
      print(e);
    }
  }

  void addReply(String postId,String replyBody) async {
    Response res = await dio.post(
      "https://boiling-shelf-43809.herokuapp.com/post/$postId/addReply",data: {"commentBody":replyBody},
      options: Options(headers: {'authorization': authToken}),
    );
   replies=res.data['replys'];
    notifyListeners();
    print(res);
  }

  void deleteReply(String postId, String replyId) async {
    Response res = await dio.delete(
        "https://boiling-shelf-43809.herokuapp.com/post/$postId/$replyId/deleteReply",
        options: Options(headers: {'authorization': authToken}));
    print(res);
    int replyIndex = replies.indexWhere((element) => element.id == replyId);
    replies.removeAt(replyIndex);
    notifyListeners();
  }
  void editReply(String postId,String replyId,String replyBody)async{
    try{

      Response res=await dio.put("https://boiling-shelf-43809.herokuapp.com/post/$postId/$replyId/editReply",options: Options(headers: {'authorization': authToken}),data: {"commentBody":replyBody});
      print(res);
      final replyIndex =replies.indexWhere((element) => element.id==res.data["com"]["_id"]);
      print(replyIndex);
      if(replyIndex>=0){
        replies[replyIndex]=Reply(id:res.data["com"]["_id"] ,date:res.data["com"]["commentDate"] ,replyBody:res.data["com"]["commentBody"] ,userName:res.data["com"]["ownerName"] ,userImageUrl:res.data["com"]["ownerImage"]  );
        notifyListeners();
      }
    }catch(e){print(e);}
  }

}
