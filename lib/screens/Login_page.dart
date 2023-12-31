import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/checkbox.dart';
import 'package:privacy_maid_flutter/screens/Menubar.dart';
import 'package:privacy_maid_flutter/screensMaid/MaidHome_page.dart';
import 'package:privacy_maid_flutter/screensMaid/Maid_Edit_Profile.dart';
import 'package:privacy_maid_flutter/widgets/navigatorbar.dart';

import '../Widget_Maid/Maid_Navigatorbar.dart';
import '../constant/domain.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  final dio = Dio();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoginEnabled = false;
  bool passToggle = true;
  bool isChecked = false;

  void checkLoginEnable() {
    setState(() {
      isLoginEnabled = usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  Login() async {
    try {
      if (usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        String userType = "";
        Response response = await dio.post(
          url_api + '/auth/login',
          data: {
            'username': usernameController.text,
            'password': passwordController.text,
          },
        );
        userType = response.data["type_name"];
        print(response);
        await storageToken.write(
          key: 'id_user',
          value: response.data["id_user"].toString(),
        );

        if (userType == 'resident') {
          GotoHome();
        } else if (userType == 'maid') {
          GotoMaidHome();
        } else {
          // ตรวจสอบประเภทผู้ใช้ที่ไม่รู้จัก
          print('Unknown user type: $userType');
        }
      } else {
        print('Username or password is empty.');
      }
    } catch (e) {
      print('An error occurred during login: $e');
      if (e is DioError) {
        if (e.response != null) {
          print('DioError with response: ${e.response}');
          // Check the response status and show an alert accordingly
          if (e.response!.statusCode == 401) {
            showLoginErrorDialog("ชื่อผู้ใช้หรือรหัสผ่านผิดพลาด");
          } else {
            showLoginErrorDialog("ชื่อผู้ใช้หรือรหัสผ่านผิดพลาด");
          }
        } else {
          print('DioError without response');
        }
      } else {
        print('Other exception occurred: $e');
      }
    }
  }

  void showLoginErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                "ไม่สามารถเข้าสู่ระบบได้",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "ปิด",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  GotoHome() {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BottomNavBar();
        },
      ),
      (_) => false,
    );
  }

  GotoMaidHome() {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MaidBottomNavBar();
        },
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: 100.0, horizontal: 100.0),
                child: ClipRRect(
                  child: Image(image: AssetImage('images/logo_maid.png')),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: usernameController,
                  onChanged: (value) {
                    checkLoginEnable();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      'ชื่อผู้ใช้',
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
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
                          fontSize: 18,
                          color: Colors.grey,
                        )),
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
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: 250,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: isLoginEnabled
                              ? Color.fromARGB(255, 11, 143, 11)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              Login();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                              child: Center(
                                child: Text(
                                  "เข้าสู่ระบบ",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(color: Colors.white),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
