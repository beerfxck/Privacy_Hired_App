import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';

import '../screens/Hiredmaid_page.dart';

class MaidDetail extends StatefulWidget {
  const MaidDetail({Key? key}) : super(key: key);

  @override
  State<MaidDetail> createState() => _MaidDetailState();
}

class _MaidDetailState extends State<MaidDetail> {
  final dio = Dio();
  List<maidWork> maidWorklist = [];

  @override
  void initState() {
    getMaid();
    super.initState();
  }

  void getMaid() async {
    try {
      Response response = await dio.get(url_api + '/maidwork/getwork');
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        List<maidWork> maidWorkList = responseData
            .map((dynamic item) => maidWork.fromJson(item))
            .toList();

        setState(() {
          maidWorklist = maidWorkList;
        });
      } else {
        // Handle HTTP error
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      // Handle Dio error or network error
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: maidWorklist.map((maidWork) {
            return Container(
              padding: EdgeInsets.all(40), //ขนาดกล่อง
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.person,
                        size: 48, // ขนาดไอคอน
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          maidWork
                              .fname!, // Use the appropriate property from maidWork
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black54),
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          maidWork
                              .lname!, // Use the appropriate property from maidWork
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black54),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HiredMaidPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text(
                          'ว่าง',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.white),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}