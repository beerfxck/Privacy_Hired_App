import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectionComponent extends StatefulWidget {
  @override
  _DateSelectionComponentState createState() => _DateSelectionComponentState();
}

class _DateSelectionComponentState extends State<DateSelectionComponent> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color.fromARGB(255, 43, 45, 46),
            width: 1.0,
          ),
        ),
        child: TextFormField(
          controller: TextEditingController(text: formattedDate),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 15, 0, 0),
            suffixIcon: Icon(Icons.calendar_month),
            border: InputBorder.none,
          ),
          enabled: false,
        ),
      ),
    );
  }
}
