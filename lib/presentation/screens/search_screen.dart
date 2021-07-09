import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = 'search_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: TextField(
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: 'search',
              hintStyle: TextStyle(color: Colors.grey)),
        ),
      ),
      body: Center(child: Text('No Teams Found!')),
    );
  }
}
