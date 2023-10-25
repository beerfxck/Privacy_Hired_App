import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widget_Maid/Work_cancle.dart';
import '../Widget_Maid/Work_complete.dart';
import '../widgets/Complete_schedule.dart';
import '../widgets/Cancle_schedule.dart';

class MaidSchedulePage extends StatefulWidget {
  const MaidSchedulePage({Key? key}) : super(key: key);

  @override
  State<MaidSchedulePage> createState() => _MaidScheduleState();
}

class _MaidScheduleState extends State<MaidSchedulePage> {
  int index = 0;

  final _scheduleWidgets = [
    CompleteSchedule(),
    Cancle(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Color.fromARGB(217, 217, 217, 217),
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
          Text(
            'เสร็จสิ้น',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(color: Colors.black),
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          Text(
            'ยกเลิก',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(color: Colors.black),
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ],
        views: [
          WorkCompleteComponent(),
          WorkCancleComponent(),
        ],
        onChange: (index) => _scheduleWidgets[index],
      ),
    );
  }
}
