import 'package:flutter/material.dart';

import '../components/Maid_Detail.dart';
import '../widgets/Upcoming_schedule.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'แม่บ้านทั้งหมด',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 0),
              Text(
                'กำลังดำเนินการ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              UpcomingSchedule(),
              SizedBox(height: 20),
              Text(
                'แม่บ้านทั้งหมด',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              MaidDetail(),
              MaidDetail(),
              MaidDetail(),
              MaidDetail(),
              MaidDetail(),
            ],
          ),
        ),
      ),
    );
  }
}
