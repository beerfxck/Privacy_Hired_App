import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/domain.dart';
import '../model/maidWork.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final dio = Dio();
  String? idUser;
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  List<maidWork> resident = [];

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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

        // Set initial values to controllers
        usernameController.text =
            (resident.isNotEmpty ? resident[0].username : "")!;
        passwordController.text =
            (resident.isNotEmpty ? resident[0].password : "")!;
        fnameController.text = (resident.isNotEmpty ? resident[0].fname : "")!;
        lnameController.text = (resident.isNotEmpty ? resident[0].lname : "")!;
        addressController.text =
            (resident.isNotEmpty ? resident[0].address : "")!;

        setState(() {});
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> editMaidprofile(BuildContext context) async {
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
      final bool isAddressEdited = addressController.text.isNotEmpty &&
          addressController.text != resident[0].address;

      final Map<String, dynamic> dataToUpdate = {
        'username':
            isUsernameEdited ? usernameController.text : resident[0].username,
        'password':
            isPasswordEdited ? passwordController.text : resident[0].password,
        'fname': isFnameEdited ? fnameController.text : resident[0].fname,
        'lname': isLnameEdited ? lnameController.text : resident[0].lname,
        'address':
            isAddressEdited ? addressController.text : resident[0].address,
      };

      final response = await dio.post(
        url_api + '/user/edit/' + idUser!,
        data: dataToUpdate,
      );

      if (response.statusCode == 201) {
        Navigator.pushNamed(context, '/BottomNavBar');
        print('success');
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
              Navigator.pushNamed(context, '/MaidBottomNavBar');
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
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color.fromARGB(255, 197, 196, 196),
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: InputBorder.none,
                  labelText:
                      '${resident.isNotEmpty ? resident[0].username : ""}',
                  labelStyle: GoogleFonts.kanit(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  prefixIcon: Icon(Icons.account_circle_outlined),
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
                  label:
                      Text('${resident.isNotEmpty ? resident[0].password : ""}',
                          style: GoogleFonts.kanit(
                            fontSize: 16,
                            color: Colors.grey,
                          )),
                  prefixIcon: Icon(Icons.lock_outlined),
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
                controller: fnameController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: InputBorder.none,
                  label: Text('${resident.isNotEmpty ? resident[0].fname : ""}',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        color: Colors.grey,
                      )),
                  prefixIcon: Icon(Icons.account_circle_outlined),
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
                  label: Text('${resident.isNotEmpty ? resident[0].lname : ""}',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        color: Colors.grey,
                      )),
                  prefixIcon: Icon(Icons.account_circle_outlined),
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
                controller: addressController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: InputBorder.none,
                  label:
                      Text('${resident.isNotEmpty ? resident[0].address : ""}',
                          style: GoogleFonts.kanit(
                            fontSize: 16,
                            color: Colors.grey,
                          )),
                  prefixIcon: Icon(Icons.home),
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
                  editMaidprofile(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 209, 15, 1),
                  shape: StadiumBorder(),
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
          ]),
        ),
      ),
    );
  }
}
