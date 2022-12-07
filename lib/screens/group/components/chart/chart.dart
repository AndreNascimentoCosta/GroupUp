import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/group/components/chart/axis_title.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

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
            spots: const [
              FlSpot(0, 0),
              FlSpot(1, 3),
              FlSpot(2, 6),
              FlSpot(3, 2),
              FlSpot(4, 8),
              FlSpot(5, 12),
              FlSpot(6, 5),
            ],
            color: kSecondaryColor,
            barWidth: 1,
            dotData: FlDotData(getDotPainter: (p0, p1, p2, p3) {
              return FlDotCirclePainter(
                color: Colors.white,
                strokeColor: kSecondaryColor,
              );
            },)
          ),
          LineChartBarData(
              spots: const [
                FlSpot(0, 0),
                FlSpot(1, 5),
                FlSpot(2, 4),
                FlSpot(3, 2),
                FlSpot(4, 12),
                FlSpot(5, 9),
                FlSpot(6, 3),
              ],
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
