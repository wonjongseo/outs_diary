import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/views/home/widgets/circle_aver_health_widget.dart';

class AverHealthValue extends StatelessWidget {
  const AverHealthValue({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiaryController>(builder: (diaryController) {
      DiaryModel diaryModel = diaryController.selectedDiary!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (diaryModel.health!.temperatures != null &&
                    diaryModel.health!.avgTemperature != 0)
                  Tooltip(
                    message: diaryModel.health!.tooltipMsgTemperature,
                    triggerMode: TooltipTriggerMode.tap,
                    child: CircleAverHealthWidget(
                      title: AppString.temperature.tr,
                      averValue: diaryController
                          .selectedDiary!.health!.avgTemperature
                          .toString(),
                    ),
                  ),
                if (diaryModel.health!.pulses != null &&
                    diaryModel.health!.avgPulse != 0)
                  Tooltip(
                    message: diaryModel.health!.tooltipMsgPulse,
                    triggerMode: TooltipTriggerMode.tap,
                    child: CircleAverHealthWidget(
                      title: AppString.pulse.tr,
                      averValue: diaryModel.health!.avgPulse.toString(),
                    ),
                  ),
                if (diaryModel.health!.weights != null &&
                    diaryModel.health!.avgWeight != 0)
                  CircleAverHealthWidget(
                    title: AppString.weight.tr,
                    averValue: diaryModel.health!.avgWeight.toString(),
                  ),
              ],
            ),
          ),
          SizedBox(height: 10 * 1.5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (diaryModel.health!.bloodPressures != null &&
                    diaryModel.health!.avgMaxBloodPressure != 0)
                  Tooltip(
                    message: diaryModel.health!.tooltipMsgMaxBloodPressure,
                    triggerMode: TooltipTriggerMode.tap,
                    child: CircleAverHealthWidget(
                      title: AppString.maxBloodPressure.tr,
                      averValue: diaryController
                          .selectedDiary!.health!.avgMaxBloodPressure
                          .toString(),
                    ),
                  ),
                if (diaryModel.health!.bloodPressures != null &&
                    diaryModel.health!.avgMaxBloodPressure != 0)
                  Tooltip(
                    message: diaryModel.health!.tooltipMsgMinBloodPressure,
                    triggerMode: TooltipTriggerMode.tap,
                    child: CircleAverHealthWidget(
                      title: AppString.minBloodPressure.tr,
                      averValue: diaryController
                          .selectedDiary!.health!.avgMinBloodPressure
                          .toString(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
