import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/light_theme.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/views/hospital_visit_log/add_hospital_visit_log_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class HospitalLogBody extends StatelessWidget {
  const HospitalLogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.w10 * 2),
      child:
          GetBuilder<HospitalLogController>(builder: (hospitalLogController) {
        return SingleChildScrollView(
          controller: hospitalLogController.scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                DateFormat('yyy${AppString.year.tr} M${AppString.month.tr}')
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
                    return Text(
                      '+${event.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                calendarStyle: CalendarStyle(
                  markersAlignment: Alignment.bottomCenter,
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
                                  Get.to(() => AddHospitalVisitLogScreen(
                                      selectedDate:
                                          hospitalLogController.selectedDay!));
                                },
                                icon: FaIcon(FontAwesomeIcons.add),
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            padding: EdgeInsets.all(RS.w10 * 1.2),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${value[index].hospitalName}'),
                                        SizedBox(height: RS.h10 / 2),
                                        Text('${value[index].startTime ?? ''}'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.to(
                                                () => AddHospitalVisitLogScreen(
                                                  selectedDate:
                                                      value[index].dateTime,
                                                  hospitalLogModel:
                                                      value[index],
                                                ),
                                              );
                                            },
                                            icon: Icon(FontAwesomeIcons.edit)),
                                        SizedBox(width: RS.w10 / 2),
                                        IconButton(
                                          onPressed: () =>
                                              hospitalLogController.delete(
                                            value[index],
                                          ),
                                          icon: Icon(
                                            FontAwesomeIcons.trashCan,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
      }),
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
