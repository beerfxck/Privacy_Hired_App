import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:privacy_maid_flutter/components/Showprice.dart';
import 'package:privacy_maid_flutter/components/Time.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
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
  const HiredMaidPage({
    Key? key,
    this.id_user,
    this.workday,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HiredMaidPage> {
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  DateTime selectedDate = DateTime.now();
  int selectedHours = 1;
  String start_work = '';
  final TextEditingController _textController = TextEditingController();
  final dio = Dio();
  List<TimeWork> maidWorklist = [];

  @override
  void initState() {
    getMaidWork();
    super.initState();
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
      final Map<String, dynamic> maidWorkData = {
        "booking_date": widget.workday != null ? widget.workday : "23023-10-30",
        "work_hour": selectedHours,
        "start_work": start_work,
        "descriptmaid": _textController.text,
        "service_price": 790,
        "maid_rating": 4,
        "status": 1,
        "user_booking": idUser,
        "maidbooking": widget.id_user,
      };
      print(maidWorkData);
      Response response =
          await dio.post(url_api + '/books/save', data: maidWorkData);
      if (response.statusCode == 201) {
        Navigator.pushNamed(context, '/BottomNavBar');
        print("Maid work saved successfully");
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
            textStyle: TextStyle(color: Colors.black),
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
              MaidDetailForHired(
                id_user: widget.id_user,
              ),
              SizedBox(
                height: 10,
              ),
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
                          'วันที่รับบริการ : ${widget.workday == null ? '' : convertDate(widget.workday)}',
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
                    'จองเวลาทำความสะอาด',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.white),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // TableEventsExample(id_user:widget.id_user),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

              TimeStartComponents(
                onChanged: (data) => {start_work = data},
              ),
              SizedBox(height: 20),
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
                      'เน้นส่วนไหนเป็นพิเศษ  ',
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
                      color: Colors.black), // Set border color to black
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'บอกหรือไม่บอกก็ได้',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              UserDetailForHired(),
              MyWidget(),
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
