import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/datas/graph_data.dart';
import 'package:ours_log/views/graph/widgets/pie_chart_indicator.dart';

Color veryGoodColor = const Color.fromRGBO(255, 91, 89, 1);
Color goodColor = const Color(0xFFb7f3fe);
Color sosoColor = const Color(0xFF00ff01);
Color badColor = const Color(0xFFfedd50);
Color veryBadColor = const Color(0xFFffb7cb);

class CustomPainLevelPieChart extends StatefulWidget {
  const CustomPainLevelPieChart(
      {super.key, required this.graphData, required this.countOfDay});

  final GraphData graphData;
  final int countOfDay;
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<CustomPainLevelPieChart> {
  int touchedIndex = -1;
  List<double> fealIndexPercent = [];

  void ca() {
    List<double> tempFealIndexCount = List.generate(10, (index) => 0.0);

    for (var i = 0; i < widget.graphData.xDatas.length; i++) {
      tempFealIndexCount[widget.graphData.xDatas[i].toInt()]++;
    }

    fealIndexPercent = List.generate(10, (index) => 0.0);
    for (var i = 0; i < tempFealIndexCount.length; i++) {
      fealIndexPercent[i] = (tempFealIndexCount[i] / widget.countOfDay) * 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    ca();
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          SizedBox(width: RS.w10 * 2),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              10,
              (index) => PieChartIndicator(
                text: index.toString(),
                color: veryGoodColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(10, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.grey,
            value: fealIndexPercent[0],
            title: '${fealIndexPercent[0].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: veryGoodColor,
            value: fealIndexPercent[1],
            title: '${fealIndexPercent[1].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: goodColor,
            value: fealIndexPercent[2],
            title: '${fealIndexPercent[2].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );

        case 3:
          return PieChartSectionData(
            color: sosoColor,
            value: fealIndexPercent[3],
            title: '${fealIndexPercent[3].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: badColor,
            value: fealIndexPercent[4],
            title: '${fealIndexPercent[4].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 5:
          return PieChartSectionData(
            color: veryBadColor,
            value: fealIndexPercent[5],
            title: '${fealIndexPercent[5].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 6:
          return PieChartSectionData(
            color: veryBadColor,
            value: fealIndexPercent[5],
            title: '${fealIndexPercent[5].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 7:
          return PieChartSectionData(
            color: veryBadColor,
            value: fealIndexPercent[5],
            title: '${fealIndexPercent[5].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 8:
          return PieChartSectionData(
            color: veryBadColor,
            value: fealIndexPercent[5],
            title: '${fealIndexPercent[5].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 9:
          return PieChartSectionData(
            color: veryBadColor,
            value: fealIndexPercent[5],
            title: '${fealIndexPercent[5].toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
