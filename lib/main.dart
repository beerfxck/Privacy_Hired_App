import 'package:flutter/material.dart';
import 'package:privacy_maid_flutter/screens/Home_page.dart';
import 'package:privacy_maid_flutter/screens/Login_page.dart';
import 'package:privacy_maid_flutter/widgets/Upcoming_schedule.dart';
import 'package:privacy_maid_flutter/widgets/navigatorbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/BottomNavBar': (context) => BottomNavBar(),
        //'/UpcomingSchedule': (context) => UpcomingSchedule(),
      },
    );
  }
}
