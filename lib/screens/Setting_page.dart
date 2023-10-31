import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/screens/Report_page.dart';
import 'package:privacy_maid_flutter/screens/UserEditProfile.dart';

import '../constant/domain.dart';
import '../model/maidWork.dart';
import '../screensMaid/Maid_Edit_Profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
            typeDescription: element["type_description"],
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
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ตั้งค่า",
            style: GoogleFonts.kanit(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 30),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
            ),
            title: Text(
              "${resident.isNotEmpty ? resident[0].fname : ""} ${resident.isNotEmpty ? resident[0].lname : ""}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle:
                Text("${resident.isNotEmpty ? resident[0].typeDescription : ""}"),
          ),
          Divider(height: 50),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditUserPage()),
              );
            },
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.person,
                color: Colors.blue,
                size: 35,
              ),
            ),
            title: Text(
              "แก้ไขโปรไฟล์",
              style: GoogleFonts.kanit(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: () {Navigator.pushNamed(context,
                  '/ReportPage'); },
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.report,
                color: Colors.orange,
                size: 35,
              ),
            ),
            title: Text(
              "แจ้งปัญหา/ร้องเรียน",
              style: GoogleFonts.kanit(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),
          Divider(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context,
                  '/login'); 
            },
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.redAccent,
                  size: 35,
                ),
              ),
              title: Text(
                "ออกจากระบบ",
                style: GoogleFonts.kanit(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
