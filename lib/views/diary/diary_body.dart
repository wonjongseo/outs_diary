import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';

import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:ours_log/views/home/widgets/selected_dairy.dart';

import 'package:table_calendar/table_calendar.dart';

class DiaryBody extends StatelessWidget {
  DiaryBody({super.key});

  final DiaryController diaryController = Get.find<DiaryController>();
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    log('DiaryBody');
    return GetBuilder<DiaryController>(builder: (controller) {
      return SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Text(
                    DateFormat.yMMM(Get.locale.toString())
                        .format(controller.focusedDay),
                    style: boldStyle,
                  ),
                  const SizedBox(height: 12),
                  _tableCalendar(controller),
                ],
              ),
            ),
            if (diaryController.selectedDiary != null)
              SelectedDiary(), // Dont' Const
            const SizedBox(height: 20)
          ],
        ),
      );
    });
  }

  TableCalendar<dynamic> _tableCalendar(DiaryController controller) {
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: weekdayStyle,
        weekendStyle: weekdayStyle,
      ),
      locale: Get.locale.toString(),
      daysOfWeekHeight: 30,
      headerVisible: false,
      onPageChanged: diaryController.onPageChanged,
      calendarStyle: CalendarStyle(
        markersAnchor: 1,
        rangeHighlightColor: Colors.redAccent.withValues(alpha: .5),
        outsideDaysVisible: false,
        markersAutoAligned: false,
        cellAlignment: Alignment.center,
      ),
      calendarBuilders: CalendarBuilders(
        singleMarkerBuilder: singleMarkerBuilder,
        prioritizedBuilder: prioritizedBuilder,
      ),
      firstDay: diaryController.now.subtract(const Duration(days: 365 * 5)),
      lastDay: diaryController.now.add(const Duration(days: 30)),
      focusedDay: diaryController.focusedDay,
      eventLoader: diaryController.getEventsForDay,
      rowHeight: 10 * 10.4,
      onDaySelected: controller.onDatSelected,
    );
  }

  Widget? prioritizedBuilder(context, DateTime day, focusedDay) {
    bool isNextDay = AppFunction.isNextDay(diaryController.now, day);
    bool isToday = AppFunction.isSameDay(diaryController.now, day);

    bool isMustPill = false;

    List<WeekDayType>? selectedPillDays =
        userController.userModel!.selectedPillDays;

    if (isToday) {
      if (selectedPillDays != null && selectedPillDays.isNotEmpty) {
        if (selectedPillDays.contains(WeekDayType.values[day.weekday - 1])) {
          isMustPill = true;
        }
      }
    }

    return Column(
      children: [
        Container(
          height: 10 * 4.5,
          width: 10 * 4.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isNextDay
                ? Colors.grey.withValues(alpha: .15)
                : Colors.grey.withValues(alpha: .4),
          ),
          margin: const EdgeInsets.only(bottom: 5),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isToday ? AppColors.primaryColor : null,
          ),
          child: Text(
            '${day.day}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isToday
                  ? Colors.white
                  : isNextDay
                      ? Colors.grey.withValues(alpha: .6)
                      : null,
            ),
          ),
        ),
        if (isMustPill) ...[
          Image.asset(
            AppImagePath.medition1,
            width: 10 * 2.5,
          ),
        ]
      ],
    );
  }

  Widget? singleMarkerBuilder(context, day, event) {
    UserController backgroundController = Get.find<UserController>();

    if (diaryController.kEvents[day] != null) {
      DiaryModel diaryModel = diaryController.kEvents[day]![0];

      return Column(
        children: [
          CircleAvatar(
            radius: 23, // TODO FIX HARD CODING
            backgroundColor: diaryController.selectedDay == day
                ? AppColors.primaryColor
                : Get.isDarkMode
                    ? AppColors.black
                    : AppColors.white,
            foregroundImage: AssetImage(
              AppConstant
                  .fealIconLists[
                      backgroundController.userModel?.fealIconIndex ?? 0]
                  .iconPath[diaryModel.fealIndex],
            ),
          ),
        ],
      );
    }
    return null;
  }

  BoxDecoration dayDecoration() {
    return BoxDecoration(
      color: Colors.grey.withOpacity(.3),
      shape: BoxShape.circle,
    );
  }
}
