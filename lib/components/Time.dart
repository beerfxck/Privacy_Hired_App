import 'package:flutter/material.dart';

class HourSelection extends StatefulWidget {
  @override
  _HourSelectionState createState() => _HourSelectionState();
}

class _HourSelectionState extends State<HourSelection> {
  int selectedHours = 1;

  void selectHours(int hours) {
    setState(() {
      selectedHours = hours;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'เลือกจำนวนชั่วโมง',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _buildHourButton(1),
              _buildHourButton(2),
              _buildHourButton(3),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          'จำนวนที่เลือก: $selectedHours ชั่วโมง',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildHourButton(int hours) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          selectHours(hours);
        },
        style: ElevatedButton.styleFrom(
          primary: selectedHours == hours ? Colors.green : Colors.grey,
        ),
        child: Text(
          '$hours ชั่วโมง',
          style: TextStyle(
            color: selectedHours == hours ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
