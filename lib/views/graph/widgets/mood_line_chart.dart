// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:ours_log/common/utilities/app_image_path.dart';

// class MoodLineChart extends StatelessWidget {
//   const MoodLineChart(
//       {super.key, required this.fealingCost, required this.xAxisDates});

//   final List<int> fealingCost;
//   final List<DateTime> xAxisDates;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("기분 상태 그래프")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: LineChart(
//           LineChartData(
//             lineBarsData: [
//               LineChartBarData(
//                 spots: List.generate(xAxisDates.length, (index) {
//                   return FlSpot(
//                     index.toDouble(),
//                     fealingCost[index] * 1.0,
//                   );
//                 }),
//                 color: Colors.grey,
//                 dotData: const FlDotData(show: false),
//                 belowBarData: BarAreaData(show: false),
//               ),
//             ],
//             minX: 0,
//             maxX: 6,
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
//                     String formattedDate = DateFormat("MM/dd").format(date);
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
//                   interval: 1,
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
//           ),
//         ),
//       ),
//     );
//   }
// }
