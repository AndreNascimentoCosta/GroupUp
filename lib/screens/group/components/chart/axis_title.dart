import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/group/components/chart/text_style_chart.dart';
import 'package:intl/intl.dart';

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
          return SizedBox(
            height: 30,
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                Text(
                  DateFormat.E().format(
                      DateTime.now().subtract(const Duration(days: 6)))[0],
                  style: textStyleChart(),
                ),
              ],
            ),
          );
        case 1:
          return SizedBox(
            height: 30,
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                Text(
                  DateFormat.E()
                      .format(DateTime.now().subtract(const Duration(days: 5)))[0],
                  style: textStyleChart(),
                ),
              ],
            ),
          );
        case 2:
          return SizedBox(
            height: 30,
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                Text(
                  DateFormat.E()
                      .format(DateTime.now().subtract(const Duration(days: 4)))[0],
                  style: textStyleChart(),
                ),
              ],
            ),
          );
        case 3:
          return SizedBox(
            height: 30,
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                Text(
                  DateFormat.E()
                      .format(DateTime.now().subtract(const Duration(days: 3)))[0],
                  style: textStyleChart(),
                ),
              ],
            ),
          );
        case 4:
          return SizedBox(
            height: 30,
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                Text(
                  DateFormat.E()
                      .format(DateTime.now().subtract(const Duration(days: 2)))[0],
                  style: textStyleChart(),
                ),
              ],
            ),
          );
        case 5:
          return SizedBox(
            height: 30,
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                Text(
                  DateFormat.E()
                      .format(DateTime.now().subtract(const Duration(days: 1)))[0],
                  style: textStyleChart(),
                ),
              ],
            ),
          );
        case 6:
          return SizedBox(
            height: 30,
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                Text(
                  DateFormat.E().format(DateTime.now())[0],
                  style: textStyleChart(),
                ),
              ],
            ),
          );
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
      return Text(
        value.round().toString(),
        style: textStyleChart(),
      );
    },
  );
}
