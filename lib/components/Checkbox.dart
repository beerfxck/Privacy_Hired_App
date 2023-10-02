import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String resident;
  final String maid;
  final Function(bool) onChanged;

  CustomCheckbox({required this.resident, required this.maid, required this.onChanged});

  @override
, required String maid, required String resident, required String resident  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
              widget.onChanged(isChecked);
            });
          },
          child: Row(
            children: [
              isChecked
                  ? Icon(
                      Icons.check_box,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
              SizedBox(width: 5),
              Text(widget.resident),
            ],
          ),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
              widget.onChanged(isChecked);
            });
          },
          child: Row(
            children: [
              !isChecked
                  ? Icon(
                      Icons.check_box,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
              SizedBox(width: 5),
              Text(widget.maid),
            ],
          ),
        ),
      ],
    );
  }
}
