import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  File? _selectedImage;

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? _image;

    Future getImage() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }

    String? image;

    Future<void> chooseFile(ImageSource source) async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 500,
        imageQuality: 100,
      );

      if (pickedFile == null) return;
      final bytes = await pickedFile.readAsBytes();
      final String base64String = base64Encode(bytes);
      image = base64String;
      setState(() {});
    }

    void _showImageSourceActionSheet(BuildContext context) {
      Function(ImageSource) selectImageSource = (imageSource) {
        chooseFile(imageSource);
      };

      if (Platform.isIOS) {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  'ถ่ายภาพ',
                  style: TextStyle(
                    fontFamily: 'anupark',
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  selectImageSource(ImageSource.camera);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'เลือกภาพถ่าย',
                  style: TextStyle(
                    fontFamily: 'anupark',
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  selectImageSource(ImageSource.gallery);
                },
              )
            ],
          ),
        );
      } else {
        showModalBottomSheet(
          context: context,
          builder: (context) => Wrap(children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text(
                'ถ่ายภาพ',
                style: TextStyle(
                  fontFamily: 'anupark',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text(
                'เลือกภาพถ่าย',
                style: TextStyle(
                  fontFamily: 'anupark',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.gallery);
              },
            ),
          ]),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 232, 241, 230),
          title: Text(
            'ชำระเงิน',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(color: Colors.green),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.green),
        ),
        body: Container(
          color: Color.fromARGB(255, 232, 241, 230),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_selectedImage != null)
                  Image.file(_selectedImage!)
                else
                  Text(
                    'แนบหลักฐานการชำระเงิน',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _selectImage,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Text('เลือกรูปภาพ'),
                    ),
                  ],
                ),
                if (_selectedImage != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle the payment logic here
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text('ชำระเงิน'),
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
}