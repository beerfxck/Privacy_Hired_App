import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/navigatorbar.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();
  Login()async {
    if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
      Response  response = await dio.post('/test', data: {'username': usernameController.text, 'password': passwordController.text});
      print(response);
    }
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
              SizedBox(height: 170),
              Text(
                'The',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Privacy',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Text(
                'Taopoon',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.all(12),
                child: TextField(
                  controller: usernameController,
                  onChanged: (value) {
                    checkLoginEnable();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('ชื่อผู้ใช้'),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: TextField(
                  controller: passwordController,
                  obscureText: passToggle ? true : false,
                  onChanged: (value) {
                    checkLoginEnable();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('รหัสผ่าน'),
                    prefixIcon: Icon(Icons.lock),
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
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: isLoginEnabled
                        ? Color.fromARGB(255, 11, 143, 11)
                        : Colors
                            .grey, //สีตอนไม่ใส่ยูสแนมพาสเวิร์ด
                    borderRadius: BorderRadius.circular(14),
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '** หากยังไม่มีชื่อผู้ใช้และรหัสผ่านโปรดติดต่อขอรับที่นิติบุคคล **',
                    style: TextStyle(
                      fontSize: 14,
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
