import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/screens/individual_group/components/chart/comparative_chart.dart';

class BottomCalendar extends StatelessWidget {
  const BottomCalendar({required this.participant});

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: ComparativeChart(userData1: participant.inputData),
      ),
    );
  }
}
