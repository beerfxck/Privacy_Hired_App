import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      // Validate data before sending the request
      if (widget.idBooking == null || image == null) {
        // Handle incomplete data
        Fluttertoast.showToast(
          msg: "กรุณาใส่ข้อมูลให้ครบถ้วน",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        // You might want to show a dialog or toast to inform the user.
        return;
      }

      final response = await dio.post(
        url_api + '/books/update-slip',
        data: {
          'booking_id': widget.idBooking,
          'paymentslip': image,
          'status': 4,
        },
      );

      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "ชำระเงินเสร็จสิ้น",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserReview(idBooking: widget.idBooking),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "กรุณาแนบสลิป",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
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
                  fontFamily: 'kanit',
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
                  fontFamily: 'kanit',
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
                  fontFamily: 'kanit',
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
                  fontFamily: 'kanit',
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
        backgroundColor: Color.fromARGB(255, 9, 150, 63),
        title: Text(
          'ชำระเงิน',
          style: GoogleFonts.kanit(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
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
                  SizedBox(
                    height: 10,
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
                                      'โปรดเลือกรูปภาพ',
                                    ))
                                  : Image.memory(base64Decode("${image}")),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green, width: 1.5),
                        foregroundColor: Colors.green,
                      ),
                      onPressed: () {
                        _showImageSourceActionSheet(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload,
                            size: 24,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'อัปโหลดรูปภาพ',
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.green),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 8,
                      fixedSize: Size(295, 10),
                    ),
                    onPressed: () {
                      updateSlip(context);
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
      ),
    );
  }
}
