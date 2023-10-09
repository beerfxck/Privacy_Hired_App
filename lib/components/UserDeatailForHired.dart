import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailForHired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // A
      children: [
        Text(
          'รายละเอียดทำความสะอาด',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 7),
        ListView(
          shrinkWrap:
              true, // To make the ListView take only the required height
          physics: NeverScrollableScrollPhysics(), // Disable ListView scrolling
          children: [
            Text(
              'หมายเลขห้อง : 123/1',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black),
                fontSize: 18,
              ),
            ),
            Text(
              'ขนาดห้อง : 26-28 ตารางเมตร',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black),
                fontSize: 18,
              ),
            ),
            Text(
              'ชื่อเจ้าของห้อง : นางลูกบ้าน เช่าอยู่',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black),
                fontSize: 18,
              ),
            ),
            Text(
              'เบอร์โทรศัพท์ : 0887658874',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
