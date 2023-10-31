import 'package:flutter/material.dart';
import 'package:privacy_maid_flutter/Widget_Maid/Maid_Navigatorbar.dart';
import 'package:privacy_maid_flutter/screens/Hiredmaid_page.dart';
import 'package:privacy_maid_flutter/screens/Home_page.dart';
import 'package:privacy_maid_flutter/screens/Login_page.dart';
import 'package:privacy_maid_flutter/screens/Report_page.dart';
import 'package:privacy_maid_flutter/screens/UserReview.dart';
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
        '/ReportPage': (context) => ReportPage(),
        '/MaidBottomNavBar': (context) => MaidBottomNavBar(),
        '/UserReview': (context) => UserReview(),
      },
    );
  }
}
