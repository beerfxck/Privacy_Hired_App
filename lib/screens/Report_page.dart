import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/Report.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(243, 255, 255, 255),

        title: Padding(
          padding: const EdgeInsets.fromLTRB(94, 0, 0, 0),
          child: Text(
            'แจ้งปัญหา',
            style: GoogleFonts.kanit(color: Colors.black),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color.fromARGB(255, 216, 216, 216),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                  child: Text(
                    'ชื่อผู้อาศัย : นายจิรเมธ สารทะนงค์',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                  child: Text(
                    'หมายเลขการจอง :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                SizedBox(height: 20),
                ReportComponents(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
