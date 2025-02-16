import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/datas/graph_data.dart';
import 'package:ours_log/views/graph/graph_body.dart';

class CustomLineGraph extends StatelessWidget {
  const CustomLineGraph({
    super.key,
    required this.countOfDay,
    required this.graphData,
  });

  final int countOfDay;

  final GraphData graphData;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.75,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              preventCurveOverShooting: true,
              isStrokeCapRound: true,
              isStrokeJoinRound: true,
              spots: List.generate(
                graphData.xDatas.length,
                (index) => graphData.xDatas[index] == 0
                    ? FlSpot.nullSpot
                    : FlSpot(
                        index.toDouble(),
                        graphData.xDatas[index],
                      ),
              ),
              color: Colors.grey,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: unShowTitles(),
            rightTitles: unShowTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (countOfDay / (28 % 4 == 0 ? 4 : 5)).ceilToDouble(),
                getTitlesWidget: (value, meta) {
                  return Text(
                      '${(value + 1).toStringAsFixed(0)}${AppString.day.tr}');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) {
                  return Text(value.toStringAsFixed(1));
                },
              ),
            ),
          ),
          minX: 0,
          maxX: (countOfDay - 1).toDouble(),
          minY: graphData.minY,
          maxY: graphData.maxY,
        ),
      ),
    );
  }

  AxisTitles unShowTitles() {
    return const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
  }
}

class CustomFealLineGraph extends StatelessWidget {
  const CustomFealLineGraph({
    super.key,
    required this.countOfDay,
    required this.graphData,
  });

  final int countOfDay;

  final GraphData graphData;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.75,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              preventCurveOverShooting: true,
              isStrokeCapRound: true,
              isStrokeJoinRound: true,
              spots: List.generate(
                graphData.xDatas.length,
                (index) => graphData.xDatas[index] == 0
                    ? FlSpot.nullSpot
                    : FlSpot(
                        index.toDouble(),
                        graphData.xDatas[index],
                      ),
              ),
              color: Colors.grey,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: unShowTitles(),
            rightTitles: unShowTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (countOfDay / (28 % 4 == 0 ? 4 : 5)).ceilToDouble(),
                getTitlesWidget: (value, meta) {
                  return Text(
                      '${(value + 1).toStringAsFixed(0)}${AppString.day.tr}');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) {
                  Color color = Colors.pinkAccent;

                  switch (value) {
                    case 1.0:
                      color = const Color(0xFFff5b59);
                      break;
                    case 2.0:
                      color = const Color(0xFFb7f3fe);
                      break;
                    case 3.0:
                      color = const Color(0xFF00ff01);
                      break;
                    case 4.0:
                      color = const Color(0xFFfedd50);
                      break;
                    case 5.0:
                      color = const Color(0xFFffb7cb);
                      break;
                    default:
                      return Container();
                  }
                  // return Text(value.toStringAsFixed(1));
                  return CircleAvatar(
                    radius: RS.h10 * .8,
                    backgroundColor: color,
                  );
                },
              ),
            ),
          ),
          minX: 0,
          maxX: (countOfDay - 1).toDouble(),
          minY: graphData.minY,
          maxY: graphData.maxY,
        ),
      ),
    );
  }

  AxisTitles unShowTitles() {
    return const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
  }
}

getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }
  const List<int> daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
  return daysInMonth[month - 1];
}
