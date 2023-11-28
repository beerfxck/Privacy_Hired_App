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
import '../screens/UpcomingIfomation.dart';

class UpcomingSchedule extends StatefulWidget {
  const UpcomingSchedule({Key? key}) : super(key: key);

  @override
  _UpcomingScheduleState createState() => _UpcomingScheduleState();
}

class _UpcomingScheduleState extends State<UpcomingSchedule> {
  final dio = Dio();
  String? idUser;
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  List<maidWork> resident = [];
  List<BookWork> bookWork = [];

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
        "status": 2,
        "user_booking": idUser,
      };
      print(maidWorkData);
      Response response = await dio.post(url_api + '/books/get-book-resident',
          data: maidWorkData);
      if (response.statusCode == 201) {
        final responseData = response.data;
        for (var element in responseData) {
          bookWork.add(BookWork(
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 15, 3, 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bookWork.map((booking) {
            return Container(
              padding: const EdgeInsets.fromLTRB(3, 0, 3, 10),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 241, 230),
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
                      contentPadding: EdgeInsets.only(top: 20, right: 17),
                      trailing: Text(
                        "${booking.fname != null ? 'ชื่อ: ${booking.fname}\nนามสกุล: ${booking.lname ?? ''}' : ''}",
                        style: GoogleFonts.kanit(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(5),
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
                              '${convertDate(booking.bookingDate) ?? ""}',
                              style: const TextStyle(
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
                              "${booking.startWork ?? ""}",
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
                              "${booking.statusDescription ?? ""}",
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
                        // InkWell(
                        //   onTap: () {},
                        //   child: Container(
                        //     width: 150,
                        //     height: 40,
                        //     padding: const EdgeInsets.symmetric(vertical: 8),
                        //     decoration: BoxDecoration(
                        //       color: const Color.fromARGB(255, 221, 2, 2),
                        //       borderRadius: BorderRadius.circular(30),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "ยกเลิกการจอง",
                        //         style: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w400,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        InkWell(
                          onTap: booking.idUser != null
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpcomingInformationPage(
                                              id_user: booking.idUser,
                                              bookingId: booking.bookingId),
                                    ),
                                  );
                                }
                              : null,
                          child: Container(
                            width: 350,
                            height: 40,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
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
            );
          }).toList(),
        ),
      ),
    );
  }
}

