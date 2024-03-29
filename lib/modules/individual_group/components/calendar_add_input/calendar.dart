import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/modules/individual_group/components/chart/comparative_chart.dart';
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
    final isVerySmallScreen =
        context.screenHeight < 600 || context.screenWidth < 300;
    if (group == null) {
      return const GPLoading();
    }
    final participant = group.participantsData.firstWhere(
      (element) => element.uid == user?.id,
    );
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        Insets.s,
                      ),
                    ),
                  ),
                  color: GPColors.white,
                  child: Column(
                    children: [
                      TableCalendar(
                        locale: Localizations.localeOf(
                          context,
                        ).toLanguageTag(),
                        rowHeight: 40,
                        rangeStartDay: group.startDate,
                        rangeEndDay: group.endDate,
                        calendarStyle: CalendarStyle(
                          tablePadding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          defaultTextStyle: bottomCalendarTextStyle(
                            context,
                          ),
                          weekendTextStyle: bottomCalendarTextStyle(
                            context,
                          ),
                          holidayTextStyle: bottomCalendarTextStyle(
                            context,
                          ),
                          rangeEndTextStyle: TextStyle(
                            color: GPColors.white,
                            fontFamily: 'Montserrat-Medium',
                            fontSize: isVerySmallScreen
                                ? TextSize.xsBody
                                : TextSize.mBody,
                          ),
                          rangeStartTextStyle: TextStyle(
                            color: GPColors.white,
                            fontFamily: 'Montserrat-Medium',
                            fontSize: isVerySmallScreen
                                ? TextSize.xsBody
                                : TextSize.mBody,
                          ),
                          rangeHighlightColor:
                              GPColors.primaryColor.withOpacity(0.6),
                          rangeStartDecoration: boxDecoration(),
                          rangeEndDecoration: boxDecoration(),
                          withinRangeTextStyle: TextStyle(
                            color: GPColors.white,
                            fontFamily: 'Montserrat-Medium',
                            fontSize: isVerySmallScreen
                                ? TextSize.sBody
                                : TextSize.mBody,
                          ),
                          todayTextStyle: TextStyle(
                            color: GPColors.white,
                            fontFamily: 'Montserrat-Medium',
                            fontSize: isVerySmallScreen
                                ? TextSize.sBody
                                : TextSize.mBody,
                          ),
                          todayDecoration: BoxDecoration(
                            border: Border.all(
                              color: GPColors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(Insets.xs),
                            boxShadow: [
                              BoxShadow(
                                color: GPColors.primaryColor.withOpacity(0.6),
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          leftChevronIcon: GPIcon(
                            GPIcons.arrowLeft,
                            height: Insets.l,
                            width: Insets.l,
                          ),
                          rightChevronIcon: GPIcon(
                            GPIcons.arrowRight,
                            height: Insets.l,
                            width: Insets.l,
                          ),
                        ),
                        focusedDay: today,
                        firstDay: DateTime(2022),
                        lastDay: DateTime(2100),
                      ),
                      const SizedBox(
                        height: Insets.s,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: kDefaultPadding),
                        alignment: Alignment.bottomRight,
                        height: 120,
                        width: 400,
                        color: GPColors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: kDefaultPadding,
                            left: kDefaultPadding,
                            right: kDefaultPadding / 2,
                            bottom: kDefaultPadding / 2,
                          ),
                          child: ComparativeChart(
                              userData1: participant.inputData),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Insets.l * 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: GPColors.primaryColor),
      borderRadius: BorderRadius.circular(Insets.xs),
      color: GPColors.primaryColor,
      boxShadow: const [
        BoxShadow(
          color: GPColors.secondaryColor,
          spreadRadius: 1,
          blurRadius: 2,
        ),
      ],
    );
  }

  TextStyle bottomCalendarTextStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat-Medium',
      fontSize: context.isVerySmallScreen ? 14 : 16,
      color: const Color(0xFF7A7A7A),
    );
  }
}
