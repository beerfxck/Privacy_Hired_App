import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/MaidDeatailForHired.dart';
import 'package:privacy_maid_flutter/components/TimeInfomation.dart';
import 'package:privacy_maid_flutter/components/UserDeatailForHired.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';

import '../components/DateForBook.dart';
import '../components/MaiddetailForBooking.dart';
import '../constant/domain.dart';
import '../model/BookWork.dart';

class UpcomingInformationPage extends StatefulWidget {
  final int? id_user;
  final int? bookingId;
  const UpcomingInformationPage({
    Key? key,
    this.id_user,
    this.bookingId,
  }) : super(key: key);

  @override
  State<UpcomingInformationPage> createState() =>
      _UpcomingInformationPageState();
}

class _UpcomingInformationPageState extends State<UpcomingInformationPage> {
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
        "status": 2,
        "user_booking": idUser,
      };
      print(maidWorkData);
      Response response = await dio.post(url_api + '/books/get-book-resident',
          data: maidWorkData);
      if (response.statusCode == 201) {
        final responseData = response.data;
        for (var element in responseData) {
          bookwork.add(BookWork(
            descriptmaid: element["descriptmaid"],
            servicePrice: element["service_price"],
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
    bool isCancelled = false;
    // void _showCancelDialog() {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         // title: Text("ยืนยันการยกเลิกรับบริการ"),
    //         content: Text(
    //           "คุณต้องการยกเลิกรับบริการหรือไม่?",
    //           style: GoogleFonts.kanit(
    //             textStyle: TextStyle(color: Colors.black),
    //             fontSize: 17,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //         actions: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop(); // Close the dialog
    //                 },
    //                 style: TextButton.styleFrom(
    //                   primary: Colors.black, // Button text color
    //                 ),
    //                 child: Text(
    //                   "ไม่",
    //                   style: GoogleFonts.kanit(
    //                     textStyle: TextStyle(color: Colors.black),
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //               ),
    //               TextButton(
    //                 onPressed: () {
    //                   // Perform the cancellation logic here
    //                   // This can include updating the state and making API calls
    //                   setState(() {
    //                     isCancelled = true;
    //                   });
    //                   Navigator.of(context).pop(); // Close the dialog
    //                 },
    //                 style: TextButton.styleFrom(
    //                   primary: Colors.red, // Button text color
    //                 ),
    //                 child: Text(
    //                   "ยกเลิก",
    //                   style: GoogleFonts.kanit(
    //                     textStyle:
    //                         TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 150, 63),
        title: Text(
          'การจองคิวของคุณ',
          style: GoogleFonts.kanit(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' คำขอเพิ่มเติม',
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
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.8,
                              ),
                            ),
                          ),
                          child: Text(
                            '${bookwork.isNotEmpty ? bookwork[0].descriptmaid : ""}',
                            style: GoogleFonts.kanit(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
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
              // InkWell(
              //   onTap: bookwork.isNotEmpty
              //       ? () {
              //           _showCancelDialog(); // Show the cancellation confirmation dialog
              //         }
              //       : null,
              //   child: Container(
              //     width: 300,
              //     height: 40,
              //     padding: const EdgeInsets.symmetric(vertical: 8),
              //     decoration: BoxDecoration(
              //       color: Colors.red,
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "ยกเลิกรับบริการ",
              //         style: const TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
