import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/user_information.dart';
import 'package:groupup/screens/individual_group/components/chart/comparative_chart.dart';

class BottomCalendar extends StatelessWidget {
  const BottomCalendar({required this.individualGroup});

  final UserInformation individualGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: kDefaultPadding),
      alignment: Alignment.bottomRight,
      height: 120,
      width: 400,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding,
          right: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        child: ComparativeChart(userData1: individualGroup.userInputData, userData2: individualGroup.userInputData,),
      ),
    );
  }
}
