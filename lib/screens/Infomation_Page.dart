import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/MaidDeatailForHired.dart';
import 'package:privacy_maid_flutter/components/TimeInfomation.dart';
import 'package:privacy_maid_flutter/components/UserDeatailForHired.dart';

import '../components/DateForBook.dart';
import '../components/MaiddetailForBooking.dart';

class InformationPage extends StatefulWidget {
  final int? id_user;
  const InformationPage({
    Key? key,
    this.id_user,
  }) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(243, 255, 255, 255),
        title: Padding(
            padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
            child: Text(
              'รายละเอียด',
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color.fromARGB(255, 216, 216, 216),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ' รายละเอียดการจอง',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.black),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // MaidDetailForHired(id_user: widget.id_user),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                //height: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaiddetailForBooking(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                //height: 20,
              ),
            ),
            DateForBook(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                //height: 20,
              ),
            ),
            UserDetailForHired(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                //height: 20,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  'ค่าบริการ : ' + '520 บาท',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.black),
                    fontSize: 20,
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
