import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import'../../providers/auth.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final deviceFiles = Provider.of<DeviceFiles>(context);
    final auth=Provider.of<Auth>(context);
    return Drawer(
        elevation: 5,

        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(64, 123, 255, 1),
                    borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                height: 110,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:  NetworkImage("https://cdn.dribbble.com/users/56251/screenshots/14696619/media/0b2a6cada922652e64fab0f07dadd3f9.png?compress=1&resize=800x600"),
                                fit: BoxFit.cover),
                          )),
                      Text( auth.currentUser.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(splashColor: Color.fromRGBO(142, 238, 238, 1),
                    onTap: () {Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName,(_)=>false);},
                    child: ListTile(
                      title: Text('Home', style: TextStyle(fontSize: 17)),
                      leading: Icon(
                        Icons.home_outlined,
                        size: 35,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(splashColor: Color.fromRGBO(142, 238, 238, 1),
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                    child: ListTile(
                      title: Text('Profile', style: TextStyle(fontSize: 17)),
                      leading: Icon(
                        Icons.person_outlined,
                        size: 35,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(splashColor: Color.fromRGBO(142, 238, 238, 1),
                    onTap: () {},
                    child: ListTile(
                      title: Text('About Us', style: TextStyle(fontSize: 17)),
                      leading: Icon(
                        Icons.people_outlined,
                        size: 35,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(splashColor:Color.fromRGBO(142, 238, 238, 1) ,
                    onTap: () {},
                    child: ListTile(
                      title: Text('Settings', style: TextStyle(fontSize: 17)),
                      leading: Icon(
                        Icons.settings_outlined,
                        size: 35,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: RaisedButton.icon(
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromRGBO(64, 123, 255, 1),
                    onPressed: (){auth.logOut(context);},
                    icon: Icon(
                      Icons.logout,
                      size: 35,
                      color: Colors.white,
                    ),
                    label: Text('Log Out')),
              )

            ],
          ),
        ));
  }
}
