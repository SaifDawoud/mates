// import 'package:flutter/material.dart';
// import'package:provider/provider.dart';
// import '../../providers/device_files.dart';
//
// class ProfileScreen extends StatelessWidget {
//   static const String routeName = 'profile_screen';
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceFiles=Provider.of<DeviceFiles>(context);
//     return SafeArea(
//       child: Scaffold(
//         body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           Stack(children: [
//             Container(
//               height: 300,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image:deviceFiles.profilePic==null? AssetImage('assets/images/user.jpg'):FileImage(deviceFiles.profilePic))),
//             ),
//             Positioned(
//                 right: 2,
//                 child: IconButton(
//                   icon: Icon(Icons.edit_outlined),
//                   onPressed: deviceFiles.openFileManagerProFile,
//                 ))
//           ]),
//           Divider(
//             thickness: 2,
//             endIndent: 30,
//             indent: 30,
//             color: Colors.grey,
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: Text('Name '),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               'fatakat',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: Text('Email '),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Text('Email@Email.com',
//                 textAlign: TextAlign.start,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//           )
//         ]),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mates/presentation/screens/edit_profile_screen.dart';

import 'package:mates/providers/auth.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "Profile_screen";

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              //circle avatar position
              height: 210.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    //cover photo
                    child: Container(
                      height: 160.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            4.0,
                          ),
                          topRight: Radius.circular(
                            4.0,
                          ),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.dribbble.com/users/1552574/screenshots/12001214/media/2d37e6a859623880ec44d2645e119220.jpg?compress=1&resize=800x600"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 64.0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(auth.currentUser.image)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(auth.currentUser.name??"name",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Text(
              auth.currentUser.bio??"bio",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(Icons.email_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(auth.currentUser.email),
                  Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context,EditProfileScreen.routeName);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
