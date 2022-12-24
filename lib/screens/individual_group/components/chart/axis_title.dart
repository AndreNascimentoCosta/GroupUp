import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/individual_group/components/chart/case.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(sideTitles: bottomTitles),
        leftTitles: AxisTitles(sideTitles: leftTitles),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );
}

SideTitles get bottomTitles {
  return SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      switch (value.toInt()) {
        case 0:
          return const CaseChart(days: 6);
        case 1:
          return const CaseChart(days: 5);
        case 2:
          return const CaseChart(days: 4);
        case 3:
          return const CaseChart(days: 3);
        case 4:
          return const CaseChart(days: 2);
        case 5:
          return const CaseChart(days: 1);
        case 6:
          return const CaseChart(days: 0);
      }
      return const Text('');
    },
  );
}

SideTitles get leftTitles {
  return SideTitles(
    interval: 5,
    showTitles: true,
    getTitlesWidget: (value, meta) {
      return StaticText(
        text: value.round().toString(),
        color: kSecondaryColor,
        fontSize: TextSize.xsBody,
      );
    },
  );
}
