import 'dart:convert';

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
      Response response = await dio.get(url_api + '/user/get-maid');
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        List<maidWork> maidWorkList = responseData
            .map((dynamic item) => maidWork.fromJson(item))
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
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: maidWorklist.map((maidWork) {
            return Container(
              padding: EdgeInsets.all(40),
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
                        size: 48,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'ชื่อ: ${maidWork.fname!}',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black54),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'นามสกุล: ${maidWork.lname!}',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black54),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'อายุ: ${maidWork.birthday!.toString()}',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black54),
                            fontSize: 16,
                          ),
                        ),
                        if (maidWork.profile !=
                            null) // ตรวจสอบว่ามีรูปภาพหรือไม่
                          Image.memory(
                            base64Decode(maidWork.profile!),
                            width: 200,
                            height: 200,
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
                              builder: (context) => HiredMaidPage(
                                id_user: maidWork.idUser!,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: StadiumBorder(),
                          elevation: 3,
                        ),
                        child: Text(
                          'จอง',
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
