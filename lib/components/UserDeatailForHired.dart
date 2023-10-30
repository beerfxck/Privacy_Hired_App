import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';

import '../constant/domain.dart';

class UserDetailForHired extends StatefulWidget {
  const UserDetailForHired({super.key});
  @override
  _UserDetailForHiredState createState() => _UserDetailForHiredState();
}

class _UserDetailForHiredState extends State<UserDetailForHired> {
  final dio = Dio();
  String? idUser;
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  List<maidWork> resident = [];
  @override
  void initState() {
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
            fname: element["fname"],
            lname: element["lname"],
            nickname: element["nickname"],
            phone: element["phone"],
            roomnumber: element["roomnumber"],
            roomsize: element["roomsize"],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'รายละเอียดทำความสะอาด',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 7),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text(
              'หมายเลขห้อง : ${resident.isNotEmpty ? resident[0].roomnumber : ""} ',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black),
                fontSize: 18,
              ),
            ),
            Text(
              'ขนาดห้อง : ${resident.isNotEmpty ? resident[0].roomsize : ""}',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black),
                fontSize: 18,
              ),
            ),
            Text(
              'ชื่อเจ้าของห้อง : ${resident.isNotEmpty ? resident[0].fname : ""} ${resident.isNotEmpty ? resident[0].lname : ""}',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black),
                fontSize: 18,
              ),
            ),
            Text(
              'เบอร์โทรศัพท์ : ${resident.isNotEmpty ? resident[0].phone : ""}',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(color: Colors.black),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
