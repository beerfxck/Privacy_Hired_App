import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:privacy_maid_flutter/model/timeWork.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDate;
  final List<TimeWork> maidWorklist;

  CalendarWidget({required this.selectedDate, required this.maidWorklist});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: List.generate(7, (index) {
          final day = widget.selectedDate.subtract(Duration(days: widget.selectedDate.weekday - 1));
          final date = day.add(Duration(days: index));

          final matchingWork = widget.maidWorklist.where((work) {
            final workDate = DateTime.parse(work.day!);
            return workDate.isAtSameMomentAs(date);
          }).toList();

          return Row(
            children: [
              Text(
                DateFormat('d').format(date), // แสดงวันที่
                style: TextStyle(fontSize: 18),
              ),
              Text(
                matchingWork.isNotEmpty
                    ? 'มีงาน: ${matchingWork.length} งาน'
                    : 'ไม่มีงาน',
                style: TextStyle(fontSize: 16),
              ),
            ],
          );
        }),
      ),
    );
  }
}
