import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/add_input/models/back.dart';
import 'package:groupup/screens/add_input/models/box_decoration.dart';
import 'package:groupup/screens/add_input/models/forth.dart';
import 'package:groupup/screens/add_input/styles/text.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({required this.groupModel});

  final GroupModel groupModel;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.white,
        child: Column(
          children: [
            TableCalendar(
              locale: 'en_Us',
              rowHeight: 50,
              rangeStartDay: widget.groupModel.topBarIndividualGroupModel.startDate,
              rangeEndDay: widget.groupModel.topBarIndividualGroupModel.endDate,
              calendarStyle: CalendarStyle(
                tablePadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
              availableGestures: AvailableGestures.all,
              focusedDay: today,
              firstDay: DateTime.utc(2022),
              lastDay: DateTime.utc(2050),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
