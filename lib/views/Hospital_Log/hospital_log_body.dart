import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';

import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/views/edit_hospital_visit_log/edit_hospital_visit_log_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class HospitalLogBody extends StatelessWidget {
  const HospitalLogBody({super.key});

  @override
  Widget build(BuildContext context) {
    log('HospitalLogBody');
    return GetBuilder<HospitalLogController>(builder: (hospitalLogController) {
      return SingleChildScrollView(
        controller: hospitalLogController.scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * 1.5),
              child: Column(
                children: [
                  Text(
                    DateFormat.yMMM(Get.locale.toString())
                        .format(hospitalLogController.focusedDay),
                    style: boldStyle,
                  ),
                  SizedBox(height: 10 * 1.2),
                  _tableCalendar(hospitalLogController),
                ],
              ),
            ),
            ValueListenableBuilder<List<HospitalLogModel>>(
              valueListenable: hospitalLogController.selectedEvents,
              builder: (context, value, _) {
                return Column(
                  children: List.generate(value.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (index == 0)
                          GestureDetector(
                            onTap: () {
                              Get.to(() => EditHospitalVisitLogScreen(
                                  selectedDate:
                                      hospitalLogController.selectedDay!));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              margin: EdgeInsets.only(
                                right: 10 * 2,
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        GestureDetector(
                          onTap: () => Get.to(
                            () => EditHospitalVisitLogScreen(
                              selectedDate: value[index].dateTime,
                              hospitalLogModel: value[index],
                            ),
                          ),
                          child:
                              SelectedVisitHospital(hospitalLog: value[index]),
                        ),
                      ],
                    );
                  }),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  TableCalendar<Object?> _tableCalendar(
      HospitalLogController hospitalLogController) {
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: weekdayStyle,
        weekendStyle: weekdayStyle,
      ),
      locale: Get.locale.toString(),
      daysOfWeekHeight: 10 * 3,
      headerVisible: false,
      onPageChanged: hospitalLogController.onChageCalendar,
      calendarStyle: CalendarStyle(
        markersAnchor: 1,
        defaultTextStyle: weekdayStyle,
        cellAlignment: Alignment.center,
        outsideDaysVisible: false,
        markersAutoAligned: false,
        weekendTextStyle: weekdayStyle,
      ),
      pageJumpingEnabled: false,
      pageAnimationEnabled: false,
      firstDay: kFirstDay,
      lastDay: kLastDay,
      calendarBuilders: CalendarBuilders(
        prioritizedBuilder: (context, day, focusedDay) =>
            prioritizedBuilder(context, day, focusedDay, hospitalLogController),
        markerBuilder: (context, day, event) {
          if (event.isEmpty) return null;
          return Column(
            children: [
              CircleAvatar(
                backgroundColor: hospitalLogController.selectedDay == day
                    ? AppColors.primaryColor
                    : Get.isDarkMode
                        ? AppColors.black
                        : AppColors.white,
                foregroundImage: AssetImage(
                  AppImagePath.hospital,
                ),
                radius: 10 * 2.5,
              ),
            ],
          );
        },
      ),
      focusedDay: hospitalLogController.focusedDay,
      selectedDayPredicate: (day) =>
          isSameDay(hospitalLogController.selectedDay, day),
      eventLoader: hospitalLogController.getEventsForDay,
      rowHeight: 10 * 9.4,
      onDaySelected: hospitalLogController.onDaySelected,
    );
  }

  Widget? prioritizedBuilder(context, DateTime day, focusedDay,
      HospitalLogController hospitalLogController) {
    bool isNextDay = AppFunction.isNextDay(hospitalLogController.now, day);
    bool isToday = AppFunction.isSameDay(hospitalLogController.now, day);

    bool isMustPill = false;

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
          margin: EdgeInsets.only(bottom: 5),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10 * .6),
          margin: EdgeInsets.only(bottom: 10 * .4),
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

  // Widget? singleMarkerBuilder(context, day, event) {
  //   UserController backgroundController = Get.find<UserController>();
  //   bool isToday = AppFunction.isSameDay(diaryController.now, day);

  //   if (diaryController.kEvents[day] != null) {
  //     DiaryModel diaryModel = diaryController.kEvents[day]![0];

  //     return Column(
  //       children: [
  //         CircleAvatar(
  //           backgroundColor: diaryController.selectedDay == day
  //               ? AppColors.primaryColor
  //               : Get.isDarkMode
  //                   ? AppColors.black
  //                   : AppColors.white,
  //           foregroundImage: AssetImage(
  //             AppConstant
  //                 .fealIconLists[
  //                     backgroundController.userModel?.fealIconIndex ?? 0]
  //                 .iconPath[diaryModel.fealIndex],
  //           ),
  //           radius: 10 * 2.5,
  //         ),
  //       ],
  //     );
  //   }
  //   return null;
  // }

  BoxDecoration dayDecoration() {
    return BoxDecoration(
      color: Colors.grey.withOpacity(.3),
      shape: BoxShape.circle,
    );
  }
}

class SelectedVisitHospital extends StatelessWidget {
  const SelectedVisitHospital({
    super.key,
    required this.hospitalLog,
  });

  final HospitalLogModel hospitalLog;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10 * 1.2).copyWith(
        bottom: 10 * 1.5,
      ),
      padding: EdgeInsets.all(10 * 1.2),
      decoration: BoxDecoration(
        color: boxBlackOrWhite,
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hospitalLog.hospitalName),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded),
                      SizedBox(width: 5),
                      Text(hospitalLog.startTime ?? ''),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ],
      ),
    );
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
// final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kFirstDay = kToday.subtract(
  const Duration(days: 365 * 3),
);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

List<HospitalLogModel> dummyHospitalLogModels = [
  HospitalLogModel(
      dateTime: kToday,
      hospitalName: "hospitalName1",
      startTime: '18:65',
      imagesPath: []),
  HospitalLogModel(
      dateTime: kToday,
      hospitalName: "hospitalName4",
      startTime: '15:65',
      imagesPath: []),
  HospitalLogModel(
      dateTime: DateTime(kToday.year, kToday.month, kToday.day - 1),
      hospitalName: "hospitalName2",
      startTime: '18:65',
      imagesPath: []),
  HospitalLogModel(
      dateTime: DateTime(kToday.year, kToday.month, kToday.day - 2),
      hospitalName: "hospitalName3",
      startTime: '18:65',
      imagesPath: []),
];
