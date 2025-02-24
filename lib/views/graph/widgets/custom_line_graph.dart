import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/datas/graph_data.dart';

class CustomLineGraph extends StatelessWidget {
  const CustomLineGraph({
    super.key,
    required this.countOfDay,
    required this.graphData,
    this.graphData2,
  });

  final int countOfDay;
  final GraphData graphData;
  final GraphData? graphData2;

  @override
  Widget build(BuildContext context) {
    double maxY = graphData.maxY;
    double minY = graphData.minY;

    if (graphData2 != null) {
      if (graphData2!.maxY > graphData.maxY) {
        maxY = graphData2!.maxY;
      }
      if (graphData2!.minY < graphData.minY) {
        minY = graphData2!.minY;
      }
    }
    return AspectRatio(
      aspectRatio: 1.75,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true, drawVerticalLine: false),
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
              color: AppColors.primaryColor,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
            if (graphData2 != null)
              LineChartBarData(
                preventCurveOverShooting: true,
                isStrokeCapRound: true,
                isStrokeJoinRound: true,
                spots: List.generate(
                  graphData2!.xDatas.length,
                  (index) => graphData2!.xDatas[index] == 0
                      ? FlSpot.nullSpot
                      : FlSpot(
                          index.toDouble(),
                          graphData2!.xDatas[index],
                        ),
                ),
                color: AppColors.secondaryColor,
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
          lineTouchData: const LineTouchData(enabled: false),
          minX: 0,
          maxX: (countOfDay - 1).toDouble(),
          maxY: maxY,
          minY: minY,
          // minY: graphData2 == null
          //     ? graphData.minY
          //     : graphData.minY ?? 0 + graphData2!.minY!,
          // // maxY: graphData.maxY,

          // maxY: graphData2 == null
          //     ? graphData.maxY
          //     : graphData.maxY ?? 0 + graphData2!.maxY!,
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
