import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/maidWork.dart';

class ReportComponents extends StatefulWidget {
  final int? bookingId;
  const ReportComponents({
    Key? key,
    this.bookingId,
  }) : super(key: key);
  @override
  _ReportComponentsState createState() => _ReportComponentsState();
}

class _ReportComponentsState extends State<ReportComponents> {
  TextEditingController _reportController = TextEditingController();
  final dio = Dio();
  String? idUser;
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  List<maidWork> resident = [];
  List<File> selectedImages = [];

  String convertImageToBase64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  List<String> convertImagesToBase64() {
    return selectedImages.map((image) => convertImageToBase64(image)).toList();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _showFullImageDialog(File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.file(
              imageFile,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      resident = [];
      idUser = await storageToken.read(key: 'id_user');
      final response = await dio.get(url_api + '/user/get-resident/' + idUser!);
      if (response.statusCode == 200) {
        final responseData = response.data;
        for (var element in responseData) {
          resident.add(maidWork(
            idUser: element["id_user"],
          ));
        }
        setState(() {});
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void saveReportWork(BuildContext context) async {
    idUser = await storageToken.read(key: 'id_user');
    try {
      final Map<String, dynamic> maidWorkData = {
        "feedback_description": _reportController.text,
        "id_user": idUser,
        "id_booking": widget.bookingId,
        "status_feedback": 9,
        "images": convertImagesToBase64(), // Add base64-encoded images
      };
      print(maidWorkData);
      Response response =
          await dio.post(url_api + '/feedback/savefeed', data: maidWorkData);
      if (response.statusCode == 201) {
        print("Maid work saved successfully");
        Navigator.pushNamed(context, '/BottomNavBar');
      } else {
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 350,
            height: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color.fromARGB(255, 216, 216, 216),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _reportController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'กรอกปัญหาที่ต้องการแจ้ง...',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.kanit(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'โปรดแนบรูปหลักฐานเพื่อแสดงแก่นิติบุคคล',
            style: GoogleFonts.kanit(
              fontSize: 16.0,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 10),
          if (selectedImages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  for (int i = 0; i < selectedImages.length; i++)
                    Row(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showFullImageDialog(selectedImages[i]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 216, 216, 216),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Image.file(
                                    selectedImages[i],
                                    height: 100,
                                    width: 100,
                                    //fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _removeImage(i);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
              child: GestureDetector(
                onTap: () async {
                  await _pickImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'แนบรูปภาพ',
                            style: GoogleFonts.kanit(
                              color: Colors.red,
                              fontSize: 16.0,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              saveReportWork(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 120.0,
              ),
              child: Text(
                'แจ้งปัญหา',
                style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
