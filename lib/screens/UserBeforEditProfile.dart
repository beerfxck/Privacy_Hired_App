import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

import '../constant/domain.dart';
import '../model/maidWork.dart';
import 'UserEditProfile.dart';

class BeforEdit extends StatefulWidget {
  const BeforEdit({Key? key}) : super(key: key);

  @override
  _BeforEditState createState() => _BeforEditState();
}

class _BeforEditState extends State<BeforEdit> {
  final dio = Dio();
  bool _obscureText = true;
  String? idUser;
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 35.0),
          child: Transform.scale(
            scale: 3.5,
            child: Image.asset('images/logo_maid.png'),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/BottomNavBar');
            },
            icon: Icon(
              Icons.home_rounded,
              color: Colors.green,
            ),
          ),
        ],
        backgroundColor: Color.fromARGB(217, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(0.0),
          child: Column(children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(image: AssetImage('images/logo_maid.png')),
              ),
            ),
            Text('${resident.isNotEmpty ? resident[0].roomnumber : ""}',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.black),
                    fontSize: 22,
                    fontWeight: FontWeight.w400)),
            Text('ขนาดห้อง: ${resident.isNotEmpty ? resident[0].roomsize : ""}',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black54),
                  fontSize: 14,
                )),
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
                      color: Colors.grey,
                    ),
                  ),
                ],
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
                      color: Colors.grey,
                    ),
                  ),
                ],
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Icon(Icons.account_circle_outlined),
                  ),
                  Text(
                    '${resident.isNotEmpty ? resident[0].fname : ""}',
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Icon(Icons.account_circle_outlined),
                  ),
                  Text(
                    '${resident.isNotEmpty ? resident[0].lname : ""}',
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Icon(Icons.phone),
                  ),
                  Text(
                    '${resident.isNotEmpty ? resident[0].phone : ""}',
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.grey,
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
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditUserPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 209, 15, 1),
                  shape: StadiumBorder(),
                  elevation: 10,
                ),
                icon: Icon(Icons.edit),
                label: Text(
                  'แก้ไขข้อมูล',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.white),
                    fontSize: 16,
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
