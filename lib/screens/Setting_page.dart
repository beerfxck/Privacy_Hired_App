import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privacy_maid_flutter/screens/Report_page.dart';

import '../screensMaid/Maid_Edit_Profile.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 30),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
            ),
            title: Text(
              "ชื่อลูกบ้าน",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle:
                Text("ลูกบ้าน"),
          ),
          Divider(height: 50),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditPage()),
              );
            },
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.person,
                color: Colors.blue,
                size: 35,
              ),
            ),
            title: Text(
              "แก้ไขโปรไฟล์",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: () {Navigator.pushNamed(context,
                  '/ReportPage'); },
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.report,
                color: Colors.orange,
                size: 35,
              ),
            ),
            title: Text(
              "แจ้งปัญหา/ร้องเรียน",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),
          Divider(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context,
                  '/login'); 
            },
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.redAccent,
                  size: 35,
                ),
              ),
              title: Text(
                "ออกจากระบบ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
