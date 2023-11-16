import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';

class ReportComponents extends StatefulWidget {
  final int? bookingId;
  const ReportComponents({
    Key? key,
    this.bookingId,
  }) : super(key: key);
  @override
  _ReportComponentsState createState() => _ReportComponentsState();
}

class _ReportComponentsState extends State<ReportComponents> {
  TextEditingController _reportController = TextEditingController();
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

  void saveReportWork(BuildContext context) async {
    idUser = await storageToken.read(key: 'id_user');
    try {
      final Map<String, dynamic> maidWorkData = {
        "feedback_description": _reportController.text,
        "id_user": idUser,
        "id_booking": widget.bookingId,
        "status_feedback": 9,
      };
      print(maidWorkData);
      Response response =
          await dio.post(url_api + '/feedback/savefeed', data: maidWorkData);
      if (response.statusCode == 201) {
        print("Maid work saved successfully");
        Navigator.pushNamed(context, '/BottomNavBar');
      } else {
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  void _handleSubmit() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 350,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color.fromARGB(255, 216, 216, 216),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _reportController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'กรอกปัญหาที่ต้องการแจ้ง...',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.kanit(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'โปรดเก็บหลักฐานเพื่อแสดงแก่นิติบุคคล',
            style: GoogleFonts.kanit(
              fontSize: 16.0,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              saveReportWork(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 120.0,
              ),
              child: Text(
                'แจ้งปัญหา',
                style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
