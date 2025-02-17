import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/views/home/bodys/selected_dairy.dart';

import 'package:table_calendar/table_calendar.dart';

class DiaryBody extends StatefulWidget {
  DiaryBody({super.key});

  @override
  State<DiaryBody> createState() => _DiaryBodyState();
}

class _DiaryBodyState extends State<DiaryBody> {
  final DiaryController diaryController = Get.find<DiaryController>();
  final UserController userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.w10 * 2),
      child: GetBuilder<DiaryController>(builder: (controller) {
        return SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                DateFormat('yyy${AppString.year.tr} M${AppString.month.tr}')
                    .format(controller.focusedDay),
                style: boldStyle,
              ),
              SizedBox(height: RS.h10 * 1.2),
              TableCalendar(
                availableGestures: AvailableGestures.horizontalSwipe,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: weekdayStyle,
                  weekendStyle: weekdayStyle,
                ),
                locale: isKo ? 'ko' : 'ja',
                daysOfWeekHeight: RS.h10 * 3,
                headerVisible: false,
                onPageChanged: diaryController.onPageChanged,
                calendarStyle: CalendarStyle(
                  rangeHighlightColor: Colors.redAccent.withValues(alpha: .5),
                  outsideDaysVisible: false,
                  markersAutoAligned: false,
                  cellAlignment: Alignment.center,
                ),
                calendarBuilders: CalendarBuilders(
                  singleMarkerBuilder: singleMarkerBuilder,
                  prioritizedBuilder: prioritizedBuilder,
                ),
                firstDay: diaryController.now.subtract(
                  const Duration(days: 365 * 3),
                ),
                lastDay: diaryController.now.add(const Duration(days: 30)),
                focusedDay: diaryController.focusedDay,
                eventLoader: diaryController.getEventsForDay,
                rowHeight: RS.h10 * 10.4,
                onDaySelected: controller.onDatSelected,
              ),
              if (diaryController.selectedDiary != null)
                SelectedDiary(diaryController: diaryController)
            ],
          ),
        );
      }),
    );
  }

  Widget? prioritizedBuilder(context, DateTime day, focusedDay) {
    bool isNextDay = diaryController.now.difference(day).isNegative;
    bool isToday = AppFunction.isSameDay(diaryController.now, day);
    bool isMustPill = false;
    // if (isToday) {
    if (userController.selectedDays.contains(day.weekday - 1)) {
      isMustPill = true;
      // }
    }

    return Column(
      children: [
        Container(
          height: RS.w10 * 4.5,
          width: RS.w10 * 4.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isToday
                ? Border.all(color: Colors.pinkAccent.withValues(alpha: .5))
                : null,
            color: isToday
                ? Colors.pinkAccent.withValues(alpha: .5)
                : isNextDay
                    ? Colors.grey.withOpacity(.15)
                    : Colors.grey.withOpacity(.4),
          ),
          margin: EdgeInsets.only(bottom: RS.h10 / 2),
        ),
        Text(
          '${day.day}',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isNextDay ? Colors.grey.withOpacity(.6) : null,
          ),
        ),
        if (isMustPill) ...[
          Image.asset(
            AppImagePath.medition1,
            width: RS.w10 * 2.5,
          ),
        ]
      ],
    );
  }

  Widget? singleMarkerBuilder(context, day, event) {
    UserController backgroundController = Get.find<UserController>();
    bool isToday = AppFunction.isSameDay(diaryController.now, day);

    if (diaryController.kEvents[day] != null) {
      DiaryModel diaryModel = diaryController.kEvents[day]![0];

      return Column(
        children: [
          CircleAvatar(
            backgroundColor: isToday ? Colors.pinkAccent : AppColors.white,
            foregroundImage: AssetImage(
              backgroundController.feals[diaryModel.fealIndex],
            ),
            radius: RS.w10 * 2.5,
          ),
          Text('${day.day}')
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
