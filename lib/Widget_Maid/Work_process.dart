import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkProcessComponent extends StatefulWidget {
  @override
  _WorkProcessComponentState createState() => _WorkProcessComponentState();
}

class _WorkProcessComponentState extends State<WorkProcessComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.fromLTRB(3, 0, 3, 15),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 241, 230),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 20, right: 17),
                    trailing: Text(
                      "อยู่ระหว่างทำความสะอาด",
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.black),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blueGrey,
                        child: Icon(
                          Icons.work_history_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      //color: Colors.black,
                      thickness: 1,
                      //height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "27/09/2023",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.black54),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "16:30 AM",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.black54),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "ระหว่างทำ",
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.black54),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 150,
                          height: 40,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "เสร็จสิ้นงาน",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black54),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // InkWell(
                      //     // onTap: () {
                      //     //   // Navigator.of(context).push(
                      //     //   //   MaterialPageRoute(
                      //     //   //     builder: (context) =>
                      //     //   //         // HiredInfomation(), // Make sure this is a valid widget
                      //     //   //   ),
                      //     //   // );
                      //     // },
                      //     // child: Container(
                      //     //   width: 150,
                      //     //   height: 40,
                      //     //   padding: EdgeInsets.symmetric(vertical: 8),
                      //     //   decoration: BoxDecoration(
                      //     //     color: Color.fromARGB(255, 141, 141, 141),
                      //     //     borderRadius: BorderRadius.circular(30),
                      //     //   ),
                      //     //   child: Center(
                      //     //     child: Text(
                      //     //       "รายละเอียด",
                      //     //       style: GoogleFonts.kanit(
                      //     //         textStyle: TextStyle(color: Colors.black54),
                      //     //         fontSize: 14,
                      //     //         fontWeight: FontWeight.w400,
                      //     //         color: Colors.white,
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}