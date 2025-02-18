import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/add_hosipital_visit_controller.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';

class VisitDayAndTime extends StatelessWidget {
  const VisitDayAndTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AddHosipitalVisitController>(builder: (controller) {
      return ColTextAndWidget(
        label: '일자',
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: controller.selectedDate == null
                        ? '방문 날짜'
                        : DateFormat(
                                "MM${AppString.month.tr} d${AppString.day.tr}")
                            .format(controller.selectedDate),
                    readOnly: true,
                    widget: IconButton(
                      onPressed: () => controller.onTapVisitDay(context),
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ),
                SizedBox(width: RS.w10 * 2),
                Expanded(
                  child: CustomTextFormField(
                    readOnly: true,
                    hintText: controller.startTime ?? '방문 시간',
                    widget: IconButton(
                      onPressed: () => controller.onTapVisitTime(context),
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: RS.h10 * 3),
            GestureDetector(
              onTap: controller.onTapEnrollAlarm,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '알람 등록',
                    style: controller.isEnrollAlarm
                        ? const TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.w600,
                          )
                        : const TextStyle(),
                  ),
                  SizedBox(width: RS.w10),
                  CircleAvatar(
                    backgroundColor: controller.isEnrollAlarm
                        ? Colors.pinkAccent
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
              SizedBox(height: RS.h10 * 4),
              Column(
                children: [
                  const Text('알람을 받을 시간을 선택해주세요!'),
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
                              text: '하루 전',
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
                              text: '6시간 전',
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
                              text: '1시간 전',
                              isActive: controller.isBeforeOneHourAlarm),
                        ),
                        GestureDetector(
                          onTap: () => controller.onTapBeforeAlramTime(context),
                          child: SelectBeforeAlarmTime(
                              width: size.width * .2,
                              text: controller.selectedBeforeAlram == null
                                  ? '선택'
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
        color: isActive ? Colors.pinkAccent : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: RS.w10 * 1.2,
            color: isActive ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
