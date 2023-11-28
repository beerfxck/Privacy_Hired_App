import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';

class MaidDetailForHired extends StatefulWidget {
  final int? id_user;
  final String? workday;
  final int? bookingId;
  const MaidDetailForHired(
      {Key? key, this.id_user, this.workday, this.bookingId})
      : super(key: key);
  @override
  _MaidDetailForHiredState createState() => _MaidDetailForHiredState();
}

class _MaidDetailForHiredState extends State<MaidDetailForHired> {
  final dio = Dio();
  List<maidWork> maidWorklist = [];
  @override
  void initState() {
    getMaidByID();
    super.initState();
  }

  void getMaidByID() async {
    try {
      Response response = await dio
          .get(url_api + '/user/get-resident/' + widget.id_user.toString());
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
    return Column(
      children: maidWorklist.map((maidWork) {
        return Row(
            children: <Widget>[
              Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 17, 5),
                      child: maidWork.profile != null
                          ? Image.memory(
                              base64Decode(maidWork.profile!),
                              width: 100,
                              height: 95,
                            )
                          : Icon(
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
                      'ชื่อ นามสกุล :',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.black),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'เบอร์โทรศัพท์ :',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.black),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '${maidWork.fname!} ${maidWork.lname!}',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      '${maidWork.phone!}',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
        );
      }).toList(),
    );
  }
}
