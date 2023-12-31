import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/Complete.dart';

class ServiceConditionsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/HiredMaidPage');
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.green,
          ),
        ),
        title: Text(
          'การจองคิวของคุณ',
          style: GoogleFonts.kanit(
            textStyle: TextStyle(color: Colors.black),
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'เงื่อนไขการบริการ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            ServiceConditionItem('- การเรียกใช้บริการ 1 ครั้ง/แม่บ้าน 1 ท่าน'),
            ServiceConditionItem('- การเรียกใช้บริการ 1 ครั้ง/แม่บ้าน 1 ท่าน'),
            ServiceConditionItem(
                '- ดูดฝุ่น ถูพื้น เช็ดหน้าต่าง (ในระยะที่เอื้อมถึง)'),
            ServiceConditionItem('- นำขยะไปทิ้ง'),
            ServiceConditionItem('- ปัดฝุ่น เช็ดฝุ่น จัดระเบียบสิ่งของ'),
            ServiceConditionItem('- กรณีเปลี่ยนผ้าปู ลูกบ้านต้องเตรียมไว้'),
            ServiceConditionItem('- ล้างแก้ว ถ้วย จาน ชาม ที่ใช้แล้ว'),
            SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'กรณีสิ่งของเสียหาย',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            CenteredText('- หากแม่บ้านก่อให้เกิดความเสียหายในทรัพย์สิน'),
            CenteredText('- ของลูกบ้าน ลูกบ้านจะต้องแจ้งปัญหาให้กับทางคอนโด'),
            CenteredText('- พร้อมเก็บหลักฐาน ภายใน 24 ชั่วโมง'),
            Center(
              child: Text(
                '- โดยลูกบ้านสามารถกดแจ้งปัญหาหลังจากเสร็จสิ้นการจองคิวทำความสะอาดแล้ว',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 27),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompletePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: Size(120, 40),
                ),
                child: Text(
                  'จอง',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceConditionItem extends StatelessWidget {
  final String text;

  ServiceConditionItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

class CenteredText extends StatelessWidget {
  final String text;

  CenteredText(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
