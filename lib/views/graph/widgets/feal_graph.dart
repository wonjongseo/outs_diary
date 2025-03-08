import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/datas/graph_data.dart';
import 'package:ours_log/models/is_expandtion_type.dart';
import 'package:ours_log/views/graph/widgets/custom_feal_line_graph.dart';
import 'package:ours_log/views/graph/widgets/custom_feal_pie_chart.dart';

class FealGraph extends StatefulWidget {
  const FealGraph({
    super.key,
    required this.graphData,
    required this.countOfDay,
  });
  final GraphData graphData;
  final int countOfDay;
  @override
  State<FealGraph> createState() => _FealGraphState();
}

class _FealGraphState extends State<FealGraph> {
  int pageIndex = 0;
  late PageController pageController;

  UserController userController = Get.find<UserController>();
  @override
  void initState() {
    if (userController.userModel!.userUtilModel
            .expandedFields[IsExpandtionType.isFealLineGraphFirst] ??
        true) {
      pageIndex = 0;
    } else {
      pageIndex = 1;
    }

    pageController = PageController(initialPage: pageIndex);
    super.initState();
  }

  void onToggleGraph() {
    if (pageIndex == 0) {
      pageIndex = 1;
    } else {
      pageIndex = 0;
    }
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    userController.toggleExpanded(IsExpandtionType.isFealLineGraphFirst);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggleGraph,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (pageIndex == 1) const Icon(Icons.keyboard_arrow_left),
                  Text(pageIndex == 0
                      ? AppString.circularGraph.tr
                      : AppString.linearGraph.tr),
                  if (pageIndex == 0) const Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CustomFealLineGraph(
                      countOfDay: widget.countOfDay,
                      graphData: widget.graphData);
                } else {
                  return CustomFealPieChart(
                      graphData: widget.graphData,
                      countOfDay: widget.countOfDay);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
