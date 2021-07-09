import 'package:flutter/material.dart';
import '../widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ListView(
        children: [NotificationCard(), NotificationCard()],
      ),
    );
  }
}
