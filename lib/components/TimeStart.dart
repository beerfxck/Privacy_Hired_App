import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeStartComponents extends StatefulWidget {
  final Function(String) onChanged;

  TimeStartComponents({Key? key, required this.onChanged}) : super(key: key);

  @override
  _TimeStartComponentsState createState() => _TimeStartComponentsState();
}

class _TimeStartComponentsState extends State<TimeStartComponents> {
  String? selectedHours; // To store the selected number of hours.

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
          items: <DropdownMenuItem<String>>[
            DropdownMenuItem<String>(
              value: '09:00 น.',
              child: Text(
                '9.00',
                style: GoogleFonts.kanit(
                  fontSize: 16,
                ),
              ),
            ),
            DropdownMenuItem<String>(
              value: '10:00',
              child: Text(
                '10.00 น.',
                style: GoogleFonts.kanit(
                  fontSize: 16,
                ),
              ),
            ),
            DropdownMenuItem<String>(
              value: '11:00',
              child: Text(
                '11.00 น.',
                style: GoogleFonts.kanit(
                  fontSize: 16,
                ),
              ),
            ),
            DropdownMenuItem<String>(
              value: '13:00',
              child: Text(
                '13.00 น.',
                style: GoogleFonts.kanit(
                  fontSize: 16,
                ),
              ),
            ),
            DropdownMenuItem<String>(
              value: '14:00',
              child: Text(
                '14.00 น.',
                style: GoogleFonts.kanit(
                  fontSize: 16,
                ),
              ),
            ),
            DropdownMenuItem<String>(
              value: '15:00',
              child: Text(
                '15.00 น.',
                style: GoogleFonts.kanit(
                  fontSize: 16,
                ),
              ),
            ),
            DropdownMenuItem<String>(
              value: '16:00',
              child: Text(
                '16.00 น.',
                style: GoogleFonts.kanit(
                  fontSize: 16,
                ),
              ),
            ),
          ],
          onChanged: (String? newValue) {
            setState(() {
              selectedHours = newValue;
              widget.onChanged(newValue!);
            });
          },
        ),
      ],
    );
  }
}
