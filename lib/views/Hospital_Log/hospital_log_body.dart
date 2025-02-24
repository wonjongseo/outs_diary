import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/responsive.dart';
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
              padding: EdgeInsets.symmetric(horizontal: RS.w10 * 1.5),
              child: Column(
                children: [
                  Text(
                    DateFormat.yMMM(Get.locale.toString())
                        .format(hospitalLogController.focusedDay),
                    style: boldStyle,
                  ),
                  SizedBox(height: RS.h10 * 1.2),
                  TableCalendar(
                    availableGestures: AvailableGestures.horizontalSwipe,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: weekdayStyle,
                      weekendStyle: weekdayStyle,
                    ),
                    pageJumpingEnabled: false,
                    pageAnimationEnabled: false,
                    locale: isKo ? 'ko' : 'ja',
                    daysOfWeekHeight: RS.h10 * 3,
                    headerVisible: false,
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    onPageChanged: hospitalLogController.onChageCalendar,
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, event) {
                        if (event.isEmpty) return null;

                        return FaIcon(
                          FontAwesomeIcons.hospital,
                          color: AppColors.primaryColor,
                          size: RS.w10 * 1.6,
                        );
                      },
                    ),
                    calendarStyle: CalendarStyle(
                      markersAnchor: 1,
                      defaultTextStyle: weekdayStyle,
                      weekendTextStyle: weekdayStyle,
                      withinRangeDecoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                      ),
                    ),
                    focusedDay: hospitalLogController.focusedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(hospitalLogController.selectedDay, day),
                    eventLoader: hospitalLogController.getEventsForDay,
                    rowHeight: RS.h10 * 7,
                    onDaySelected: hospitalLogController.onDaySelected,
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
            ValueListenableBuilder<List<HospitalLogModel>>(
              valueListenable: hospitalLogController.selectedEvents,
              builder: (context, value, _) {
                return Column(
                  children: List.generate(value.length, (index) {
                    return Column(
                      children: [
                        if (index == 0)
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                Get.to(() => EditHospitalVisitLogScreen(
                                    selectedDate:
                                        hospitalLogController.selectedDay!));
                              },
                              icon: const FaIcon(FontAwesomeIcons.add),
                            ),
                          ),
                        GestureDetector(
                          onTap: () => Get.to(
                            () => EditHospitalVisitLogScreen(
                              selectedDate: value[index].dateTime,
                              hospitalLogModel: value[index],
                            ),
                          ),
                          child: SelectedVisitHospital(
                            hospitalLog: value[index],
                            // onTapDelete: () =>
                            //     hospitalLogController.delete(value[index]),
                          ),
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
}

class SelectedVisitHospital extends StatelessWidget {
  const SelectedVisitHospital({
    super.key,
    required this.hospitalLog,
    // required this.onTapDelete,
  });

  final HospitalLogModel hospitalLog;
  // final Function() onTapDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: RS.w10 * 1.2).copyWith(
        bottom: RS.h10 * 1.5,
      ),
      padding: EdgeInsets.all(RS.w10 * 1.2),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
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
                  SizedBox(height: RS.h5),
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded),
                      SizedBox(width: RS.w5),
                      Text(hospitalLog.startTime ?? ''),
                    ],
                  ),
                ],
              ),
              Icon(Icons.keyboard_arrow_right)
              // IconButton(
              //   onPressed: onTapDelete,
              //   icon: const Icon(
              //     FontAwesomeIcons.trashCan,
              //   ),
              // )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     IconButton(
              //         onPressed: () {
              //           Get.to(
              //             () => EditHospitalVisitLogScreen(
              //               selectedDate: hospitalLog.dateTime,
              //               hospitalLogModel: hospitalLog,
              //             ),
              //           );
              //         },
              //         icon: Icon(FontAwesomeIcons.pen)),
              //     SizedBox(width: RS.w5),
              //     // IconButton(
              //     //   onPressed: () => hospitalLogController.delete(
              //     //     hospitalLog,
              //     //   ),
              //     //   icon: Icon(
              //     //     FontAwesomeIcons.trashCan,
              //     //   ),
              //     // )
              //   ],
              // ),
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
