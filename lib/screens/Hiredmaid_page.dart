import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../components/MaidDeatailForHired.dart';
import '../components/Terms_of_service.dart';
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
          'จองคิวทำความสะอาด',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.all(10), // Margin to add spacing around the content
          padding:
              EdgeInsets.all(10), // Padding to add spacing within the container
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color to white
            borderRadius: BorderRadius.circular(10.0), // Add rounded corners
            border: Border.all(
              color: Colors.grey, // Border color
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
            children: <Widget>[
              MaidDetailForHired(),
              Text(
                'รายละเอียดการจอง',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left:
                        40.0), // Add left padding to move content to the right
                child: Align(
                  alignment: Alignment
                      .topLeft, // Align the following content to the left
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align children to the left
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              if (date != null) {
                                setState(() {
                                  selectedDate = date;
                                });
                              }
                            },
                            currentTime: selectedDate,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.green, // Change the button color to green
                        ),
                        child: Text(
                          'กรุณาเลือกวันที่',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'วันที่จอง: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'เลือกจำนวนชั่วโมง',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 2), // Add horizontal spacing
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedHours = 1;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: selectedHours == 1
                                      ? Colors.green
                                      : Colors.grey,
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
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30), // Add horizontal spacing
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedHours = 2;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: selectedHours == 2
                                      ? Colors.green
                                      : Colors.grey,
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
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5), // Add horizontal spacing
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedHours = 3;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: selectedHours == 3
                                      ? Colors.green
                                      : Colors.grey,
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'จำนวนที่เลือก: $selectedHours' + ' ชั่วโมง',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 15),
                      UserDetailForHired(),
                      SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ServiceConditionsComponent(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors
                                .green, // Set the button's background color to green
                            minimumSize:
                                Size(120, 40), // Set button size as needed
                          ),
                          child: Text(
                            'ต่อไป',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
