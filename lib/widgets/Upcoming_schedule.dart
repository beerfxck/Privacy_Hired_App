import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/model/BookWork.dart';
import 'package:privacy_maid_flutter/screens/HiredInfomation.dart';

import '../constant/domain.dart';

class UpcomingSchedule extends StatefulWidget {
  const UpcomingSchedule({super.key});
  @override
  _UpcomingScheduleState createState() => _UpcomingScheduleState();
}

class _UpcomingScheduleState extends State<UpcomingSchedule> {
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
      final response = await dio.get(url_api + '/books/get-book-resident/' + idUser!);
      if (response.statusCode == 200) {
        final responseData = response.data;
        for (var element in responseData) {
          bookwork.add(BookWork(
            username: element["username"],
            password: element["password"],
            fname: element["fname"],
            lname: element["lname"],
            idUser: element["id_user"],
          ));
        }
        setState(() {});
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that may occur during the request
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.fromLTRB(3, 0, 3, 15),
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
                    contentPadding: EdgeInsets.only(top: 20, right: 17),
                    trailing: Text(
                      "แม่บ้านกำลังทำความสะอาด",
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.black),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.all(5),
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
                      //color: Colors.black,
                      thickness: 1,
                      //height: 20,
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
                            "27/09/2023",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.black54),
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
                            "16:30 AM",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.black54),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "ระหว่างทำ",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.black54),
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
                        onTap: () {},
                        child: Container(
                          width: 150,
                          height: 40,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 221, 2, 2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "ยกเลิกการจอง",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black54),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HiredInfomation(), // Make sure this is a valid widget
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 141, 141, 141),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "รายละเอียด",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black54),
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
        ],
      ),
    );
  }
}
