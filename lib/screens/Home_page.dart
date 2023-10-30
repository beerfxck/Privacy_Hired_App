import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';
import '../components/Maid_Detail.dart';
import '../widgets/Upcoming_schedule.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                ' ${resident.isNotEmpty ? resident[0].fname : ""} ${resident.isNotEmpty ? resident[0].lname : ""}', // Use the first resident's username if the list is not empty
                textAlign: TextAlign.right,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontSize: 14,
                ),
              ),
              Text(
                'การจองคิวล่าสุด',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              UpcomingSchedule(),
              SizedBox(height: 20),
              Text(
                'แม่บ้านทั้งหมด',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              MaidDetail(),
            ],
          ),
        ),
      ),
    );
  }
}
