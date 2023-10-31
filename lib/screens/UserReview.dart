import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserReview extends StatefulWidget {
  const UserReview({super.key});

  @override
  State<UserReview> createState() => _UserReviewtState();
}

class _UserReviewtState extends State<UserReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Color.fromARGB(217, 255, 255, 255),
        leading: Padding(
          padding: EdgeInsets.only(left: 35.0),
          child: Transform.scale(
            scale: 3.5,
            child: Image.asset('images/logo_maid.png'),
          ),
        ),
      ),
    );
  }
}