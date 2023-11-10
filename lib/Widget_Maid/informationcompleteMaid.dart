import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCompleteForMaid extends StatefulWidget {
  const InfoCompleteForMaid({Key? key}) : super(key: key);

  @override
  State<InfoCompleteForMaid> createState() => _InfoCompleteForMaidState();
}

class _InfoCompleteForMaidState extends State<InfoCompleteForMaid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(243, 255, 255, 255),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: Text(
            'รายละเอียดการจอง',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 0), // Reduced top margin
          padding: EdgeInsets.symmetric(
              horizontal: 25, vertical: 15), // Reduced vertical padding
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MainText('รายละเอียดการจอง'),
              buildDivider(),
              SupText('วันที่จอง :' + '   ดึงข้อมูล'),
              SupText('จำนวชั่วโมง : ' + '   ดึงข้อมูล'),
              buildDivider(),
              MainText('รายละเอียดทำความสะอาด'),
              SupText('หมายเลขห้อง :' + '   ดึงข้อมูล'),
              SupText('ขนาดห้อง :' + '   ดึงข้อมูล'),
              SupText('ชื่อเจ้าของห้อง :' + '   ดึงข้อมูล'),
              SupText('เบอร์โทรศัพท์ :' + '   ดึงข้อมูล'),
              buildDivider(),
              SupText('ค่าบริการ :' + '   ดึงข้อมูล'),
            ],
          ),
        ),
      ),
    );
  }

  Widget SupText(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4), // Adjust the vertical margin
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget MainText(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8), // Adjust the vertical margin
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        thickness: 1,
      ),
    );
  }
}
