import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/WorkInfoForMaid.dart';
import 'package:privacy_maid_flutter/screens/HiredInfomation.dart';

import '../Widget_Maid/info_process.dart';
import '../Widget_Maid/informationcompleteMaid.dart';
import '../constant/domain.dart';
import '../model/BookWork.dart';
import '../model/maidWork.dart';

class WorkforMaid extends StatefulWidget {
  const WorkforMaid({super.key});

  @override
  State<WorkforMaid> createState() => _WorkforMaidState();
}

class _WorkforMaidState extends State<WorkforMaid> {
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
        "status": 1,
        "maidbooking": idUser,
      };
      print(maidWorkData);
      Response response =
          await dio.post(url_api + '/books/get-book-maid', data: maidWorkData);
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
            roomnumber: element["roomnumber"],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        children: [
          if (bookWork.length == 0)
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "ไม่มีรายการ",
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          if (bookWork.length != 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: bookWork.map((booking) {
                return SizedBox(
                  child: Container(
                    padding: EdgeInsets.all(13),
                    margin: EdgeInsets.fromLTRB(1, 10, 1, 1),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 241, 230),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
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
                            contentPadding: EdgeInsets.fromLTRB(2, 10, 70, 0),
                            trailing: Text(
                              "ห้อง ${booking.roomnumber ?? ""}",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            title: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blueGrey,
                                child: Icon(
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
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "${convertDate(booking.bookingDate) ?? ""}",
                                    style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black54),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "${booking.startWork ?? ""}",
                                    style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black54),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => InfoProcessForMaid(
                                        bookingId: booking.bookingId,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 150,
                                  height: 40,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 6, 143, 6),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "กดเพื่อเริ่มงาน",
                                      style: GoogleFonts.kanit(
                                        textStyle:
                                            TextStyle(color: Colors.black54),
                                        fontSize: 14,
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
        ],
      ),
    );
  }
}
