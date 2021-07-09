import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatefulWidget {
  Function selectPage;
  int selectedIndex;

  MyBottomNavBar({this.selectPage, this.selectedIndex});

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(type: BottomNavigationBarType.fixed,
        onTap: widget.selectPage,
        currentIndex: widget.selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
              label: 'Calendar', icon: Icon(Icons.date_range_outlined,)),

          BottomNavigationBarItem(
              label: 'Teams', icon: Icon(Icons.people_outline)),
          BottomNavigationBarItem(
              label: 'Chat', icon: Icon(Icons.chat_outlined)),
          BottomNavigationBarItem(
              label: 'Notification', icon: Icon(Icons.notifications_none_outlined))
        ]);
  }
}
