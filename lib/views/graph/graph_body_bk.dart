// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:ours_log/common/utilities/app_image_path.dart';
// import 'package:ours_log/controller/diary_controller.dart';
// import 'package:ours_log/models/diary_model.dart';
// import 'package:ours_log/views/graph/widgets/mood_line_chart.dart';

// class GraphBodyBk extends StatefulWidget {
//   const GraphBodyBk({super.key});

//   @override
//   State<GraphBodyBk> createState() => _GraphBodyBkState();
// }

// class _GraphBodyBkState extends State<GraphBodyBk> {
//   DiaryController diaryController = Get.find<DiaryController>();
//   List<int> fealingCost = [0, 0, 0, 0, 0, 0, 0];
//   List<int> fealingNumber = [0, 0, 0, 0, 0, 0, 0];
//   DateTime now = DateTime.now();

//   bool isDateInRangeInclusive(
//       DateTime date, DateTime startDate, DateTime endDate) {
//     return (date.isAfter(startDate) || date.isAtSameMomentAs(startDate)) &&
//         (date.isBefore(endDate) || date.isAtSameMomentAs(endDate));
//   }

//   late List<DateTime> xAxisDates;

//   @override
//   void initState() {
//     super.initState();

//     DateTime today = DateTime(now.year, now.month, 1);
//     xAxisDates = List.generate(
//       7,
//       (index) => today.subtract(Duration(days: index * 5)),
//     );
//     xAxisDates = xAxisDates.reversed.toList();

//     for (var i = 0; i < xAxisDates.length - 1; i++) {
//       for (var diariy in diaryController.diaries) {
//         if (isDateInRangeInclusive(
//             diariy.dateTime, xAxisDates[i], xAxisDates[i + 1])) {
//           fealingCost[i] += diariy.fealIndex + 1;
//           fealingNumber[i]++;
//         }
//       }
//     }
// //이 제일 좋은거
//     for (var i = 0; i < fealingCost.length; i++) {
//       if (fealingNumber[i] != 0) {
//         fealingCost[i] = (fealingCost[i] / fealingNumber[i]).toInt();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 400,
//           width: 500,
//           child: MoodLineChart(
//             fealingCost: fealingCost,
//             xAxisDates: xAxisDates,
//             // data: diaryController.diaries,
//           ),
//         ),
//       ],
//     );
//   }
// }
