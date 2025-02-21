import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/edit_hosipital_visit_controller.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';

class VisitDayAndTime extends StatelessWidget {
  const VisitDayAndTime({
    super.key,
    required this.isEdit,
  });

  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<EditHosipitalVisitController>(builder: (controller) {
      return ColTextAndWidget(
        label: AppString.days.tr,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _DayAndTimeSelector(controller, context),
            SizedBox(height: RS.h10 * 3),
            GestureDetector(
              onTap: controller.onTapEnrollAlarm,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppString.enrollAlarm.tr,
                    style: controller.isEnrollAlarm
                        ? TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          )
                        : const TextStyle(),
                  ),
                  SizedBox(width: RS.w10),
                  CircleAvatar(
                    backgroundColor: controller.isEnrollAlarm
                        ? AppColors.primaryColor
                        : Colors.grey,
                    radius: RS.w10 * 1.2,
                    child: Icon(
                      Icons.done,
                      size: RS.w10 * 1.5,
                      color: controller.isEnrollAlarm ? Colors.white : null,
                    ),
                  )
                ],
              ),
            ),
            if (controller.isEnrollAlarm) ...[
              SizedBox(height: RS.h10 * 2),
              Column(
                children: [
                  Text(AppString.plzSelectAlarmTime.tr),
                  SizedBox(height: RS.h10 * 2),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.isBeforeOneDayAlarm =
                                !controller.isBeforeOneDayAlarm;
                            controller.update();
                          },
                          child: SelectBeforeAlarmTime(
                              width: size.width * .2,
                              text: '1${AppString.beforeDay.tr}',
                              isActive: controller.isBeforeOneDayAlarm),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.isBeforeSizHourAlarm =
                                !controller.isBeforeSizHourAlarm;
                            controller.update();
                          },
                          child: SelectBeforeAlarmTime(
                              width: size.width * .2,
                              text: '6${AppString.beforeHour.tr}',
                              isActive: controller.isBeforeSizHourAlarm),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.isBeforeOneHourAlarm =
                                !controller.isBeforeOneHourAlarm;
                            controller.update();
                          },
                          child: SelectBeforeAlarmTime(
                              width: size.width * .2,
                              text: '1${AppString.beforeHour.tr}',
                              isActive: controller.isBeforeOneHourAlarm),
                        ),
                        GestureDetector(
                          onTap: () => controller.onTapBeforeAlramTime(context),
                          child: SelectBeforeAlarmTime(
                              width: size.width * .2,
                              text: controller.selectedBeforeAlram == null
                                  ? AppString.selectText.tr
                                  : '${controller.selectedBeforeAlram!} 전',
                              isActive: controller.selectedBeforeAlram == null
                                  ? false
                                  : true),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]
          ],
        ),
      );
    });
  }

  Row _DayAndTimeSelector(
      EditHosipitalVisitController controller, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            hintText: controller.selectedDate == null
                ? AppString.visitDay.tr
                : DateFormat("MM${AppString.month.tr} d${AppString.day.tr}")
                    .format(controller.selectedDate),
            readOnly: true,
            widget: IconButton(
              onPressed:
                  isEdit ? () => controller.onTapVisitDay(context) : null,
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        SizedBox(width: RS.w10 * 2),
        Expanded(
          child: CustomTextFormField(
            readOnly: true,
            hintText: controller.startTime ?? AppString.visitTime.tr,
            widget: IconButton(
              onPressed:
                  isEdit ? () => controller.onTapVisitTime(context) : null,
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
      ],
    );
  }
}

class SelectBeforeAlarmTime extends StatelessWidget {
  const SelectBeforeAlarmTime({
    super.key,
    required this.width,
    required this.text,
    required this.isActive,
  });

  final double width;
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: RS.w10 * 4,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: RS.w10 / 2),
      decoration: BoxDecoration(
        border: isActive ? null : Border.all(color: Colors.grey),
        color: isActive ? AppColors.primaryColor : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: RS.w10 * 1.2,
            color: textWhiteOrBlack,
          ),
        ),
      ),
    );
  }
}
