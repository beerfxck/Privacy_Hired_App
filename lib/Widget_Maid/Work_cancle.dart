import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constant/domain.dart';
import '../model/BookWork.dart';
import '../model/maidWork.dart';

class WorkCancleComponent extends StatefulWidget {
  @override
  _WorkCancleComponentState createState() => _WorkCancleComponentState();
}

class _WorkCancleComponentState extends State<WorkCancleComponent> {
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
        "status": 7,
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
            roomnumber: element["roomnumber"],
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
        return datePart;
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: bookWork.map((booking) {
          return SizedBox(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 232, 241, 230),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "เลขห้อง :  ${booking.roomnumber ?? ""}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: CircleAvatar(
                        radius: 25,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 20,
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
                              style: TextStyle(
                                color: Colors.black54,
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
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 221, 6, 6),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${booking.statusDescription ?? ""}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(137, 231, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
