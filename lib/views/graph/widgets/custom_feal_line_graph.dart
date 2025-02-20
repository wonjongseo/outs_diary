import 'package:ours_log/common/utilities/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/datas/graph_data.dart';

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
          gridData: const FlGridData(show: true, drawVerticalLine: false),
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => Colors.grey,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                String text = '';
                switch (flSpot.y) {
                  case 1:
                    text = AppString.veryBad.tr;
                    break;
                  case 2:
                    text = AppString.bad.tr;
                    break;
                  case 3:
                    text = AppString.soso.tr;
                    break;
                  case 4:
                    text = AppString.good.tr;
                    break;
                  case 5:
                    text = AppString.veryGood.tr;

                    break;
                }
                return LineTooltipItem(
                  text,
                  const TextStyle(fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          )),
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
                interval: 1,
                getTitlesWidget: (value, meta) {
                  Color color = AppColors.primaryColor;
                  String text = '';

                  switch (value) {
                    case 1.0:
                      color = const Color.fromRGBO(255, 91, 89, 1);
                      text = AppString.veryGood.tr;
                      break;
                    case 2.0:
                      color = const Color(0xFFb7f3fe);
                      text = AppString.good.tr;
                      break;
                    case 3.0:
                      color = const Color(0xFF00ff01);
                      text = AppString.soso.tr;
                      break;
                    case 4.0:
                      color = const Color(0xFFfedd50);
                      text = AppString.bad.tr;
                      break;
                    case 5.0:
                      color = const Color(0xFFffb7cb);
                      text = AppString.veryBad.tr;
                      break;
                    default:
                      return Container();
                  }
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
