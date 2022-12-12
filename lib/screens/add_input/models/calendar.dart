import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/individual_group.dart';
import 'package:groupup/screens/add_input/models/back.dart';
import 'package:groupup/screens/add_input/models/bottom_calendar.dart';
import 'package:groupup/screens/add_input/models/box_decoration.dart';
import 'package:groupup/screens/add_input/models/forth.dart';
import 'package:groupup/screens/add_input/styles/text.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({required this.groupModel, required this.individualGroup});

  final GroupModel groupModel;
  final IndividualGroup individualGroup;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.white,
        child: Column(
          children: [
            TableCalendar(
              locale: 'en_Us',
              rowHeight: 40,
              rangeStartDay:
                  widget.groupModel.generalGroupInfoModel.startDate,
              rangeEndDay:
                  widget.groupModel.generalGroupInfoModel.endDate,
              calendarStyle: CalendarStyle(
                tablePadding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                defaultTextStyle: textStyle(),
                weekendTextStyle: textStyle(),
                holidayTextStyle: textStyle(),
                rangeHighlightColor: const Color(0X9946E297),
                rangeStartDecoration: boxDecoration(),
                rangeEndDecoration: boxDecoration(),
                todayDecoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0X9946E297),
                        spreadRadius: 1,
                        blurRadius: 2,
                      ),
                    ]),
                withinRangeTextStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat-Medium',
                  fontSize: 16,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: back(),
                rightChevronIcon: forth(),
              ),
              focusedDay: today,
              firstDay: DateTime.utc(2022),
              lastDay: DateTime.utc(2050),
            ),
            const SizedBox(
              height: 10,
            ),
            BottomCalendar(
              individualGroup: widget.individualGroup,
            ),
          ],
        ),
      ),
    );
  }
}