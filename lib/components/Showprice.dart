import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/Terms_of_service.dart';

import '../constant/domain.dart';
import '../model/maidWork.dart';

class Totalprice extends StatefulWidget {
  final int selectHour;

  Totalprice({Key? key, required this.selectHour}) : super(key: key);

  @override
  State<Totalprice> createState() => _TotalpriceState();
}

class _TotalpriceState extends State<Totalprice> {
  final dio = Dio();
  String? idUser;
  int? sumprice;
  static FlutterSecureStorage storageToken = FlutterSecureStorage();
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

  int calculateServiceCost(String? roomsize) {
    if (roomsize == null) {
      return sumprice = 0;
    } else if (roomsize.contains("26.5 - 29.5 sq m")) {
      return sumprice = (400 + (widget.selectHour) * 60);
    } else if (roomsize.contains("34.5 sq m")) {
      return sumprice = (500 + (widget.selectHour) * 60);
    } else if (roomsize.contains("49.5 - 50.25 sq m")) {
      return sumprice = (650 + (widget.selectHour) * 60);
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'ค่าบริการ ${calculateServiceCost(resident.isNotEmpty ? resident[0].roomsize : "")} บาท',
                style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
