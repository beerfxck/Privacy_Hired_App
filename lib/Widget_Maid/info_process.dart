import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/BookWork.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';

import 'Maid_Navigatorbar.dart';

class InfoProcessForMaid extends StatefulWidget {
  final int? id_user;
  final int? bookingId;
  const InfoProcessForMaid({
    Key? key,
    this.id_user,
    this.bookingId,
  }) : super(key: key);

  @override
  State<InfoProcessForMaid> createState() => _InfoProcessForMaidState();
}

class _InfoProcessForMaidState extends State<InfoProcessForMaid> {
final dio = Dio();
  String? idUser;
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  List<maidWork> resident = [];
  List<BookWork> bookwork = [];

  @override
  void initState() {
    getData();
    getbookWork();
    super.initState();
  }

  Future<void> getData() async {
    try {
      resident = [];
      idUser = await storageToken.read(key: 'id_user');
      final response = await dio.get(url_api + '/user/get-resident/' + idUser!);
      if (response.statusCode == 200) {
        final responseData = response.data;
        for (var element in responseData) {
          resident.add(maidWork(
            idUser: element["id_user"],
          ));
        }
        setState(() {});
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getbookWork() async {
    idUser = await storageToken.read(key: 'id_user');
    try {
      final Map<String, dynamic> maidWorkData = {
        "booking_id": widget.bookingId,
        "maidbooking": idUser,
      };
      print(maidWorkData);
      Response response =
          await dio.post(url_api + '/books/get-bookmaid-info', data: maidWorkData);
      if (response.statusCode == 201) {
        final responseData = response.data;
        for (var element in responseData) {
          bookwork.add(BookWork(
            idUser: element["id_user"],
            bookingDate: element["booking_date"],
            bookingId: element["booking_id"],
            workHour: element["work_hour"],
            startWork: element["start_work"],
            descriptmaid: element["descriptmaid"],
            servicePrice: element["service_price"],
            maidbooking: element["maidbooking"],
            fname: element["fname"],
            lname: element["lname"],
            phone: element["phone"],
            roomnumber: element["roomnumber"],
            roomsize: element["roomsize"],
            statusDescription: element["status_description"],
          ));
        }
        setState(() {});
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String? convertDate(String? inputDate) {
    if (inputDate != null) {
      final parts = inputDate.split('T');
      if (parts.length >= 1) {
        final datePart = parts[0];
        return datePart;
      }
    }
    return "";
  }

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
              SupText('วันที่จอง :' + '${convertDate(bookwork.isNotEmpty ? bookwork[0].bookingDate : "") ?? ""}'), //ใส่ตรงนี้
              SupText('เวลาเริ่มงาน : ' + '${bookwork.isNotEmpty ? bookwork[0].startWork : ""}'), //ใส่ตรงนี้
              SupText('จำนวนชั่วโมง : ' + '${bookwork.isNotEmpty ? bookwork[0].workHour : ""}'), //ใส่ตรงนี้
              buildDivider(),

              //รายละเอียดลูกช้านที่จง
              MainText('รายละเอียดทำความสะอาด'),
              SupText('หมายเลขห้อง :' + '${bookwork.isNotEmpty ? bookwork[0].roomnumber : ""}'), //ใส่ตรงนี้
              SupText('ขนาดห้อง :' + '${bookwork.isNotEmpty ? bookwork[0].roomsize : ""}'), //ใส่ตรงนี้
              SupText('ชื่อเจ้าของห้อง :' + '${bookwork.isNotEmpty ? bookwork[0].fname : ""} ${bookwork.isNotEmpty ? bookwork[0].lname : ""}'), //ใส่ตรงนี้
              SupText('เบอร์โทรศัพท์ :' + '${bookwork.isNotEmpty ? bookwork[0].phone : ""}'), //ใส่ตรงนี้
              buildDivider(),

              //คำขเพิ่มเติม
              MainText('คำขอเพิ่มเติม'), //ใส่ตรงนี้
              RequireText('${bookwork.isNotEmpty ? bookwork[0].descriptmaid : ""}'), //ใส่ตรงนี้
              buildDivider(),

              //ราคา
              SupText('ค่าบริการ :' + (bookwork.isNotEmpty
                          ? bookwork[0].servicePrice.toString()
                          : "")), //ใส่ตรงนี้

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
