import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/light_theme.dart';

import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/datas/graph_data.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/views/graph/weight_graph.dart';

class GraphBody extends StatefulWidget {
  const GraphBody({super.key});

  @override
  State<GraphBody> createState() => _GraphBodyState();
}

class _GraphBodyState extends State<GraphBody> {
  DateTime now = DateTime.now();

  DiaryController diaryController = Get.find<DiaryController>();

  late GraphData? temperatureGraphData;
  late GraphData? weightGraphData;
  late GraphData? pulseGraphData;

  late int countOfDay;

  @override
  void initState() {
    countOfDay = getDaysInMonth(now.year, now.month);

    temperatureGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );
    weightGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );
    pulseGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );
    createGraphData(); // dont't swap to calculateMinMaxValueAndHeight method;

    calculateMinMaxValueAndHeight(temperatureGraphData);
    calculateMinMaxValueAndHeight(weightGraphData);
    calculateMinMaxValueAndHeight(pulseGraphData);

    setState(() {});
    super.initState();
  }

  void createGraphData() {
    List<DiaryModel> diarys = diaryController.diaries;
    for (var diary in diarys) {
      if (diary.health == null || diary.health?.temperatures == null) {
        continue;
      }
      if (diary.dateTime.year == now.year &&
          diary.dateTime.month == now.month) {
        temperatureGraphData!.xDatas[diary.dateTime.day - 1] =
            diary.health!.avgTemperature;
        weightGraphData!.xDatas[diary.dateTime.day - 1] =
            diary.health!.avgWeight;
        pulseGraphData!.xDatas[diary.dateTime.day - 1] = diary.health!.avgPulse;
      }
    }
  }

  void calculateMinMaxValueAndHeight(GraphData? temperature) {
    double? maxY =
        temperature!.xDatas.where((element) => element != 0).firstOrNull;
    double? minY =
        temperature.xDatas.where((element) => element != 0).firstOrNull;

    if (maxY == null || minY == null) {
      temperature = null;
      return;
    }

    for (var value in temperature.xDatas) {
      if (value == 0) continue;

      if (minY! > value) {
        minY = value;
      }
      if (maxY! < value) {
        maxY = value;
      }
    }

    double diff = maxY! - minY!;

    minY = (minY - diff).round().toDouble();
    maxY = (maxY + diff).round().toDouble();

    temperature.maxY = maxY;
    temperature.minY = minY;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: RS.w10, bottom: RS.h10),
            child: Text(
              DateFormat('yyy${AppString.year.tr} M${AppString.month.tr}')
                  .format(now),
              style: boldStyle,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.w10),
              child: Column(
                children: [
                  CustomExpansionCard(
                    title: AppString.temperature.tr,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: RS.h10,
                        horizontal: RS.w10 * 2,
                      ),
                      child: temperatureGraphData == null
                          ? Container()
                          : CustomLineGraph(
                              graphData: temperatureGraphData!,
                              countOfDay: countOfDay,
                            ),
                    ),
                  ),
                  SizedBox(height: RS.h10),
                  CustomExpansionCard(
                    title: AppString.weight.tr,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: RS.h10,
                        horizontal: RS.w10 * 2,
                      ),
                      child: weightGraphData == null
                          ? Container()
                          : CustomLineGraph(
                              graphData: weightGraphData!,
                              countOfDay: countOfDay,
                            ),
                    ),
                  ),
                  SizedBox(height: RS.h10),
                  CustomExpansionCard(
                    title: AppString.pulse.tr,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: RS.h10,
                        horizontal: RS.w10 * 2,
                      ),
                      child: pulseGraphData == null
                          ? Container()
                          : CustomLineGraph(
                              graphData: pulseGraphData!,
                              countOfDay: countOfDay,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
