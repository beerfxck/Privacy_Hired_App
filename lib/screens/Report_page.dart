import 'package:flutter/material.dart';
import 'package:privacy_maid_flutter/components/Report.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Center(child: Text('แจ้งปัญหา')),
        backgroundColor: Color.fromARGB(243, 255, 255, 255),
        title: Padding(
            padding: const EdgeInsets.fromLTRB(94, 0, 0, 0),
            child: Text(
              'แจ้งปัญหา',
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                child: Text(
                  'ชื่อผู้อาศัย :',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 10, 0, 0),
                child: Text(
                  'ลูกบ้าน มีปัญหา',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                  //height: 20,
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                child: Text(
                  'เลขห้อง :',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 10, 0, 0),
                child: Text(
                  '978/76',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                  //height: 20,
                ),
              ),
              SizedBox(height: 20),
              ReportComponents(),
            ],
          ),
        ),
      ),
    );
  }
}
