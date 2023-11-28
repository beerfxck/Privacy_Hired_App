import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

import '../constant/domain.dart';
import '../model/maidWork.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final dio = Dio();
  bool _obscureText = true;
  String? idUser;
  static FlutterSecureStorage storageToken = FlutterSecureStorage();
  List<maidWork> resident = [];

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
      print('Error: $e');
    }
  }

  Future<void> editProfile(BuildContext context) async {
    try {
      await getData();

      final bool isUsernameEdited = usernameController.text.isNotEmpty &&
          usernameController.text != resident[0].username;
      final bool isPasswordEdited = passwordController.text.isNotEmpty &&
          passwordController.text != resident[0].password;
      final bool isFnameEdited = fnameController.text.isNotEmpty &&
          fnameController.text != resident[0].fname;
      final bool isLnameEdited = lnameController.text.isNotEmpty &&
          lnameController.text != resident[0].lname;
      final bool isPhoneEdited = phoneController.text.isNotEmpty &&
          phoneController.text != resident[0].phone;

      final Map<String, dynamic> dataToUpdate = {
        'username':
            isUsernameEdited ? usernameController.text : resident[0].username,
        'password':
            isPasswordEdited ? passwordController.text : resident[0].password,
        'fname': isFnameEdited ? fnameController.text : resident[0].fname,
        'lname': isLnameEdited ? lnameController.text : resident[0].lname,
        'phone': isPhoneEdited ? phoneController.text : resident[0].phone,
      };

      final response = await dio.post(
        url_api + '/user/edit/' + idUser!,
        data: dataToUpdate,
      );

      if (response.statusCode == 201) {
        Navigator.pushNamed(context, '/BottomNavBar');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "ต้องการแก้ไขข้อมูลหรือไม่",
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(
              textStyle: TextStyle(color: Colors.black),
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text(
                    "ยกเลิก",
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.red),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    editProfile(context);
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/BottomNavBar');
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text(
                    "ยืนยัน",
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.green),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 5,
        backgroundColor: Color.fromARGB(255, 9, 150, 63),
        title: Text(
          'แก้ไขโปรไฟล์',
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
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  child: Image(image: AssetImage('images/logo_maid.png')),
                ),
              ),
              Text(
                '${resident.isNotEmpty ? resident[0].roomnumber : ""}',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.green),
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'ขนาดห้อง: ${resident.isNotEmpty ? resident[0].roomsize : ""}',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black54),
                  fontSize: 14,
                ),
              ),
              Divider(),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color.fromARGB(255, 197, 196, 196),
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${resident.isNotEmpty ? resident[0].username : ""}',
                        style: GoogleFonts.kanit(
                          fontSize: 18,
                          color: Colors.grey[850],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color.fromARGB(255, 197, 196, 196),
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: InputBorder.none,
                    labelText:
                        '${resident.isNotEmpty ? resident[0].password : ""}',
                    labelStyle: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: Colors.green,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color.fromARGB(255, 197, 196, 196),
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: fnameController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: InputBorder.none,
                    label: Text(
                      '${resident.isNotEmpty ? resident[0].fname : ""}',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color.fromARGB(255, 197, 196, 196),
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: lnameController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: InputBorder.none,
                    label: Text(
                      '${resident.isNotEmpty ? resident[0].lname : ""}',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color.fromARGB(255, 197, 196, 196),
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: InputBorder.none,
                    label: Text(
                      '${resident.isNotEmpty ? resident[0].phone : ""}',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 385,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showEditDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 209, 15, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 10,
                  ),
                  icon: Icon(Icons.edit),
                  label: Text(
                    'แก้ไขข้อมูลเสร็จสิ้น',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.white),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
