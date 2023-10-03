import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privacy_maid_flutter/components/checkbox.dart';
import 'package:privacy_maid_flutter/screens/Menubar.dart';
import 'package:privacy_maid_flutter/screensMaid/Maid_Edit_Profile.dart';
import 'package:privacy_maid_flutter/widgets/navigatorbar.dart';

import '../constant/domain.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoginEnabled = false;
  bool passToggle = true;
  bool isChecked =
      false; // เพิ่มตัวแปร isChecked เพื่อเก็บค่าจาก CustomCheckbox

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
        String userType = isChecked
            ? 'maid'
            : 'resident'; // ใช้ isChecked เพื่อตรวจสอบประเภทของผู้ใช้
        Response response = await dio.post(
          url_api + '/auth/login',
          data: {
            'username': usernameController.text,
            'password': passwordController.text,
            'type_name': userType,
          },
        );
        print(response);

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
    }
  }

  GotoHome() {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return NavigationMenuBar();
        },
      ),
      (_) => false,
    );
  }

  GotoMaidHome() {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EditPage(); // แทนที่ด้วยหน้า MaidHome ของคุณ
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
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 25.0), // Add margin as needed
                child: CustomCheckbox(
                  option1Text: 'แม่บ้าน',
                  option2Text: 'ผู้อยู่อาศัย',
                  onChanged: (isChecked) {
                    setState(() {
                      this.isChecked = isChecked;
                    });
                  },
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
                              color:
                                  Colors.grey.withOpacity(0.5), 
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
