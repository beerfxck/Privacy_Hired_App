import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';

class MaidDetailForHired extends StatefulWidget {
  final int? id_user;
  const MaidDetailForHired({Key? key, this.id_user}) : super(key: key);
  @override
  _MaidDetailForHiredState createState() => _MaidDetailForHiredState();
}

class _MaidDetailForHiredState extends State<MaidDetailForHired> {
  final dio = Dio();
  List<maidWork> maidWorklist = [];
  @override
  void initState() {
    super.initState();
    getMaidByID();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${maidWork.fname!} ${maidWork.lname!}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '0986787764',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
