import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/Upcoming_schedule.dart';
import '../widgets/Complete_schedule.dart';
import '../widgets/Cancle_schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _ScheduleState();
}

class _ScheduleState extends State<SchedulePage> {
  int index = 0;

  final _scheduleWidgets = [
    UpcomingSchedule(),
    CompleteSchedule(),
    Cancle(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor:Color.fromARGB(217, 217, 217, 217),
        leading: Padding(
          padding: EdgeInsets.only(left: 35.0),
          child: Transform.scale(
            scale: 3.5,
            child: Image.asset('images/logo_maid.png'),
          ),
        ),
      ),
    
      body: ContainedTabBarView(
        tabs: [
          Text('ดำเนินการ', style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
          Text('เสร็จสิ้น', style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
          Text('ยกเลิก', style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
        ],
        views: [
          UpcomingSchedule(),
          CompleteSchedule(),
          Cancle(),
        ],
        onChange: (index) => _scheduleWidgets[index],
      ),
    );
  }
}