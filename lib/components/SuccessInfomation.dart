import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/MaidDeatailForHired.dart';
import 'package:privacy_maid_flutter/components/TimeInfomation.dart';
import 'package:privacy_maid_flutter/components/UserDeatailForHired.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/BookWork.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';

class SuccessInfo extends StatefulWidget {
  final int? id_user;
  final int? bookingId;
  const SuccessInfo({
    Key? key,
    this.id_user,
    this.bookingId,
  }) : super(key: key);

  @override
  State<SuccessInfo> createState() => _SuccessInfoState();
}

class _SuccessInfoState extends State<SuccessInfo> {
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
        "booking_id": widget.bookingId.toString(),
        "user_booking": idUser,
      };
      print(maidWorkData);
      Response response =
          await dio.post(url_api + '/books/get-book-info', data: maidWorkData);
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
      
      // Additional processing to remove time part
      final dateOnly = datePart.split(' ')[0];

      return dateOnly;
    }
  }
  return "";
}

  @override
  Widget build(BuildContext context) {
    if (bookwork.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(243, 255, 255, 255),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
            child: Text(
              'รายละเอียด',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Center(
          child: Text('ไม่พบข้อมูลการจอง'),
        ),
      );
    }

    final booking = bookwork[0];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(243, 255, 255, 255),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
          child: Text(
            'รายละเอียด',
            style: TextStyle(color: Colors.black),
          ),
        ),
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
              SizedBox(height: 10),
              MaidDetailForHired(
                bookingId: widget.bookingId,
                id_user: booking.maidbooking,
              ),
              Divider(thickness: 1),
              SizedBox(height: 10),
              TimeInfomation(bookingId: widget.bookingId),
              Divider(thickness: 1),
              SizedBox(height: 10),
              UserDetailForHired(),
              Divider(thickness: 1),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'คำขอเพิ่มเติม',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.black),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${bookwork.isNotEmpty ? bookwork[0].descriptmaid : ""}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ค่าบริการ : ${booking.servicePrice?.toString() ?? ""}',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.black),
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    '${booking.statusDescription}',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.green),
                      fontSize: 22,
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
