import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/model/BookWork.dart';

import '../constant/domain.dart';

class MaiddetailForBooking extends StatefulWidget {
  @override
  _MaiddetailForBookingState createState() => _MaiddetailForBookingState();
}

class _MaiddetailForBookingState extends State<MaiddetailForBooking> {
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
          await dio.get(url_api + '/books/get-book-resident/' + idUser!);
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
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ชื่อ นามสกุล : ',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.black),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'เบอร์โทรศัพท์ :',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.black),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${bookwork.isNotEmpty ? bookwork[0].fname : ""} ${bookwork.isNotEmpty ? bookwork[0].lname : ""}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${bookwork.isNotEmpty ? bookwork[0].phone : ""}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
