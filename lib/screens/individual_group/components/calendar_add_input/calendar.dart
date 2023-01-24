import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/bottom_calendar.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/box_decoration.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/text.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    final user = Provider.of<AuthProvider>(context).user;
    if (group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    }
    final participant =
        group.participantsData.firstWhere((element) => element.uid == user?.id);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Insets.s,
            ),
          ),
        ),
        color: Colors.white,
        child: Column(
          children: [
            TableCalendar(
              locale: 'en_Us',
              rowHeight: 40,
              rangeStartDay: group.startDate,
              rangeEndDay: group.endDate,
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
                    borderRadius: BorderRadius.circular(Insets.xs),
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
                  fontSize: TextSize.mBody,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: SvgPicture.asset(
                  'assets/icons/arrow_left.svg',
                  height: Insets.l,
                  width: Insets.l,
                ),
                rightChevronIcon: SvgPicture.asset(
                  'assets/icons/arrow_right.svg',
                  height: Insets.l,
                  width: Insets.l,
                ),
              ),
              focusedDay: today,
              firstDay: DateTime.utc(2022),
              lastDay: DateTime.utc(2050),
            ),
            const SizedBox(height: Insets.s),
            BottomCalendar(
              participant: participant,
            ),
          ],
        ),
      ),
    );
  }
}