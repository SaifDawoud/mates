import 'package:flutter/material.dart';

import '../screens/search_screen.dart';
import '../widgets/my_bottom_nav_bar.dart';
import '../widgets/my_drawer.dart';
import '../pages/calendar_page.dart';
import '../pages/notification_page.dart';
import '../pages/teams_page.dart';
import '../pages/chat_page.dart';
import 'create_team_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> _pages = [
    {'page': CalendarPage(), 'title': 'Calendar'},
    {'page': TeamsPage(), 'title': 'Teams'},
    {'page': ChatScreen(), 'title': 'Chat'},
    {'page': NotificationPage(), 'title': 'Notification'}
  ];

  int selectedIndex = 1;
  @override
   Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${_pages[selectedIndex]['title']}',
            style: TextStyle(color: Colors.white)),
        actions: [
          _pages[selectedIndex]['title'] == 'Teams'
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateTeamScreen.routeName);
                  },
                )
              : Container()
        ],
      ),
      body: _pages[selectedIndex]['page'],
      drawer: MyDrawer(),

      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: selectedIndex,
        selectPage: selectedPage,
      ),
    );
  }
}
