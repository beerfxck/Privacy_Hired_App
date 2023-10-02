import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/Maid_Detail.dart';
import '../widgets/Upcoming_schedule.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Color.fromARGB(217, 217, 217, 217),
        leading: Container(
          child: Image.asset('images/logo_maid.png'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Text(
                'ยินดีต้อนรับ',
                textAlign: TextAlign.right,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontSize: 18,
                ),
              ),
              Text(
                'username',
                textAlign: TextAlign.right,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontSize: 14,
                ),
              ),
              Text(
                'กำลังดำเนินการ',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              UpcomingSchedule(),
              SizedBox(height: 20),
              Text(
                'แม่บ้านทั้งหมด',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              MaidDetail(),
            ],
          ),
        ),
      ),
    );
  }
}
