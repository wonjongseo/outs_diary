import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/light_theme.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/background_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/respository/monthly_repository.dart';
import 'package:ours_log/views/home/bodys/selected_dairy.dart';

import 'package:table_calendar/table_calendar.dart';

class DiaryBody extends StatefulWidget {
  DiaryBody({super.key});

  @override
  State<DiaryBody> createState() => _DiaryBodyState();
}

class _DiaryBodyState extends State<DiaryBody> {
  final DiaryController diaryController = Get.find<DiaryController>();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('yyy${AppString.year.tr} M${AppString.month.tr}')
                        .format(controller.focusedDay),
                    style: boldStyle,
                  ),
                  Text('생리')
                ],
              ),
              SizedBox(height: RS.h10 * 1.2),
              TableCalendar(
                rangeStartDay: controller.peroidStartDay,
                rangeEndDay: controller.peroidEndDay,
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
                  rangeHighlightBuilder: (context, day, isWithinRange) {
                    if (isWithinRange) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: RS.h10 * 1.5,
                        ),
                        child: Text(
                          '생리',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      );
                    }
                  },
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

  Widget? prioritizedBuilder(context, day, focusedDay) {
    bool isNextDay = diaryController.now.difference(day).isNegative;
    return Column(
      children: [
        Container(
          height: RS.w10 * 4.5,
          width: RS.w10 * 4.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isNextDay
                ? Colors.grey.withOpacity(.15)
                : Colors.grey.withOpacity(.4),
          ),
          margin: EdgeInsets.only(bottom: RS.h10 / 2),
        ),
        Text(
          '${day.day}',
          style: TextStyle(
            color: isNextDay ? Colors.grey.withOpacity(.6) : null,
          ),
        )
      ],
    );
  }

  Widget? singleMarkerBuilder(context, day, event) {
    BackgroundController backgroundController =
        Get.find<BackgroundController>();

    if (diaryController.kEvents[day] != null) {
      DiaryModel diaryModel = diaryController.kEvents[day]![0];

      return Column(
        children: [
          CircleAvatar(
            // backgroundColor: Colors.white.withValues(alpha: .5),
            // foregroundImage: AssetImage(diaryModel.getFealImage),
            foregroundImage: AssetImage(
              backgroundController.iconImagePaths[diaryModel.fealIndex],
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
