import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportComponents extends StatefulWidget {
  @override
  _ReportComponentsState createState() => _ReportComponentsState();
}

class _ReportComponentsState extends State<ReportComponents> {
  TextEditingController _reportController = TextEditingController();

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  void _handleSubmit() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color.fromARGB(255, 216, 216, 216),
                width: 1.5, 
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _reportController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'กรอกปัญหาที่ต้องการแจ้ง...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _handleSubmit,
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                'แจ้งปัญหา',
                style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
