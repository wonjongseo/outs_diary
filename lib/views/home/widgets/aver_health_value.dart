import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/views/home/widgets/circle_aver_health_widget.dart';

class AverHealthValue extends StatelessWidget {
  const AverHealthValue({super.key});

  @override
  Widget build(BuildContext context) {
    DiaryController diaryController = Get.find<DiaryController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (diaryController.selectedDiary!.health!.weights != null &&
                  diaryController.selectedDiary!.health!.avgWeight != 0)
                Tooltip(
                  message:
                      diaryController.selectedDiary!.health!.tooltipMsgWeight,
                  triggerMode: TooltipTriggerMode.tap,
                  child: CircleAverHealthWidget(
                    title: AppString.weight.tr,
                    averValue: diaryController.selectedDiary!.health!.avgWeight
                        .toString(),
                  ),
                ),
              if (diaryController.selectedDiary!.health!.temperatures != null &&
                  diaryController.selectedDiary!.health!.avgTemperature != 0)
                Tooltip(
                  message: diaryController
                      .selectedDiary!.health!.tooltipMsgTemperature,
                  triggerMode: TooltipTriggerMode.tap,
                  child: CircleAverHealthWidget(
                    title: AppString.temperature.tr,
                    averValue: diaryController
                        .selectedDiary!.health!.avgTemperature
                        .toString(),
                  ),
                ),
              if (diaryController.selectedDiary!.health!.pulses != null &&
                  diaryController.selectedDiary!.health!.avgPulse != 0)
                Tooltip(
                  message:
                      diaryController.selectedDiary!.health!.tooltipMsgPulse,
                  triggerMode: TooltipTriggerMode.tap,
                  child: CircleAverHealthWidget(
                    title: AppString.pulse.tr,
                    averValue: diaryController.selectedDiary!.health!.avgPulse
                        .toString(),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: RS.h10 * 1.5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (diaryController.selectedDiary!.health!.bloodPressures !=
                      null &&
                  diaryController.selectedDiary!.health!.avgMaxBloodPressure !=
                      0)
                Tooltip(
                  message: diaryController
                      .selectedDiary!.health!.tooltipMsgTemperature,
                  triggerMode: TooltipTriggerMode.tap,
                  child: CircleAverHealthWidget(
                    title: AppString.maxBloodPressure.tr,
                    averValue: diaryController
                        .selectedDiary!.health!.avgMinBloodPressure
                        .toString(),
                  ),
                ),
              if (diaryController.selectedDiary!.health!.bloodPressures !=
                      null &&
                  diaryController.selectedDiary!.health!.avgMaxBloodPressure !=
                      0)
                Tooltip(
                  message: diaryController
                      .selectedDiary!.health!.tooltipMsgTemperature,
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
  }
}
