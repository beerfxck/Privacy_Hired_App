import 'package:flutter/material.dart';

import '../widgets/navigatorbar.dart';

class Skip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigatorBar(),
                        ));
                  },
                  child: Text(
                    'skip',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 100,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
