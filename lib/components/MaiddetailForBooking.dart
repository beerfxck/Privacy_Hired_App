import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaiddetailForBooking extends StatefulWidget {
  @override
  _MaiddetailForBookingState createState() => _MaiddetailForBookingState();
}

class _MaiddetailForBookingState extends State<MaiddetailForBooking> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ชื่อ นามสกุล :',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.black),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'เบอร์โทรศัพท์ :',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.black),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ป้าศรี มีใจ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '0876667364',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
