import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/widgets/navigatorbar.dart';

class CompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BottomNavBar()), 
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 250.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'การชำระเงินเสร็จสิ้น !',
                style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
