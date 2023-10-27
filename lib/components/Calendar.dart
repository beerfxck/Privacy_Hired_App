import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/timeWork.dart';

class DateSelectionComponent extends StatefulWidget {
  final int id_user;
  const DateSelectionComponent({Key? key, required this.id_user})
      : super(key: key);

  @override
  _DateSelectionComponentState createState() => _DateSelectionComponentState();
}

class _DateSelectionComponentState extends State<DateSelectionComponent> {
  DateTime selectedDate = DateTime.now();
  final dio = Dio();
  List<TimeWork> maidWorklist = [];
  Map<DateTime, List<TimeWork>> events = {};

  @override
  void initState() {
    getMaidWork();
    super.initState();
  }

  void getMaidWork() async {
    try {
      Response response = await dio
          .get(url_api + '/maidwork/getwork/' + widget.id_user.toString());
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        List<TimeWork> maidWorkList = responseData
            .map((dynamic item) => TimeWork.fromJson(item))
            .toList();

        setState(() {
          maidWorklist = maidWorkList;

          // Update events based on maidWork data
          events = Map.fromIterable(maidWorklist,
              key: (e) {
                final DateTime workDate = DateTime.parse(e.day!);
                return DateTime(workDate.year, workDate.month, workDate.day);
              },
              value: (e) => [e]);
        });
      } else {
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    getMaidWork();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromARGB(255, 43, 45, 46),
                width: 1.0,
              ),
            ),
            child: TextFormField(
              controller: TextEditingController(text: formattedDate),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                suffixIcon: Icon(Icons.calendar_month),
                border: InputBorder.none,
              ),
              enabled: false,
            ),
          ),
        ),
        TableCalendar(
          firstDay: DateTime(2000),
          lastDay: DateTime(2101),
          focusedDay: selectedDate,
          calendarFormat: CalendarFormat.month,
          eventLoader: (day) {
            final eventsOnDay = events[day];
            return eventsOnDay ?? [];
          },
          onPageChanged: (date) {
            setState(() {
              selectedDate = date;
            });
          },
          onDaySelected: (date, _) {
            // Ignore the other parameters
            setState(() {
              selectedDate = date;
            });
          },
        ),
      ],
    );
  }
}
