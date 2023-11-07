import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/MaidDeatailForHired.dart';
import 'package:privacy_maid_flutter/components/TimeInfomation.dart';
import 'package:privacy_maid_flutter/components/UserDeatailForHired.dart';

import '../components/DateForBook.dart';
import '../components/MaiddetailForBooking.dart';
import '../constant/domain.dart';
import '../model/BookWork.dart';

class InformationPage extends StatefulWidget {
  final int? id_user;
  const InformationPage({
    Key? key,
    this.id_user,
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
  @override
  Widget build(BuildContext context) {
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
          child: Column(children: <Widget>[
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
            // MaidDetailForHired(id_user: widget.id_user),
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
            MaiddetailForBooking(),
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
            DateForBook(),
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
                  'ค่าบริการ : ' '${bookwork.isNotEmpty ? bookwork[0].servicePrice : ""}',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.black),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
