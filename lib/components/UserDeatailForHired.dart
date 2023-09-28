import 'package:flutter/material.dart';

class UserDetailForHired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // A
      children: [
        Text(
          'รายละเอียดลูกบ้าน',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical, 
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, 
            children: [
              Text(
                'หมายเลขห้อง : 123/1',
                textAlign: TextAlign.left, 
              ),
              Text(
                'หมายเลขห้อง : 123/2',
                textAlign: TextAlign.left, 
              ),
              Text(
                'หมายเลขห้อง : 123/3',
                textAlign: TextAlign.left, 
              ),
              Text(
                'หมายเลขห้อง : 123/4',
                textAlign: TextAlign.left, 
              ),
            ],
          ),
        ),
      ],
    );
  }
}
