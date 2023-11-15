import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/BookWork.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:privacy_maid_flutter/screens/Home_page.dart';
import 'package:privacy_maid_flutter/screens/Report_page.dart';
import 'package:privacy_maid_flutter/widgets/navigatorbar.dart';

class UserReview extends StatefulWidget {
  final int? id_user;
  final int? idBooking;
  final double? rating;

  const UserReview({
    Key? key,
    this.rating,
    this.id_user,
    this.idBooking,
  }) : super(key: key);

  @override
  State<UserReview> createState() => _UserReviewtState();
}

class _UserReviewtState extends State<UserReview> {
  final dio = Dio();
  String? idUser;
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  List<maidWork> resident = [];
  List<BookWork> bookwork = [];
  double rating = 3.0;

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
        "booking_id": widget.idBooking,
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
            profile: element["profile"],
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

  Future<void> updateRating(BuildContext context) async {
    try {
      final response = await dio.post(
        url_api + '/books/update-Review',
        data: {
          'booking_id': widget.idBooking,
          'maid_rating': rating,
        },
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
        print('success');
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
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Container(
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: bookwork.isNotEmpty &&
                                  bookwork[0].profile != null
                              ? MemoryImage(base64Decode(bookwork[0].profile!))
                              : null,
                        ),
                        title: Text(
                          "${bookwork.isNotEmpty ? bookwork[0].fname : ""} ${bookwork.isNotEmpty ? bookwork[0].lname : ""}",
                          style: GoogleFonts.kanit(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          "หมายเลขการจอง  ${widget.idBooking}",
                          style: GoogleFonts.kanit(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'รีวิวการบริการ',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black),
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 20),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                              onRatingUpdate: (newRating) {
                                setState(() {
                                  rating = newRating;
                                });
                                print(rating);
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 4, 148, 9),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                updateRating(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 30.0,
                                ),
                                child: Text(
                                  'เสร็จสิ้น',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(color: Colors.white),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'หากมีปัญหาจากการบริการ',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(color: Colors.black54),
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportPage(
                                                bookingId: widget.idBooking,
                                              )),
                                    );
                                  },
                                  child: Text(
                                    'แจ้งปัญหา',
                                    style: GoogleFonts.kanit(
                                      decoration: TextDecoration.underline,
                                      textStyle: TextStyle(color: Colors.red),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
