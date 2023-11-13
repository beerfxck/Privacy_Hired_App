import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'dart:io';

import 'package:privacy_maid_flutter/screens/UserReview.dart';

class PayPage extends StatefulWidget {
  final int? id_user;
  final int? idBooking;
  const PayPage({
    Key? key,
    this.id_user,
    this.idBooking,
  }) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  File? _selectedImage;
  String? image;
  final dio = Dio();

  Future<void> updateSlip(BuildContext context) async {
    try {
      final response = await dio.post(
        url_api + '/books/update-slip',
        data: {
          'booking_id': widget.idBooking,
          'paymentslip': image,
          'status': 4,
        },
      );

      if (response.statusCode == 201) {
        print('success');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      File imageFile = File(selectedImage.path);
      List<int> bytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(bytes);

      setState(() {
        _selectedImage = imageFile;
        image = base64Image;
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    Function(ImageSource) selectImageSource = (imageSource) {
      _selectImage();
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
        builder: (context) => Wrap(
          children: [
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
          ],
        ),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 450,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'แนบหลักฐานการชำระเงิน',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: image == null
                                  ? Center(
                                      child: Text(
                                      'no image selected',
                                    ))
                                  : Image.memory(base64Decode("${image}")),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: StadiumBorder(),
                                elevation: 8,
                              ),
                              onPressed: () {
                                _showImageSourceActionSheet(context);
                              },
                              child: Text(
                                'อัปโหลดรูปภาพ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.white),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: StadiumBorder(),
                                elevation: 8,
                              ),
                              onPressed: () {
                                updateSlip(
                                    context); 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserReview(idBooking: widget.idBooking),
                                  ),
                                );
                              },
                              child: Text(
                                'เสร็จสิ้น',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.white),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
