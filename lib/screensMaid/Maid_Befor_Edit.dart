import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/domain.dart';
import '../model/maidWork.dart';
import 'Maid_Edit_Profile.dart';

class MaidBeforEdit extends StatefulWidget {
  const MaidBeforEdit({super.key});
  @override
  _MaidBeforEditState createState() => _MaidBeforEditState();
}

class _MaidBeforEditState extends State<MaidBeforEdit> {
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
            username: element["username"],
            password: element["password"],
            fname: element["fname"],
            lname: element["lname"],
            phone: element["phone"],
            address: element["address"],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 5,
        backgroundColor: Color.fromARGB(255, 9, 150, 63),
        title: Text(
          'โปรไฟล์ของคุณ',
          style: GoogleFonts.kanit(
            textStyle: TextStyle(color: Colors.white),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(children: [
            SizedBox(
              width: 120,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(image: AssetImage('images/user3.png')),
              ),
            ),
            SizedBox(height: 5),
            Text(
                '${resident.isNotEmpty ? resident[0].fname : ""} ${resident.isNotEmpty ? resident[0].lname : ""}',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.black),
                    fontSize: 22,
                    fontWeight: FontWeight.w400)),
            Divider(),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color.fromARGB(255, 197, 196, 196),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Icon(Icons.account_circle_outlined),
                  ),
                  Text(
                    '${resident.isNotEmpty ? resident[0].username : ""}',
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color.fromARGB(255, 197, 196, 196),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Icon(Icons.lock_outlined),
                  ),
                  Text(
                    '${resident.isNotEmpty ? resident[0].password : ""}',
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color.fromARGB(255, 197, 196, 196),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Icon(Icons.account_circle),
                  ),
                  Text(
                    '${resident.isNotEmpty ? resident[0].fname : ""}',
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color.fromARGB(255, 197, 196, 196),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Icon(Icons.account_circle),
                  ),
                  Text(
                    '${resident.isNotEmpty ? resident[0].lname : ""}',
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color.fromARGB(255, 197, 196, 196),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Icon(Icons.map_outlined),
                  ),
                  Text(
                    '${resident.isNotEmpty ? resident[0].address : ""}',
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 385,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: Icon(
                  Icons.edit,
                  color: Colors.red,
                ),
                label: Text(
                  'แก้ไขข้อมูล',
                  style: GoogleFonts.kanit(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
