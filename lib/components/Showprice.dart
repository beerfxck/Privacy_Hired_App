import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/Terms_of_service.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white, 
        padding: EdgeInsets.all(16), 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'ค่าบริการ',
              style: GoogleFonts.kanit(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 100,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(
                    builder: (context) => ServiceConditionsComponent())
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: StadiumBorder(),
                  elevation: 10,
                ),
                icon: Icon(Icons.paid_outlined),
                label: Text(
                  'ชำระเงิน',
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
    );
  }
}
