import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mates/cache_helper.dart';
import 'package:mates/presentation/screens/edit_profile_screen.dart';
import 'package:mates/presentation/screens/individual_chat_member_screen.dart';
import 'package:mates/presentation/screens/splash_screen.dart.dart';
import 'package:mates/providers/files_provider.dart';
import 'package:mates/providers/post_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import './presentation/screens/intro_screen.dart';
import './presentation/screens/login_screen.dart';
import './presentation/screens/signUp_screen.dart';
import './presentation/screens/home_screen.dart';
import './presentation/screens/search_screen.dart';
import './presentation/screens/create_team_screen.dart';
import './presentation/screens/view_members_screen.dart';
import './presentation/screens/profile_screen.dart';
import './presentation/screens/user_profile_screen.dart';
import './presentation/screens/shedule_meeting_screen.dart';
import './providers/Team_provider.dart';

import './providers/auth.dart';
import './providers/chat_provider.dart';
import './providers/meeting_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var deviceToken = await FirebaseMessaging.instance.getToken();
  await CacheHelper.init();
  initializeDateFormatting();
  runApp(MyApp(
    deviceToken: deviceToken,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var deviceToken;

  MyApp({this.deviceToken});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
            create: (context) => Auth(deviceToken: deviceToken)),
        ChangeNotifierProxyProvider<Auth, TeamProvider>(
            create: (context) => TeamProvider(),
            update: (context, auth, previous) =>
                TeamProvider(authToken: auth.token)),
        ChangeNotifierProxyProvider<Auth, PostProvider>(
            create: (context) => PostProvider(),
            update: (context, auth, previous) =>
                PostProvider(authToken: auth.token)),
        ChangeNotifierProxyProvider<Auth, FilesProvider>(
            create: (context) => FilesProvider(),
            update: (context, auth, previous) =>
                FilesProvider(authToken: auth.token)),
        ChangeNotifierProvider<MeetingProvider>(
            create: (context) => MeetingProvider()),
        ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authSnapshot, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mates',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: authSnapshot.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  builder: (ctx, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? SplashScreen()
                        : IntroScreen();
                  },
                  future: authSnapshot.tryAutoLogin(),
                ),
          routes: {
            IntroScreen.routeName: (_) => IntroScreen(),
            LoginScreen.routeName: (_) => LoginScreen(),
            SignUpScreen.routeName: (_) => SignUpScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
            SearchScreen.routeName: (_) => SearchScreen(),
            CreateTeamScreen.routeName: (_) => CreateTeamScreen(),
            ViewMembersScreen.routeName: (_) => ViewMembersScreen(),
            ProfileScreen.routeName: (_) => ProfileScreen(),
            UserProfileScreen.routeName: (_) => UserProfileScreen(),
            ScheduleMeeting.routeName: (_) => ScheduleMeeting(),
            EditProfileScreen.routeName: (_) => EditProfileScreen()

          },
        ),
      ),
    );
  }
}
