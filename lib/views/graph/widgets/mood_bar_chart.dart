// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:ours_log/common/utilities/app_image_path.dart';
// import 'package:ours_log/controller/diary_controller.dart';
// import 'package:ours_log/models/diary_model.dart';
// import 'package:ours_log/views/graph/widgets/mood_line_chart.dart';

// class MoodBarChart extends StatelessWidget {
//   const MoodBarChart(
//       {super.key,
//       required this.fealingCost,
//       required this.xAxisDates,
//       required this.data});

//   final List<DiaryModel> data;
//   final List<int> fealingCost;
//   final List<DateTime> xAxisDates;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("기분 상태 그래프")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: BarChart(
//           BarChartData(
//             barGroups: List.generate(
//               xAxisDates.length,
//               (index) => BarChartGroupData(
//                 x: index,
//                 barRods: [
//                   BarChartRodData(
//                     toY: fealingCost[index].toDouble(),
//                     color: Colors.blue,
//                     width: 16,
//                   ),
//                 ],
//               ),
//             ),
//             minY: 0,
//             maxY: 5,
//             titlesData: FlTitlesData(
//               topTitles:
//                   const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               rightTitles:
//                   const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 50,
//                   interval: 1,
//                   getTitlesWidget: (value, meta) {
//                     int index = value.toInt();

//                     if (index < 0 || index >= xAxisDates.length)
//                       return Container();
//                     DateTime date = xAxisDates[index];
//                     String formattedDate =
//                         DateFormat("MM/dd").format(date); // "2/11" 형식
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child:
//                           Text(formattedDate, style: TextStyle(fontSize: 12)),
//                     );
//                   },
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 50,
//                   interval: 1, // ✅ Y축 1단위 설정
//                   getTitlesWidget: (value, meta) {
//                     switch (value) {
//                       case 1:
//                         return Image.asset(
//                           AppImagePath.feal1,
//                           width: 50,
//                           height: 50,
//                         );
//                       case 2:
//                         return Image.asset(
//                           AppImagePath.feal2,
//                           width: 50,
//                           height: 50,
//                         );
//                       case 3:
//                         return Image.asset(
//                           AppImagePath.feal3,
//                           width: 50,
//                           height: 50,
//                         );

//                       case 4:
//                         return Image.asset(
//                           AppImagePath.feal4,
//                           width: 50,
//                           height: 50,
//                         );
//                       case 5:
//                         return Image.asset(
//                           AppImagePath.feal5,
//                           width: 50,
//                           height: 50,
//                         );
//                       default:
//                         return Container();
//                     }
//                   },
//                 ),
//               ),
//             ),
//             gridData: const FlGridData(show: true, drawHorizontalLine: false),
//             borderData: FlBorderData(
//               show: true,
//               border: Border.all(color: Colors.black, width: 1),
//             ),

//             // lineBarsData: [
//             //   LineChartBarData(
//             //     spots: List.generate(xAxisDates.length, (index) {
//             //       return FlSpot(
//             //         index.toDouble(),
//             //         fealingCost[index] * 1.0,
//             //       );
//             //     }),
//             //     color: Colors.grey,
//             //     dotData: FlDotData(show: false),
//             //     belowBarData: BarAreaData(show: false),
//             //   ),
//             // ],
//           ),
//         ),
//       ),
//     );
//   }
// }
