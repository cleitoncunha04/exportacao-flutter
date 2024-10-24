import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final void Function() dtPicker;
  const DatePicker({
    super.key, required this.dtPicker, required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
   

    return Row(
      children: [
        Expanded(
          child: Text(
            'Selected date: ${DateFormat('M/d/yyyy').format(selectedDate)}',
          ),
        ),
        ElevatedButton(
          onPressed: dtPicker,
          child: Text('Select a Date'),
        ),
      ],
    );
  }
}