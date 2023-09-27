import 'package:flutter/material.dart';

class MaidDetail extends StatefulWidget {
  const MaidDetail({Key? key}) : super(key: key);

  @override
  State<MaidDetail> createState() => _MaidDetailState();
}

class _MaidDetailState extends State<MaidDetail> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(40), //ขนาดกล่อง
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft, 
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  size: 48, // ขนาดไปคอน
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'หวานใจ หวานฉ่ำถูกใจ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '9457987435',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Align(
              alignment:
                  Alignment.bottomRight, 
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('ว่าง'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
