import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:privacy_maid_flutter/components/Showprice.dart';
import 'package:privacy_maid_flutter/components/Time.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';
import 'package:privacy_maid_flutter/model/timeWork.dart';
import 'package:privacy_maid_flutter/components/Calendar.dart';

import '../components/MaidDeatailForHired.dart';
import '../components/SpecialRequired.dart';
import '../components/Terms_of_service.dart';
import '../components/TimeStart.dart';
import '../components/UserDeatailForHired.dart';

class HiredMaidPage extends StatefulWidget {
  final int? id_user;
  final String? workday;
  final int? id_worktime;
  final int? id_worktimetype;
  const HiredMaidPage(
      {Key? key,
      this.id_user,
      this.workday,
      this.id_worktime,
      this.id_worktimetype})
      : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HiredMaidPage> {
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  DateTime selectedDate = DateTime.now();
  int selectedHours = 1;
  int? sumprice;
  String start_work = '';
  final TextEditingController _textController = TextEditingController();
  final dio = Dio();
  List<TimeWork> maidWorklist = [];
  List<maidWork> resident = [];

  @override
  void initState() {
    getMaidWork();
    getData();
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
            username: element["username"],
            password: element["password"],
            fname: element["fname"],
            roomsize: element["roomsize"],
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

  int calculateServiceCost(int selectHour) {
    if (resident[0].roomsize == null) {
      return 0;
    } else if (resident[0].roomsize!.contains("26.5 - 29.5 sq m")) {
      return (400 + (selectHour) * 60);
    } else if (resident[0].roomsize!.contains("34.5 sq m")) {
      return (500 + (selectHour) * 60);
    } else if (resident[0].roomsize!.contains("49.5 - 50.25 sq m")) {
      return (650 + (selectHour) * 60);
    } else {
      return 0;
    }
  }

  List<int> durationOptions = [];
  selectedTimeByworktime(int? id_worktimetype, String? start_work) {
    if (start_work == '09:00' && id_worktimetype == 1) {
      durationOptions = [1, 2, 3];
    } else if (start_work == '10:00' && id_worktimetype == 1) {
      durationOptions = [1, 2];
    } else if (start_work == '11:00' && id_worktimetype == 1) {
      durationOptions = [1];
    } else if (start_work == '13:00' && id_worktimetype == 2) {
      durationOptions = [1, 2, 3, 4];
    } else if (start_work == '14:00' && id_worktimetype == 2) {
      durationOptions = [1, 2, 3];
    } else if (start_work == '15:00' && id_worktimetype == 2) {
      durationOptions = [1, 2];
    } else if (start_work == '16:00' && id_worktimetype == 2) {
      durationOptions = [1];
    } else if (start_work == '10:00' && id_worktimetype == 3) {
      durationOptions = [1, 2];
    } else if (start_work == '11:00' && id_worktimetype == 3) {
      durationOptions = [1];
    } else if (start_work == '11:00' && id_worktimetype == 4) {
      durationOptions = [1];
    } else if (start_work == '14:00' && id_worktimetype == 5) {
      durationOptions = [1, 2, 3];
    } else if (start_work == '15:00' && id_worktimetype == 5) {
      durationOptions = [1, 2];
    } else if (start_work == '16:00' && id_worktimetype == 5) {
      durationOptions = [1];
    } else if (start_work == '15:00' && id_worktimetype == 6) {
      durationOptions = [1, 2];
    } else if (start_work == '16:00' && id_worktimetype == 6) {
      durationOptions = [1];
    } else if (start_work == '16:00' && id_worktimetype == 7) {
      durationOptions = [1];
    } else if (start_work == '09:00' && id_worktimetype == 9) {
      durationOptions = [1];
    } else if (start_work == '11:00' && id_worktimetype == 9) {
      durationOptions = [1];
    } else if (start_work == '09:00' && id_worktimetype == 10) {
      durationOptions = [1, 2];
    } else if (start_work == '10:00' && id_worktimetype == 10) {
      durationOptions = [1];
    } else if (start_work == '10:00' && id_worktimetype == 11) {
      durationOptions = [1];
    } else if (start_work == '13:00' && id_worktimetype == 12) {
      durationOptions = [1];
    } else if (start_work == '15:00' && id_worktimetype == 12) {
      durationOptions = [1, 2];
    } else if (start_work == '13:00' && id_worktimetype == 13) {
      durationOptions = [1, 2];
    } else if (start_work == '14:00' && id_worktimetype == 13) {
      durationOptions = [1];
    } else if (start_work == '16:00' && id_worktimetype == 13) {
      durationOptions = [1];
    } else if (start_work == '13:00' && id_worktimetype == 14) {
      durationOptions = [1, 2, 3];
    } else if (start_work == '14:00' && id_worktimetype == 15) {
      durationOptions = [1];
    } else if (start_work == '15:00' && id_worktimetype == 15) {
      durationOptions = [1, 2];
    } else if (start_work == '14:00' && id_worktimetype == 16) {
      durationOptions = [1, 2];
    } else if (start_work == '15:00' && id_worktimetype == 17) {
      durationOptions = [1];
    } else if (start_work == '09:00' && id_worktimetype == 18) {
      durationOptions = [1];
    } else {
      durationOptions = [1];
    }
    setState(() {});
  }

  Future<void> updateWork(BuildContext context) async {
    try {
      Map<String, dynamic> requestData = {
        'id_worktime': widget.id_worktime,
      };

      if (widget.id_worktimetype == 1 &&
          selectedHours == 1 &&
          start_work == '09:00') {
        requestData['id_timeworktype'] = 3;
      } else if (widget.id_worktimetype == 1 &&
          selectedHours == 2 &&
          start_work == '09:00') {
        requestData['id_timeworktype'] = 4;
      } else if (widget.id_worktimetype == 1 &&
          selectedHours == 3 &&
          start_work == '09:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 1 &&
          selectedHours == 1 &&
          start_work == '10:00') {
        requestData['id_timeworktype'] = 9;
      } else if (widget.id_worktimetype == 1 &&
          selectedHours == 2 &&
          start_work == '10:00') {
        requestData['id_timeworktype'] = 18;
      } else if (widget.id_worktimetype == 1 &&
          selectedHours == 1 &&
          start_work == '11:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 3 &&
          selectedHours == 1 &&
          start_work == '10:00') {
        requestData['id_timeworktype'] = 4;
      } else if (widget.id_worktimetype == 3 &&
          selectedHours == 2 &&
          start_work == '10:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 4 &&
          selectedHours == 1 &&
          start_work == '11:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 2 &&
          selectedHours == 1 &&
          start_work == '13:00') {
        requestData['id_timeworktype'] = 5;
      } else if (widget.id_worktimetype == 2 &&
          selectedHours == 2 &&
          start_work == '13:00') {
        requestData['id_timeworktype'] = 6;
      } else if (widget.id_worktimetype == 2 &&
          selectedHours == 3 &&
          start_work == '13:00') {
        requestData['id_timeworktype'] = 7;
      } else if (widget.id_worktimetype == 2 &&
          selectedHours == 1 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 12;
      } else if (widget.id_worktimetype == 2 &&
          selectedHours == 2 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 19;
      } else if (widget.id_worktimetype == 2 &&
          selectedHours == 3 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 2 &&
          selectedHours == 1 &&
          start_work == '15:00') {
        requestData['id_timeworktype'] = 13;
      } else if (widget.id_worktimetype == 2 &&
          selectedHours == 2 &&
          start_work == '15:00') {
        requestData['id_timeworktype'] = 20;
      } else if (widget.id_worktimetype == 2 &&
          selectedHours == 1 &&
          start_work == '16:00') {
        requestData['id_timeworktype'] = 21;
      } else if (widget.id_worktimetype == 5 &&
          selectedHours == 1 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 6;
      } else if (widget.id_worktimetype == 5 &&
          selectedHours == 2 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 7;
      } else if (widget.id_worktimetype == 5 &&
          selectedHours == 3 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 6 &&
          selectedHours == 1 &&
          start_work == '15:00') {
        requestData['id_timeworktype'] = 7;
      } else if (widget.id_worktimetype == 6 &&
          selectedHours == 2 &&
          start_work == '15:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 6 &&
          selectedHours == 1 &&
          start_work == '16:00') {
        requestData['id_timeworktype'] = 22;
      } else if (widget.id_worktimetype == 7 &&
          selectedHours == 1 &&
          start_work == '16:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 9 &&
          selectedHours == 1 &&
          start_work == '09:00') {
        requestData['id_timeworktype'] = 4;
      } else if (widget.id_worktimetype == 9 &&
          selectedHours == 1 &&
          start_work == '11:00') {
        requestData['id_timeworktype'] = 7;
      } else if (widget.id_worktimetype == 10 &&
          selectedHours == 1 &&
          start_work == '09:00') {
        requestData['id_timeworktype'] = 4;
      } else if (widget.id_worktimetype == 10 &&
          selectedHours == 2 &&
          start_work == '09:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 11 &&
          selectedHours == 1 &&
          start_work == '10:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 12 &&
          selectedHours == 1 &&
          start_work == '13:00') {
        requestData['id_timeworktype'] = 6;
      } else if (widget.id_worktimetype == 12 &&
          selectedHours == 1 &&
          start_work == '15:00') {
        requestData['id_timeworktype'] = 19;
      } else if (widget.id_worktimetype == 12 &&
          selectedHours == 2 &&
          start_work == '15:00') {
        requestData['id_timeworktype'] = 22;
      } else if (widget.id_worktimetype == 12 &&
          selectedHours == 1 &&
          start_work == '16:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 13 &&
          selectedHours == 1 &&
          start_work == '13:00') {
        requestData['id_timeworktype'] = 5;
      } else if (widget.id_worktimetype == 13 &&
          selectedHours == 2 &&
          start_work == '13:00') {
        requestData['id_timeworktype'] = 23;
      } else if (widget.id_worktimetype == 13 &&
          selectedHours == 1 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 12;
      } else if (widget.id_worktimetype == 13 &&
          selectedHours == 1 &&
          start_work == '16:00') {
        requestData['id_timeworktype'] = 22;
      } else if (widget.id_worktimetype == 14 &&
          selectedHours == 1 &&
          start_work == '13:00') {
        requestData['id_timeworktype'] = 5;
      } else if (widget.id_worktimetype == 14 &&
          selectedHours == 2 &&
          start_work == '13:00') {
        requestData['id_timeworktype'] = 7;
      } else if (widget.id_worktimetype == 14 &&
          selectedHours == 3 &&
          start_work == '13:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 14 &&
          selectedHours == 1 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 13;
      } else if (widget.id_worktimetype == 14 &&
          selectedHours == 2 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 19;
      } else if (widget.id_worktimetype == 15 &&
          selectedHours == 1 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 7;
      } else if (widget.id_worktimetype == 15 &&
          selectedHours == 1 &&
          start_work == '16:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 16 &&
          selectedHours == 1 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 17;
      } else if (widget.id_worktimetype == 16 &&
          selectedHours == 2 &&
          start_work == '14:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 16 &&
          selectedHours == 1 &&
          start_work == '15:00') {
        requestData['id_timeworktype'] = 8;
      } else if (widget.id_worktimetype == 17 &&
          selectedHours == 1 &&
          start_work == '15:00') {
        requestData['id_timeworktype'] = 8;
      }

      final response = await dio.post(
        url_api + '/maidwork/update-work',
        data: requestData,
      );

      if (response.statusCode == 201) {
        print('Success');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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

  String? idUser;
  void saveMaidWork(BuildContext context) async {
  idUser = await storageToken.read(key: 'id_user');

  try {
    // Validate data before sending the request
    if (widget.workday == null ||
        selectedHours == null ||
        start_work == null ||
        _textController.text.isEmpty ||
        widget.id_user == null ||
        widget.id_worktime == null) {
      // Handle incomplete data
      Fluttertoast.showToast(
        msg: "กรุณาใส่ข้อมูลให้ครบถ้วน",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // You might want to show a dialog or toast to inform the user.
      return;
    }

    final Map<String, dynamic> maidWorkData = {
      "booking_date": widget.workday,
      "work_hour": selectedHours,
      "start_work": start_work,
      "descriptmaid": _textController.text,
      "service_price": calculateServiceCost(selectedHours),
      "status": 1,
      "maid_rating": 0,
      "user_booking": idUser,
      "maidbooking": widget.id_user,
      "id_maidwork": widget.id_worktime
    };

    print(maidWorkData);

    Response response =
        await dio.post(url_api + '/books/save', data: maidWorkData);

    if (response.statusCode == 201) {
      updateWork(context);
      Fluttertoast.showToast(
        msg: "จองเสร็จสิ้น",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushNamed(context, '/BottomNavBar');
    } else {
      print("HTTP Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
    Fluttertoast.showToast(
      msg: "กรุณาใส่ข้อมูลให้ครบถ้วน",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buttomNew(context),
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
            textStyle: TextStyle(color: Colors.green),
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ' รายละเอียดการจอง',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.black),
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              MaidDetailForHired(
                id_user: widget.id_user,
              ),
              SizedBox(
                height: 5,
              ),
              HorizontalDividerWithText(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'วันที่ต้องการรับบริการ  ${widget.workday == null ? '' : convertDate(widget.workday)}',
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
                width: 350,
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
                    elevation: 10,
                  ),
                  icon: Icon(Icons.calendar_month),
                  label: Text(
                    'เลือกวันทำความสะอาด',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.white),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TimeStartComponents(
                onChanged: (data) => {
                  start_work = data,
                  selectedTimeByworktime(widget.id_worktimetype, start_work)
                },
                id_worktimetype: widget.id_worktimetype,
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                        child: Text(
                          'จำนวนชั่วโมง : ',
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
                    items: durationOptions.map((durationOption) {
                      return DropdownMenuItem<int>(
                        value: durationOption,
                        child: Text(
                          '$durationOption ชั่วโมง',
                          style: GoogleFonts.kanit(
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
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
              SizedBox(height: 15),
              // TimeStartComponents(
              //   onChanged: (data) => {start_work = data},
              //   id_worktimetype: widget.id_worktimetype,
              // ),
              // SpecialTextField(),

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
                      'ความต้องการเพิ่มเติม :  ',
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: Colors.grey), // Set border color to black
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: ' เช่น เน้นความสะอาดห้องน้ำ, ห้องนอน ฯลฯ',
                    hintStyle: GoogleFonts.kanit(),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              UserDetailForHired(),
              SizedBox(height: 10),
              Totalprice(selectHour: selectedHours),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttomNew(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 25, right: 20, left: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0), topRight: Radius.circular(0)),
      ),
      child: elememtButtom(),
    );
  }

  Widget elememtButtom() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => {saveMaidWork(context)},
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.green,
                                    Colors.green,
                                  ])),
                          height: 40,
                          width: double.infinity,
                          child: Text('จอง',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.white),
                                fontSize: 18,
                              ))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HorizontalDividerWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            'กรุณาจองล่วงหน้าอย่างน้อย 1 วัน',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.grey[700],
              ),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.black,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
