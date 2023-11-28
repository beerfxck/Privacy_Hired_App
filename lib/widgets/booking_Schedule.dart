import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';
import 'package:privacy_maid_flutter/screens/HiredInfomation.dart';

import '../constant/domain.dart';
import '../model/BookWork.dart';
import '../screens/Infomation_Page.dart';

class BookingSchedule extends StatefulWidget {
  const BookingSchedule({Key? key}) : super(key: key);

  @override
  _BookingScheduleState createState() => _BookingScheduleState();
}

class _BookingScheduleState extends State<BookingSchedule> {
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
        "status": 1,
        "user_booking": idUser,
      };
      print(maidWorkData);
      Response response = await dio.post(url_api + '/books/get-book-resident',
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
            statusDescription: element["status_description"],
          ));
        }
        setState(() {});
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      bookwork = [];
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
    return bookwork.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(4, 5, 5, 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: bookwork.map((booking) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(3, 0, 3, 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding:
                                const EdgeInsets.fromLTRB(4, 10, 18, 4),
                            trailing: Text(
                              "${bookwork.isNotEmpty ? 'ชื่อ: ${bookwork[0].fname ?? ''}\nนามสกุล: ${bookwork[0].lname ?? ''}' : ''}",
                              style: GoogleFonts.kanit(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 3, 3),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blueGrey,
                                child: const Icon(
                                  Icons.work_history_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${convertDate(bookwork.isNotEmpty ? bookwork[0].bookingDate : "") ?? ""}',
                                    style: GoogleFonts.kanit(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${bookwork.isNotEmpty ? bookwork[0].startWork : ""}",
                                    style: GoogleFonts.kanit(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${bookwork.isNotEmpty ? bookwork[0].statusDescription : ""}",
                                    style: GoogleFonts.kanit(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: bookwork.isNotEmpty
                                    ? () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => InformationPage(
                                              bookingId: bookwork[0].bookingId),
                                        ));
                                      }
                                    : null,
                                child: Container(
                                  width: 320,
                                  height: 40,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 9, 150, 63),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "รายละเอียด",
                                      style: GoogleFonts.kanit(
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
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        : Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text("ไม่มีรายการการจองคิว",
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey,
                    )),
              ),
            ),
          );
  }
}
