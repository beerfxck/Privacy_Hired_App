import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:privacy_maid_flutter/components/Showprice.dart';
import 'package:privacy_maid_flutter/components/Time.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/timeWork.dart';
import 'package:privacy_maid_flutter/components/Calendar.dart';

import '../components/MaidDeatailForHired.dart';
import '../components/Terms_of_service.dart';
import '../components/UserDeatailForHired.dart';

class HiredMaidPage extends StatefulWidget {
  final int? id_user;
  final String? workday;
  const HiredMaidPage({Key? key, this.id_user, this.workday}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HiredMaidPage> {
  DateTime selectedDate = DateTime.now();
  int selectedHours = 1;
  final dio = Dio();
  List<TimeWork> maidWorklist = [];

  @override
  void initState() {
    getMaidWork();
    super.initState();
  }

  void getMaidWork() async {
    try {
      Response response = await dio
          .get(url_api + '/maidwork/getwork/' + widget.id_user.toString());
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        List<TimeWork> maidWorkList = responseData
            .map((dynamic item) => TimeWork.fromJson(item))
            .toList();

        setState(() {
          maidWorklist = maidWorkList;
        });
      } else {
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/BottomNavBar');
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.green,
          ),
        ),
        title: Text(
          'การจองคิวของคุณ',
          style: GoogleFonts.kanit(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
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
                MaidDetailForHired(id_user: widget.id_user),
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          //child: Icon(Icons.calendar_month_rounded),
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'วันที่รับบริการ :',
                            style: GoogleFonts.kanit(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 240,
                  height: 45,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              TableEventsExample(id_user: widget.id_user),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: StadiumBorder(),
                      elevation: 10,
                    ),
                    icon: Icon(Icons.calendar_month),
                    label: Text(
                      'จองคิว',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.white),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          //child: Icon(Icons.watch_later_rounded),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                          child: Text(
                            'จำนวนชั่วโมง :',
                            style: GoogleFonts.kanit(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<int>(
                      value: selectedHours,
                      items: <DropdownMenuItem<int>>[
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            '1 ชั่วโมง',
                            style: GoogleFonts.kanit(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text(
                            '2 ชั่วโมง',
                            style: GoogleFonts.kanit(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text(
                            '3 ชั่วโมง',
                            style: GoogleFonts.kanit(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedHours = newValue!;
                        });
                      },
                      icon: Icon(Icons.watch_later_rounded),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                UserDetailForHired(),
                MyWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
//   List<DropdownMenuItem<int>> dropdownItems = worktimes!.map((worktime) {
//   return DropdownMenuItem<int>(
//     value: worktime['id_worktime'], // Use the appropriate value from your data
//     child: Text(
//       worktime['day'],
//       style: GoogleFonts.kanit(
//         fontSize: 16,
//       ),
//     ),
//   );
// }).toList();
// List<Map<String, dynamic>> worktimes = [
//   {
//     "id_worktime": 44,
//     "status": null,
//     "day": "2023-10-03T17:00:00.000Z",
//     "id_timeworktype": 1,
//     "id_user": 36
//   },
//   {
//     "id_worktime": 47,
//     "status": null,
//     "day": "2023-09-11T17:00:00.000Z",
//     "id_timeworktype": 2,
//     "id_user": 36
//   }
// ];
}
