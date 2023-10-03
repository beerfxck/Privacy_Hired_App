import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขโปรไฟล์'),
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(
          child: Image.asset('images/logo_maid.png'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(image: AssetImage('images/user3.png')),
                ),
              ),
              const SizedBox(height: 10),
              Text('หมายเลขห้อง 123/1',
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.black),
                      fontSize: 22,
                      fontWeight: FontWeight.w400)),
              Text('ขนาดห้อง 26-29 ตารางเมตร',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.black54),
                    fontSize: 14,
                  )),
              Divider(),
              SizedBox(height: 10),
              SizedBox(
                width: 350,
                child: OutlinedButton.icon(
                  onPressed: () {
                    debugPrint('Received click');
                  },
                  icon: const Icon(Icons.edit),
                  label: Text(
                    'แก้ไขข้อมูล',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color:Colors.white),
                      fontSize: 16,
                      ),
                    ),
                  ),
                ),
            ]
              ),
          ),
        ),
      );
  }
}
