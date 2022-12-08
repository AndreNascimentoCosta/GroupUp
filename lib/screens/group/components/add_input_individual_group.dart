import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AddInput extends StatefulWidget {
  const AddInput({super.key});

  @override
  State<AddInput> createState() => _AddInputState();
}

class _AddInputState extends State<AddInput> {

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        focusedDay: today,
        firstDay: DateTime.utc(
          2022,
          10,
          15,
        ),
        lastDay: DateTime.utc(
          2022,
          12,
          02,
        ),
      ),
    );
  }
}
