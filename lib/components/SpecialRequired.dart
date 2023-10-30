import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialTextField extends StatefulWidget {
  @override
  _SpecialTextFieldState createState() => _SpecialTextFieldState();
}

class _SpecialTextFieldState extends State<SpecialTextField> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            'เน้นส่วนไหนเป็นพิเศษ',
            style: GoogleFonts.kanit(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border:
                Border.all(color: Colors.black), // Set border color to black
            color: Colors.white,
          ),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'บอกหรือไม่บอกก็ได้',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
