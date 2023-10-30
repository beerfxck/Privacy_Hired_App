import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/WorkForMaidhomepage.dart';

import 'package:privacy_maid_flutter/widgets/Upcoming_schedule.dart';

import '../constant/domain.dart';
import '../model/maidWork.dart';

class MaidHomePage extends StatefulWidget {
  const MaidHomePage({super.key});

  @override
  State<MaidHomePage> createState() => _MaidHomePageState();
}

class _MaidHomePageState extends State<MaidHomePage> {
  final dio = Dio();
  String? idUser;
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  List<maidWork> maid = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      maid = [];
      idUser = await storageToken.read(key: 'id_user');
      final response = await dio.get(url_api + '/user/get-resident/' + idUser!);
      if (response.statusCode == 200) {
        final responseData = response.data;
        for (var element in responseData) {
          maid.add(maidWork(
            username: element["username"],
            password: element["password"],
            fname: element["fname"],
            lname: element["lname"],
            idUser: element["id_user"],
          ));
        }
        setState(() {});
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that may occur during the request
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Color.fromARGB(217, 255, 255, 255),
        leading: Padding(
          padding: EdgeInsets.only(left: 35.0),
          child: Transform.scale(
            scale: 3.5,
            child: Image.asset('images/logo_maid.png'),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Text(
                'ยินดีต้อนรับ',
                textAlign: TextAlign.right,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontSize: 18,
                ),
              ),
              Text(
                '${maid.isNotEmpty ? maid[0].fname : ""} ${maid.isNotEmpty ? maid[0].lname : ""}',
                textAlign: TextAlign.right,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontSize: 14,
                ),
              ),
              Text(
                'คิวการทำความสะอาด',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              WorkforMaid(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
