import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:groupup/screens/group/components/chart/axis_title.dart';

class ComparativeChart extends StatelessWidget {
  const ComparativeChart(
      {required this.userData1, required this.userData2});

  final List<UserInputData> userData1;
  final List<UserInputData> userData2;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 15,
        titlesData: LineTitles.getTitleData(),
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
              spots: List.generate(7, (index) {
                var data = 0.0;
                if (userData1.length > index) {
                  data = userData1[index].value;
                }
                return FlSpot(index.toDouble(), data);
              }),
              color: kSecondaryColor,
              barWidth: 1,
              dotData: FlDotData(
                getDotPainter: (p0, p1, p2, p3) {
                  return FlDotCirclePainter(
                    color: Colors.white,
                    strokeColor: kSecondaryColor,
                  );
                },
              )),
          LineChartBarData(
              spots: List.generate(7, (index) {
                var data = 0.0;
                if (userData2.length > index) {
                  data = userData2[index].value;
                }
                return FlSpot(index.toDouble(), data);
              }),
              color: kPrimaryColor,
              barWidth: 1,
              dotData: FlDotData(
                getDotPainter: (p0, p1, p2, p3) {
                  return FlDotCirclePainter(
                    color: kPrimaryColor,
                    strokeColor: kPrimaryColor,
                  );
                },
              )),
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
          horizontalInterval: 5,
        ),
      ),
    );
  }
}
