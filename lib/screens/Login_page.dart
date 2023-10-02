import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privacy_maid_flutter/screens/Home_page.dart';
import 'package:privacy_maid_flutter/screens/Menubar.dart';
import '../constant/domain.dart';
import '../widgets/navigatorbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/checkbox.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();
  Login() async {
  try {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Response response = await dio.post(
        url_api + '/auth/login',
        data: {
          'username': usernameController.text,
          'password': passwordController.text,
          'type_name': 'resident'
        },
      );
      print(response);
      GotoHome();
    } else {
      print('Username or password is empty.');
    }
  } catch (e) {
    print('An error occurred during login: $e');
  }
}
GotoHome() {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return NavigatorBar();
        },
      ),
      (_) => false,
    );
  }
  bool passToggle = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoginEnabled = false;

  void checkLoginEnable() {
    setState(() {
      isLoginEnabled = usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 350, 
                child: ClipRRect(
                  child: Image(image: AssetImage('images/logo_maid.png')),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.all(25),
                child: TextField(
                  controller: usernameController,
                  onChanged: (value) {
                    checkLoginEnable();
                  },

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('ชื่อผู้ใช้',
                    style: GoogleFonts.kanit(
                      fontSize: 18, color: Colors.grey,
                    ),   
                  ),
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: TextField(
                  controller: passwordController,
                  obscureText: passToggle ? true : false,
                  onChanged: (value) {
                    checkLoginEnable();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('รหัสผ่าน',
                    style: GoogleFonts.kanit(
                      fontSize: 18, color: Colors.grey)),
                    prefixIcon: Icon(Icons.lock_rounded),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: passToggle
                          ? Icon(CupertinoIcons.eye_slash_fill)
                          : Icon(CupertinoIcons.eye_fill),
                    ),
                  ),
                ),
                ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: 250,
                  child: Material(
                    color: isLoginEnabled
                        ? Color.fromARGB(255, 11, 143, 11)
                        : Colors.grey, //สีตอนไม่ใส่ยูสแนมพาสเวิร์ด
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Login();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                          child: Text(
                            "ลงชื่อเข้าใช้",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.white),
                              fontSize: 18,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '** หากยังไม่มีชื่อผู้ใช้และรหัสผ่านโปรดติดต่อขอรับที่นิติบุคคล **',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.blueGrey),
                    ),   
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
