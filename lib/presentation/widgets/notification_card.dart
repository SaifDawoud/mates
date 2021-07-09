import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 25,
          ),
          title: Text('saif Dawoud'),
          subtitle: Row(
            children: [
              Icon(
                Icons.file_upload,
                size: 20,
                color: Colors.grey,
              ),
              Text(
                'uploaded file',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          trailing: Text(
            'milion years ago',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
        Divider(
          endIndent: 0,
          height: 8,
          thickness: 2,
          color: Colors.blueGrey,
          indent: 20,
        ),
      ],
    );
  }
}
