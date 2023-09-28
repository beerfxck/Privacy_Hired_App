import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../components/MaidDeatailForHired.dart';
import '../components/UserDeatailForHired.dart';

class HiredMaidPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HiredMaidPage> {
  DateTime selectedDate = DateTime.now();
  int selectedHours = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'จองคิวแม่บ้าน',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MaidDetailForHired(), // Add MaidDetailForHired component here
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0), // Add left padding to move content to the right
              child: Align(
                alignment: Alignment
                    .topLeft, // Align the following content to the left
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align children to the left
                  children: <Widget>[
                    Text(
                      'วันที่ที่เลือก: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedHours = 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                selectedHours == 1 ? Colors.green : Colors.grey,
                          ),
                          child: Text(
                            '1 ชั่วโมง',
                            style: TextStyle(
                              color: selectedHours == 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedHours = 2;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                selectedHours == 2 ? Colors.green : Colors.grey,
                          ),
                          child: Text(
                            '2 ชั่วโมง',
                            style: TextStyle(
                              color: selectedHours == 2
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedHours = 3;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                selectedHours == 3 ? Colors.green : Colors.grey,
                          ),
                          child: Text(
                            '3 ชั่วโมง',
                            style: TextStyle(
                              color: selectedHours == 3
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'จำนวนชั่วโมง: $selectedHours',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    UserDetailForHired(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
