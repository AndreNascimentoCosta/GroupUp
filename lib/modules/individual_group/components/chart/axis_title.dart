import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/participant_model.dart';
import 'package:groupup/models/user_input_data_model.dart';
import 'package:groupup/modules/individual_group/components/chart/case.dart';

class LineTitles {
  static getTitleData(
      Participant currentUserData, List<UserInputData> userData) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(sideTitles: bottomTitles),
      leftTitles: AxisTitles(
        sideTitles: currentUserData.inputData.isNotEmpty
            ? leftTitles(currentUserData, userData)
            : leftTitlesInputDataNull(userData),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
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

SideTitles leftTitles(
    Participant currentUserData, List<UserInputData>? userData1) {
  userData1 ??= [];
  final greater = max(
    currentUserData.inputData.isNotEmpty
        ? currentUserData.inputData.map((e) => e.value).reduce(max)
        : 0,
    userData1.isNotEmpty ? userData1.map((e) => e.value).reduce(max) : 0,
  );
  final value = greater / 5;
  return SideTitles(
    interval: value,
    showTitles: true,
    reservedSize: getReservedSize(greater),
    getTitlesWidget: (value, meta) {
      return GPTextBody(
        text: greater < 1
            ? value.toStringAsFixed(3)
            : greater < 5
                ? value.toStringAsFixed(2)
                : value.round().toString(),
        color: GPColors.secondaryColor,
        fontSize: 12,
      );
    },
  );
}

double getReservedSize(num greater) {
  double reservedSize;
  if (greater < 1) {
    reservedSize = 50;
  } else if (greater < 5) {
    reservedSize = 40;
  } else if (greater > 999) {
    reservedSize = 40;
  } else if (greater > 9999) {
    reservedSize = 50;
  } else if (greater > 99999) {
    reservedSize = 80;
  } else {
    reservedSize = 30;
  }
  return reservedSize;
}

SideTitles leftTitlesInputDataNull(List<UserInputData> userData) {
  final firstInputNotEmpty = userData.isNotEmpty
      ? userData
              .map((e) => e.value)
              .reduce((value, element) => value > element ? value : element) /
          5
      : 1;
  return SideTitles(
    interval: firstInputNotEmpty.toDouble(),
    showTitles: true,
    reservedSize: 30,
    getTitlesWidget: (value, meta) {
      return GPTextBody(
        text: value.round().toString(),
        color: GPColors.secondaryColor,
        fontSize: 12,
      );
    },
  );
}
