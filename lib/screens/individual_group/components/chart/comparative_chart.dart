import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:groupup/screens/individual_group/components/chart/axis_title.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';

class ComparativeChart extends StatelessWidget {
  const ComparativeChart({
    required this.userData1,
  });

  final List<UserInputData> userData1;

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider = Provider.of<IndividualGroupProvider>(
      context,
      listen: false,
    );
    final currentUserId = Provider.of<AuthProvider>(context).user?.id;
    if (individualGroupProvider.group == null) return Container();
    final currentUserData = individualGroupProvider.group!.participantsData
        .firstWhere((element) => element.uid == currentUserId);
    final greater = max(
      currentUserData.inputData.isNotEmpty
          ? currentUserData.inputData.map((e) => e.value).reduce(max)
          : 0,
      userData1.isNotEmpty ? userData1.map((e) => e.value).reduce(max) : 0,
    );
    if (currentUserData.inputData.isEmpty) {
      return LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: userData1.isNotEmpty
              ? userData1
                  .map((e) => e.value)
                  .reduce((value, element) => value > element ? value : element)
              : 5,
          titlesData: LineTitles.getTitleData(currentUserData, userData1),
          borderData: FlBorderData(
            border: const Border(
              bottom: BorderSide(
                color: kSecondaryColor,
                width: 0.5,
              ),
              top: BorderSide(
                color: kSecondaryColor,
                width: 0.5,
              ),
            ),
          ),
          lineBarsData: <LineChartBarData>[
            LineChartBarData(
              spots: List.generate(
                7,
                (index) {
                  return FlSpot(
                    index.toDouble(),
                    0,
                  );
                },
              ),
              color: kSecondaryColor,
              barWidth: 1,
              dotData: FlDotData(
                getDotPainter: (p0, p1, p2, p3) {
                  return FlDotCirclePainter(
                    color: Colors.white,
                    strokeColor: kSecondaryColor,
                  );
                },
              ),
            ),
            LineChartBarData(
              spots: List.generate(
                7,
                (index) {
                  final dateTimeResult = DateTime.now().subtract(
                    Duration(days: 6 - index),
                  );
                  final userInputData = userData1.firstWhere(
                    (element) => element.date.day == dateTimeResult.day,
                    orElse: () {
                      return UserInputData(
                        date: dateTimeResult,
                        value: 0,
                      );
                    },
                  );
                  final value = userInputData.value;
                  return FlSpot(
                    index.toDouble(),
                    value.toDouble(),
                  );
                },
              ),
              color: kPrimaryColor,
              barWidth: 1,
              dotData: FlDotData(
                getDotPainter: (p0, p1, p2, p3) {
                  return FlDotCirclePainter(
                    color: kPrimaryColor,
                    strokeColor: kPrimaryColor,
                  );
                },
              ),
            ),
          ],
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: kSecondaryColor,
                strokeWidth: 0.5,
              );
            },
            drawVerticalLine: false,
            horizontalInterval: userData1.isNotEmpty
                ? userData1.map((e) => e.value).reduce(
                        (value, element) => value > element ? value : element) /
                    5
                : 1,
          ),
        ),
      );
    } else {
      return LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: greater.toDouble(),
          titlesData: LineTitles.getTitleData(
            currentUserData,
            userData1,
          ),
          borderData: FlBorderData(
            border: const Border(
              bottom: BorderSide(
                color: kSecondaryColor,
                width: 0.5,
              ),
              top: BorderSide(
                color: kSecondaryColor,
                width: 0.5,
              ),
            ),
          ),
          lineBarsData: <LineChartBarData>[
            LineChartBarData(
              spots: List.generate(
                7,
                (index) {
                  final dateTimeResult = DateTime.now().subtract(
                    Duration(days: 6 - index),
                  );
                  final currentUserInputData =
                      currentUserData.inputData.firstWhere(
                    (element) => element.date.day == dateTimeResult.day,
                    orElse: () {
                      return UserInputData(
                        date: dateTimeResult,
                        value: 0,
                      );
                    },
                  );
                  final value = currentUserInputData.value;
                  return FlSpot(
                    index.toDouble(),
                    value.toDouble(),
                  );
                },
              ),
              color: kSecondaryColor,
              barWidth: 1,
              dotData: FlDotData(
                getDotPainter: (p0, p1, p2, p3) {
                  return FlDotCirclePainter(
                    color: Colors.white,
                    strokeColor: kSecondaryColor,
                  );
                },
              ),
            ),
            LineChartBarData(
              spots: List.generate(
                7,
                (index) {
                  final dateTimeResult = DateTime.now().subtract(
                    Duration(days: 6 - index),
                  );
                  final userInputData = userData1.firstWhere(
                    (element) => element.date.day == dateTimeResult.day,
                    orElse: () {
                      return UserInputData(
                        date: dateTimeResult,
                        value: 0,
                      );
                    },
                  );
                  final value = userInputData.value;
                  return FlSpot(
                    index.toDouble(),
                    value.toDouble(),
                  );
                },
              ),
              color: kPrimaryColor,
              barWidth: 1,
              dotData: FlDotData(
                getDotPainter: (p0, p1, p2, p3) {
                  return FlDotCirclePainter(
                    color: kPrimaryColor,
                    strokeColor: kPrimaryColor,
                  );
                },
              ),
            ),
          ],
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: kSecondaryColor,
                strokeWidth: 0.5,
              );
            },
            drawVerticalLine: false,
            horizontalInterval: greater / 5,
          ),
        ),
      );
    }
  }
}
