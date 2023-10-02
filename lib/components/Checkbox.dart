import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String option1Text;
  final String option2Text;
  final Function(bool) onChanged;

  CustomCheckbox({required this.option1Text, required this.option2Text, required this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
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
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
              SizedBox(width: 5),
              Text(widget.option1Text),
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
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
              SizedBox(width: 5),
              Text(widget.option2Text),
            ],
          ),
        ),
      ],
    );
  }
}
