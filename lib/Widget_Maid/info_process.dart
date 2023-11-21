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
      Response response = await dio.post(url_api + '/books/get-bookmaid-info',
          data: maidWorkData);
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
      setState(() {});
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

  Future<void> updateStatus(BuildContext context) async {
    try {
      final response = await dio.post(
        url_api + '/books/update-status',
        data: {
          'booking_id': widget.bookingId,
          'status': 2,
        },
      );

      if (response.statusCode == 201) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MaidBottomNavBar(),
            settings: RouteSettings(
              arguments: 1, 
            ),
          ),
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateCancelStatus(BuildContext context) async {
    try {
      final response = await dio.post(
        url_api + '/books/update-status',
        data: {
          'booking_id': widget.bookingId,
          'status': 7,
        },
      );

      if (response.statusCode == 201) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MaidBottomNavBar(),
            settings: RouteSettings(
              arguments: 1, 
            ),
          ),
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isCancelled = false;
    void _showCancelDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "คุณต้องการยกเลิกให้บริการหรือไม่?",
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.black, 
                    ),
                    child: Text(
                      "ไม่",
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.black),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      updateCancelStatus(context);
                      setState(() {
                        isCancelled = true;
                      });
                      Navigator.of(context).pop(); 
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.red, 
                    ),
                    child: Text(
                      "ยกเลิก",
                      style: GoogleFonts.kanit(
                        textStyle:
                            TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

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
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0), 
            padding: EdgeInsets.symmetric(
                horizontal: 25, vertical: 15),
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

                  
                  SupText('วันที่จอง :' +
                      '${convertDate(bookwork.isNotEmpty ? bookwork[0].bookingDate : "") ?? ""}'), 
                  SupText('เวลาเริ่มงาน : ' +
                      '${bookwork.isNotEmpty ? bookwork[0].startWork : ""}'), 
                  SupText('จำนวนชั่วโมง : ' +
                      '${bookwork.isNotEmpty ? bookwork[0].workHour : ""}'), 
                  buildDivider(),

                  
                  MainText('รายละเอียดทำความสะอาด'),
                  SupText('หมายเลขห้อง :' +
                      '${bookwork.isNotEmpty ? bookwork[0].roomnumber : ""}'), 
                  SupText('ขนาดห้อง :' +
                      '${bookwork.isNotEmpty ? bookwork[0].roomsize : ""}'), 
                  SupText('ชื่อเจ้าของห้อง :' +
                      '${bookwork.isNotEmpty ? bookwork[0].fname : ""} ${bookwork.isNotEmpty ? bookwork[0].lname : ""}'), 
                  SupText('เบอร์โทรศัพท์ :' +
                      '${bookwork.isNotEmpty ? bookwork[0].phone : ""}'), 
                  buildDivider(),

                  
                  MainText('คำขอเพิ่มเติม'), 
                  RequireText(
                      '${bookwork.isNotEmpty ? bookwork[0].descriptmaid : ""}'), 
                  buildDivider(),

                  
                  SupText('ค่าบริการ :' +
                      (bookwork.isNotEmpty
                          ? bookwork[0].servicePrice.toString()
                          : "")), //ใส่ตรงนี้

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          updateStatus(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), 
                          ),
                        ),
                        child: Container(
                          width: 300,
                          child: Center(
                            child: Text(
                              'เริ่มงาน',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: bookwork.isNotEmpty
                            ? () {
                                _showCancelDialog();
                              }
                            : null,
                        child: Container(
                          width: 334,
                          height: 40,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "ยกเลิกการใหบริการ",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ));
  }

  Widget SupText(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4), 
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
      margin: EdgeInsets.symmetric(vertical: 8),
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
