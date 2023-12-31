import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeStartComponents extends StatefulWidget {
  final Function(String) onChanged;
  final int? id_worktimetype;
  TimeStartComponents({Key? key, required this.onChanged, this.id_worktimetype})
      : super(key: key);

  @override
  _TimeStartComponentsState createState() => _TimeStartComponentsState();
}

class _TimeStartComponentsState extends State<TimeStartComponents> {
  String? selectedHours;

  List<String> generateTimeSlots(int? id_worktimetype) {
    List<String> timeSlots = [];

    if (id_worktimetype == 1) {
      timeSlots = ['09:00', '10:00', '11:00'];
    } else if (id_worktimetype == 2) {
      timeSlots = ['13:00', '14:00', '15:00', '16:00'];
    } else if (id_worktimetype == 3) {
      timeSlots = ['10:00', '11:00'];
    } else if (id_worktimetype == 4) {
      timeSlots = ['11:00'];
    } else if (id_worktimetype == 5) {
      timeSlots = ['14:00', '15:00', '16:00'];
    } else if (id_worktimetype == 6) {
      timeSlots = ['15:00', '16:00'];
    } else if (id_worktimetype == 7) {
      timeSlots = ['16:00'];
    } else if (id_worktimetype == 9) {
      timeSlots = ['09:00', '11:00'];
    } else if (id_worktimetype == 10) {
      timeSlots = ['09:00', '10:00'];
    } else if (id_worktimetype == 11) {
      timeSlots = ['10:00', '12:00'];
    } else if (id_worktimetype == 12) {
      timeSlots = ['13:00', '15:00', '16:00'];
    } else if (id_worktimetype == 13) {
      timeSlots = ['13:00', '14:00', '16:00'];
    } else if (id_worktimetype == 14) {
      timeSlots = ['13:00', '14:00', '15:00'];
    } else if (id_worktimetype == 15) {
      timeSlots = ['14:00', '16:00'];
    } else if (id_worktimetype == 16) {
      timeSlots = ['14:00', '15:00'];
    } else if (id_worktimetype == 17) {
      timeSlots = ['15:00'];
    } else if (id_worktimetype == 18) {
      timeSlots = ['09:00'];
    } else if (id_worktimetype == 19) {
      timeSlots = ['13:00', '14:00', '16:00'];
    } else if (id_worktimetype == 20) {
      timeSlots = ['13:00', '14:00', '15:00'];
    }

    return timeSlots;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.watch_later_rounded),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8),
              child: Text(
                'เวลาเริ่มงาน :',
                style: GoogleFonts.kanit(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        DropdownButtonFormField<String>(
          value: selectedHours,
          items: generateTimeSlots(widget.id_worktimetype).map((timeSlot) {
            return DropdownMenuItem<String>(
              value: timeSlot,
              child: Text(
                '$timeSlot น.',
                style: GoogleFonts.kanit(
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedHours = newValue;
              widget.onChanged(newValue!);
              print(selectedHours);
            });
          },
        )
      ],
    );
  }
}
