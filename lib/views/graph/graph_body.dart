import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/models/is_expandtion_type.dart';
import 'package:ours_log/common/theme/theme.dart';

import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/datas/graph_data.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/respository/dairy_respository.dart';
import 'package:ours_log/views/graph/widgets/custom_line_graph.dart';
import 'package:ours_log/views/graph/widgets/feal_graph.dart';

class GraphBody extends StatefulWidget {
  const GraphBody({super.key});

  @override
  State<GraphBody> createState() => _GraphBodyState();
}

class _GraphBodyState extends State<GraphBody> {
  DateTime now = DateTime.now();

  DiaryRepository diaryController = DiaryRepository();

  late GraphData? fealGraphData;
  late GraphData? painLevelGraphData;
  late GraphData? temperatureGraphData;
  late GraphData? weightGraphData;
  late GraphData? pulseGraphData;
  late GraphData? maxBloodPressureGraphData;
  late GraphData? minBloodPressureGraphData;

  late int countOfDay;

  @override
  void initState() {
    createGraphData(now);

    setState(() {});
    super.initState();
  }

  late List<DiaryModel> diarys;
  void createGraphData(DateTime dateTime) async {
    countOfDay = getDaysInMonth(now.year, now.month);

    fealGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );
    painLevelGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );
    temperatureGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );
    weightGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );
    pulseGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );
    maxBloodPressureGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );
    minBloodPressureGraphData = GraphData(
      xDatas: List.generate(countOfDay, (index) => 0),
    );

    diarys = await diaryController.loadDiariesInMonth(dateTime);

    for (var diary in diarys) {
      if (diary.health == null || diary.health?.temperatures == null) {
        continue;
      }
      if (diary.dateTime.year == now.year &&
          diary.dateTime.month == now.month) {
        fealGraphData!.xDatas[diary.dateTime.day - 1] =
            ((5 - diary.fealIndex)).toDouble();
        painLevelGraphData!.xDatas[diary.dateTime.day - 1] =
            diary.painfulIndex == null ? 0.0 : (diary.painfulIndex!).toDouble();
        temperatureGraphData!.xDatas[diary.dateTime.day - 1] =
            diary.health!.avgTemperature;
        weightGraphData!.xDatas[diary.dateTime.day - 1] =
            diary.health!.avgWeight;
        pulseGraphData!.xDatas[diary.dateTime.day - 1] = diary.health!.avgPulse;

        maxBloodPressureGraphData!.xDatas[diary.dateTime.day - 1] =
            diary.health!.avgMaxBloodPressure.toDouble();
        minBloodPressureGraphData!.xDatas[diary.dateTime.day - 1] =
            diary.health!.avgMinBloodPressure.toDouble();
      }
    }

    calculateMinMaxValueAndHeight(fealGraphData, max: 6);
    calculateMinMaxValueAndHeight(painLevelGraphData, max: 9);
    calculateMinMaxValueAndHeight(temperatureGraphData);
    calculateMinMaxValueAndHeight(weightGraphData);
    calculateMinMaxValueAndHeight(pulseGraphData);
    calculateMinMaxValueAndHeight(maxBloodPressureGraphData);
    calculateMinMaxValueAndHeight(minBloodPressureGraphData);

    setState(() {}); // dont' remove this
  }

  void calculateMinMaxValueAndHeight(GraphData? graphData, {double? max}) {
    if (max != null) {
      graphData!.maxY = max;
      graphData.minY = 0;
    } else {
      double? maxY =
          graphData!.xDatas.where((element) => element != 0).firstOrNull;
      double? minY =
          graphData.xDatas.where((element) => element != 0).firstOrNull;

      if (maxY == null || minY == null) {
        graphData = null;
        return;
      }

      for (var value in graphData.xDatas) {
        if (value == 0) continue;

        if (minY! > value) minY = value;

        if (maxY! < value) maxY = value;
      }

      double diff = maxY! - minY!;

      minY = (minY - diff).round().toDouble();
      maxY = (maxY + diff).round().toDouble();

      if (maxY == minY) {
        maxY += 1;
        minY -= 1;
      }
      if (maxY < 0) maxY = 0;
      if (minY < 0) minY = 0;
      graphData.maxY = maxY;
      graphData.minY = minY;
    }
  }

  @override
  Widget build(BuildContext context) {
    log('GraphBody');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(DateFormat('yyy${AppString.year.tr}').format(now),
                style: boldStyle),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      now = DateTime(now.year, now.month - 1);
                      createGraphData(now);
                      setState(() {});
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                Text(
                  DateFormat('M${AppString.month.tr}').format(now),
                  style: boldStyle,
                ),
                IconButton(
                    onPressed: () {
                      now = DateTime(now.year, now.month + 1);
                      createGraphData(now);
                      setState(() {});
                    },
                    icon: const Icon(Icons.arrow_forward_ios)),
              ],
            ),
          ],
        ),
        GetBuilder<UserController>(builder: (userController) {
          return Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: RS.w10),
                child: Column(
                  children: [
                    _fealGraph(userController),
                    SizedBox(height: RS.h10),
                    // _painLevel(userController),
                    // SizedBox(height: RS.h10),
                    _weight(userController),
                    SizedBox(height: RS.h10),
                    _temperature(userController),
                    SizedBox(height: RS.h10),
                    _pulse(userController),
                    SizedBox(height: RS.h10),
                    _bloodPressure(userController),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  CustomExpansionCard _bloodPressure(UserController userController) {
    return CustomExpansionCard(
      initiallyExpanded: userController.userModel!.userUtilModel
          .expandedFields[IsExpandtionType.bloodPressureGraph],
      onExpansionChanged: (bool v) =>
          userController.toggleExpanded(IsExpandtionType.bloodPressureGraph),
      title: AppString.bloodPressure.tr,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: RS.h10,
          horizontal: RS.w10 * 2,
        ),
        child: maxBloodPressureGraphData == null
            ? Container()
            : CustomLineGraph(
                graphData: maxBloodPressureGraphData!,
                graphData2: minBloodPressureGraphData,
                countOfDay: countOfDay,
              ),
      ),
    );
  }

  CustomExpansionCard _pulse(UserController userController) {
    return CustomExpansionCard(
      initiallyExpanded: userController
          .userModel!.userUtilModel.expandedFields[IsExpandtionType.pulseGraph],
      onExpansionChanged: (bool v) =>
          userController.toggleExpanded(IsExpandtionType.pulseGraph),
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
    );
  }

  CustomExpansionCard _temperature(UserController userController) {
    return CustomExpansionCard(
      initiallyExpanded: userController.userModel!.userUtilModel
          .expandedFields[IsExpandtionType.temperatureGraph],
      onExpansionChanged: (bool v) =>
          userController.toggleExpanded(IsExpandtionType.temperatureGraph),
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
    );
  }

  CustomExpansionCard _weight(UserController userController) {
    return CustomExpansionCard(
      title: AppString.weight.tr,
      initiallyExpanded: userController.userModel!.userUtilModel
          .expandedFields[IsExpandtionType.weightGraph],
      onExpansionChanged: (bool v) =>
          userController.toggleExpanded(IsExpandtionType.weightGraph),
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
    );
  }

  CustomExpansionCard _painLevel(UserController userController) {
    return CustomExpansionCard(
      title: AppString.painLevel.tr,
      initiallyExpanded: userController.userModel!.userUtilModel
          .expandedFields[IsExpandtionType.painLevelGraph],
      onExpansionChanged: (bool v) =>
          userController.toggleExpanded(IsExpandtionType.painLevelGraph),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: RS.h10,
          horizontal: RS.w10 * 2,
        ),
        child: painLevelGraphData == null
            ? Container()
            : CustomLineGraph(
                graphData: painLevelGraphData!,
                countOfDay: countOfDay,
              ),
      ),
    );
  }

  CustomExpansionCard _fealGraph(UserController userController) {
    return CustomExpansionCard(
      initiallyExpanded: userController
          .userModel!.userUtilModel.expandedFields[IsExpandtionType.fealGraph],
      onExpansionChanged: (bool v) =>
          userController.toggleExpanded(IsExpandtionType.fealGraph),
      title: AppString.fealText.tr,
      child: Padding(
        padding: EdgeInsets.only(right: RS.w10 * 2),
        child: fealGraphData == null
            ? Container()
            : FealGraph(
                graphData: fealGraphData!,
                countOfDay: countOfDay,
              ),
      ),
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
