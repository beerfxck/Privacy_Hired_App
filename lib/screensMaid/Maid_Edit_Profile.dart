import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขโปรไฟล์'),
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(
          child: Image.asset('images/logo_maid.png')
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              SizedBox(
                width: 120,height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                child: const Image(image: AssetImage('images/user3.png')),
              ),
              ),
              const SizedBox(height: 10),
              Text('หมายเลขห้อง 123/1', style: Theme.of(context).textTheme.headlineSmall),
              Text('ขนาดห้อง 26-29 ตารางเมตร', style: Theme.of(context).textTheme.bodySmall),
              const Divider(),
              const SizedBox(height: 10,),
              SizedBox(
                width: 350,
                child: OutlinedButton.icon(onPressed: (){
                  debugPrint('Received click');},
                  icon: (Icon(Icons.draw)), 
                  label: Text('แก้ไขโปรไฟล์',style: TextStyle(color: Color.fromARGB(255, 128, 8, 108)),),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(10.0),
                    elevation: 1,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color.fromRGBO(25, 73, 216, 1), width: 2),
                  ),
                ),
              )
            ]
          ),
        )
      ),
    );
  }
}