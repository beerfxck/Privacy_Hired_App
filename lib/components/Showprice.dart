import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
  color: Colors.white, // Set the background color of the container
  padding: EdgeInsets.all(16), // Adjust padding as needed
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'ค่าบริการ',
        style: GoogleFonts.kanit(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      SizedBox(height: 10), // Add some spacing between text and button
      ElevatedButton(
        onPressed: () {
          // Button on pressed action
        },
        child: Text(
          'ชำระเงิน',
          style: GoogleFonts.kanit(
            fontSize: 16,
          ),
        ),
      ),
    ],
  ),
),
    );
  }
}