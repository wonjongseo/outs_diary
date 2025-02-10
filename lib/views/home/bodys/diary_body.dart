import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/light_theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/views/home/main_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryBody extends StatelessWidget {
  DiaryBody({super.key});

  DiaryController diaryController = Get.find<DiaryController>();

  TextStyle get weekdayStyle {
    return TextStyle(
      color: Get.isDarkMode ? Colors.white : AppColors.greyBackground,
    );
  }

  Widget? prioritizedBuilder(context, day, focusedDay) {
    bool isNextDay = day.day > diaryController.now.day;
    return Column(
      children: [
        Container(
          height: RS.w10 * 4.5,
          width: RS.w10 * 4.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isNextDay ? Colors.grey.withOpacity(.15) : Colors.white,
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
    if (diaryController.kEvents[day] != null) {
      DiaryModel diaryModel = diaryController.kEvents[day]![0];
      return Column(
        children: [
          CircleAvatar(
            foregroundImage: AssetImage(diaryModel.getFealImage),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: GetBuilder<DiaryController>(builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                // onTap: selectYearAndMonthDialog,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat(
                              'yyy${AppString.yearText.tr} M${AppString.monthText.tr}')
                          .format(controller.focusedDay),
                      style: boldStyle,
                    ),
                    SizedBox(width: RS.w10),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
              TableCalendar(
                availableGestures: AvailableGestures.horizontalSwipe,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: weekdayStyle,
                  weekendStyle: weekdayStyle,
                ),
                pageJumpingEnabled: false,
                pageAnimationEnabled: false,
                locale: isKo ? 'ko' : 'ja',
                daysOfWeekHeight: 100,
                headerVisible: false,
                onPageChanged: diaryController.onPageChanged,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                  markersAutoAligned: false,
                  markersAlignment: Alignment.center,
                  cellAlignment: Alignment.bottomCenter,
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
          );
        }),
      ),
    );
  }
}

// void selectYearAndMonthDialog() async {
  //   await Get.dialog(
  //     AlertDialog(
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Row(
  //                 children: [
  //                   Text(
  //                     DateFormat('yyy년').format(diaryController.focusedDay),
  //                     style: boldStyle,
  //                   ),
  //                   SizedBox(width: RS.w10),
  //                   const Icon(Icons.keyboard_arrow_down),
  //                 ],
  //               ),
  //               Row(
  //                 children: [
  //                   Icon(Icons.keyboard_arrow_left),
  //                   SizedBox(width: RS.w10),
  //                   Icon(Icons.keyboard_arrow_right)
  //                 ],
  //               )
  //             ],
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(
  //               top: RS.height30,
  //               bottom: RS.height20,
  //             ),
  //             child: Wrap(
  //               spacing: 10,
  //               runSpacing: 15,
  //               children: List.generate(
  //                 12,
  //                 (index) {
  //                   bool isSelectable =
  //                       diaryController.focusedDay.month > index;

  //                   return GestureDetector(
  //                     onTap: () {
  //                       if (isSelectable) {
  //                         diaryController.focusedDay = DateTime(
  //                             diaryController.focusedDay.year, index - 1);
  //                       }
  //                     },
  //                     child: Container(
  //                       width: RS.w10 * 6,
  //                       height: RS.h10 * 3.5,
  //                       decoration: BoxDecoration(
  //                         color: index == diaryController.now.month - 1
  //                             ? Colors.pinkAccent
  //                             : isSelectable
  //                                 ? Colors.grey[300]
  //                                 : Colors.grey.withOpacity(0.3),
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           '${index + 1}월',
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                             color:
  //                                 index == diaryController.focusedDay.month - 1
  //                                     ? Colors.white
  //                                     : isSelectable
  //                                         ? Colors.black
  //                                         : Colors.black.withOpacity(0.3),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }