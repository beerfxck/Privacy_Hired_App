import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Maid_Navigatorbar.dart';

class InfoProcessForMaid extends StatefulWidget {
  const InfoProcessForMaid({Key? key}) : super(key: key);

  @override
  State<InfoProcessForMaid> createState() => _InfoProcessForMaidState();
}

class _InfoProcessForMaidState extends State<InfoProcessForMaid> {
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

              //รายละเอียดวันที่ จำนวนชั่วโมง เวลาเริ่ม
              SupText('วันที่จอง :' + '   ดึงข้อมูล'), //ใส่ตรงนี้
              SupText('เวลาเริ่มงาน : ' + '   ดึงข้อมูล'), //ใส่ตรงนี้
              SupText('จำนวชั่วโมง : ' + '   ดึงข้อมูล'), //ใส่ตรงนี้
              buildDivider(),

              //รายละเอียดลูกช้านที่จง
              MainText('รายละเอียดทำความสะอาด'),
              SupText('หมายเลขห้อง :' + '   ดึงข้อมูล'), //ใส่ตรงนี้
              SupText('ขนาดห้อง :' + '   ดึงข้อมูล'), //ใส่ตรงนี้
              SupText('ชื่อเจ้าของห้อง :' + '   ดึงข้อมูล'), //ใส่ตรงนี้
              SupText('เบอร์โทรศัพท์ :' + '   ดึงข้อมูล'), //ใส่ตรงนี้
              buildDivider(),

              //คำขเพิ่มเติม
              MainText('คำขอเพิ่มเติม'), //ใส่ตรงนี้
              RequireText('เน้นห้องน้ำลบาๆๆ'), //ใส่ตรงนี้
              buildDivider(),

              //ราคา
              SupText('ค่าบริการ :' + '   ดึงข้อมูล'), //ใส่ตรงนี้

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MaidBottomNavBar(),
                        settings: RouteSettings(
                          arguments:
                              1, // Set the current index to 1 (second page).
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text(
                    'เริ่มงาน',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
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

  Widget RequireText(String text) {
    return Container(
      width: 350,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Color.fromARGB(255, 216, 216, 216),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
          ),
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
