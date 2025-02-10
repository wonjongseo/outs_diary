import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            AspectRatio(
              // 차트 비율
              aspectRatio: 3 / 2,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LineChart(mainData()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// x축 하단 레이블
  Widget bottomTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    // value : 각 x축 값
    switch (value.toInt()) {
      case 1:
        text = const Text('MAR ', style: style);
        break;
      case 2:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: Text(value.toInt().toString()),
    );
  }

  /// y축 좌측 레이블 위젯
  Widget leftTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    // value : 차트 상 y축 크기 당 1 value
    // switch (value.toInt()) {
    //   case 1:
    //     text = '10K';
    //     break;
    //   case 3:
    //     text = '30k';
    //     break;
    //   case 5:
    //     text = '50k';
    //     break;
    //   case 7:
    //     text = '70k';
    //     break;
    //   default:
    //     return Container();
    // }
    return Text(value.toInt().toString(),
        style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      minX: 0, // x축 최소
      maxX: 7, // x축 최대
      minY: 0, // y축 최소
      maxY: 7, // y축 최대
      titlesData: FlTitlesData(
        // 차트 레이블
        show: true,
        bottomTitles: AxisTitles(
          // x축 하단 표시
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30, // 레이블 공간 확보
            interval: 1,
            getTitlesWidget: bottomTitleWidget,
          ),
        ),
        leftTitles: AxisTitles(
          // y축 좌측 표시
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidget, // 왼쪽에 표시되는 값들
            reservedSize: 42, // 값들 과 차트 사이의 공간 사이즈
          ),
        ),
        topTitles: AxisTitles(
          // x축 상단 표시
          sideTitles: SideTitles(showTitles: false),
        ),

        rightTitles: AxisTitles(
          // y축 우측 표시
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
          // 차트 외부 테두리
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      gridData: FlGridData(
        // 차트 내부 그리드 선
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1, // 간격
        verticalInterval: 1, // 간격
        getDrawingHorizontalLine: (value) {
          // 가로선 - 기본 점선
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          // 세로선 - 기본 점선
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      lineBarsData: [
        // 차트 선
        LineChartBarData(
          spots: const [
            // 차트 점 찍을 좌표
            FlSpot(0, 3),
            FlSpot(1, 5),
            FlSpot(2, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
          ],
          isCurved: true, // 차트 선이 꺾은선(false), 부드러운 선(true)
          gradient: LinearGradient(
            // 차트 선의 명암
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 3, // 차트 선 굵기
          isStrokeCapRound: true, // 차트 선의 처음과 끝을 둥글게 처리
          dotData: FlDotData(
            // spot마다 표시 여부
            show: true,
          ),
          belowBarData: BarAreaData(
            // 차트 선 하단 공간 명암
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(// 차트 선 툴팁
          touchTooltipData:
              LineTouchTooltipData(getTooltipItems: (touchedSpots) {
        return touchedSpots.map((touchedSpot) {
          return LineTooltipItem("${touchedSpot.y.toInt()}0K",
              const TextStyle(color: Colors.white));
        }).toList();
      })),
    );
  }
}
