import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/MaidDeatailForHired.dart';
import 'package:privacy_maid_flutter/components/TimeInfomation.dart';
import 'package:privacy_maid_flutter/components/UserDeatailForHired.dart';
import 'package:privacy_maid_flutter/screens/Home_page.dart';
import 'package:privacy_maid_flutter/widgets/navigatorbar.dart';

import '../components/DateForBook.dart';
import '../components/MaiddetailForBooking.dart';
import '../constant/domain.dart';
import '../model/BookWork.dart';

class InformationPage extends StatefulWidget {
  final int? id_user;
  final int? bookingId;
  const InformationPage({
    Key? key,
    this.id_user,
    this.bookingId,
  }) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final dio = Dio();
  String? idUser;
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  List<BookWork> bookwork = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      bookwork = [];
      idUser = await storageToken.read(key: 'id_user');
      final response =
          await dio.get(url_api + '/books/get-book-residentnew/' + idUser!);
      if (response.statusCode == 200) {
        final responseData = response.data;
        for (var element in responseData) {
          bookwork.add(BookWork(
            bookingId: element["booking_id"],
            bookingDate: element["booking_date"],
            workHour: element["work_hour"],
            startWork: element["start_work"],
            descriptmaid: element["descriptmaid"],
            servicePrice: element["service_price"],
            paymentslip: element["paymentslip"],
            profile: element["profile"],
            phone: element["phone"],
            status: element["status "],
            statusDescription: element["status_description"],
            fname: element["fname"],
            nickname: element["nickname"],
            lname: element["lname"],
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

  Future<void> updateStatus(BuildContext context) async {
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
            builder: (context) => BottomNavBar(),
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
            // title: Text("ยืนยันการยกเลิกรับบริการ"),
            content: Text(
              "คุณต้องการยกเลิกรับบริการหรือไม่?",
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
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.black, // Button text color
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
                      updateStatus(context);
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
            padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
            child: Text(
              'รายละเอียด',
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' รายละเอียดการจอง',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.black),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  //height: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaiddetailForBooking(bookingId: widget.bookingId),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  //height: 20,
                ),
              ),
              DateForBook(bookingId: widget.bookingId),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  //height: 20,
                ),
              ),
              UserDetailForHired(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  //height: 20,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    'ค่าบริการ : '
                    '${bookwork.isNotEmpty ? bookwork[0].servicePrice : ""}',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.black),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: bookwork.isNotEmpty
                    ? () {
                        _showCancelDialog(); // Show the cancellation confirmation dialog
                      }
                    : null,
                child: Container(
                  width: 300,
                  height: 40,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "ยกเลิกรับบริการ",
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
          ),
        ),
      ),
    );
  }
}
