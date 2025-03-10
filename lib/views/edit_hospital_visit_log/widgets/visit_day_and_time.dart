import 'package:animate_do/animate_do.dart';
import 'package:ours_log/common/enums/before_alram_time.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/edit_hosipital_visit_controller.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';

class VisitDayAndTime extends StatelessWidget {
  const VisitDayAndTime({super.key, required this.isEdit});

  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<EditHosipitalVisitController>(builder: (cn) {
      return ColTextAndWidget(
        label: AppString.days.tr,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _DayAndTimeSelector(cn, context),
            SizedBox(height: 10 * 3),
            GestureDetector(
              onTap: isEdit ? cn.onTapEnrollAlarm : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppString.enrollAlarm.tr,
                    style: cn.isEnrollAlarm
                        ? TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          )
                        : const TextStyle(),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor:
                        cn.isEnrollAlarm ? AppColors.primaryColor : Colors.grey,
                    radius: 10 * 1.2,
                    child: Icon(
                      Icons.done,
                      size: 10 * 1.5,
                      color: cn.isEnrollAlarm ? Colors.white : null,
                    ),
                  )
                ],
              ),
            ),
            if (cn.isEnrollAlarm) ...[
              SizedBox(height: 10 * 2),
              Column(
                children: [
                  FadeInRight(child: Text(AppString.plzSelectAlarmTime.tr)),
                  SizedBox(height: 10 * 2),
                  FadeInRight(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            BeforeAlarmTimeType.values.length, (index) {
                          return GestureDetector(
                            onTap: isEdit
                                ? () => cn.selectAlram(context, index)
                                : null,
                            child: SelectBeforeAlarmTime(
                              width: size.width * .2,
                              text: cn.getAlramText(index),
                              isActive: cn.beforeAlarmTypes[index].isChecked,
                            ),
                          );
                        }),
                      ),
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
      EditHosipitalVisitController cn, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            hintText: cn.selectedDate == null
                ? AppString.visitDay.tr
                : isEn
                    ? DateFormat.MEd().format(cn.selectedDate)
                    : DateFormat(
                            "MM${AppString.month.tr} d${AppString.dayText.tr}")
                        .format(cn.selectedDate),
            readOnly: true,
            widget: IconButton(
              onPressed: isEdit ? () => cn.onTapVisitDay(context) : null,
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        SizedBox(width: 10 * 2),
        Expanded(
          child: CustomTextFormField(
            readOnly: true,
            hintText: cn.startTime ?? AppString.visitTime.tr,
            widget: IconButton(
              onPressed: isEdit ? () => cn.onTapVisitTime(context) : null,
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
      height: 10 * 4,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: isActive ? null : Border.all(color: Colors.grey),
        color: isActive ? AppColors.primaryColor : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 10 * 1.2,
              color: Get.isDarkMode
                  ? textWhiteOrBlack
                  : isActive
                      ? textBlackOrWhite
                      : textWhiteOrBlack
              // color: isActive ? textBlackOrWhite : textWhiteOrBlack,
              ),
        ),
      ),
    );
  }
}
