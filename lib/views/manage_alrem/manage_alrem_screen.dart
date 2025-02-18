import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/controller/notification_controller.dart';

import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/regular_task_modal.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/task_tile.dart';
import 'package:ours_log/views/background/background_widget.dart';

class AlermData {
  String day;
  List<String> times;
  AlermData({
    required this.day,
    required this.times,
  });
}

class ManageAlermScreen extends StatefulWidget {
  const ManageAlermScreen({super.key});

  @override
  State<ManageAlermScreen> createState() => _ManageAlermScreenState();
}

class _ManageAlermScreenState extends State<ManageAlermScreen> {
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    // notificationService.initializeNotifications();
    super.initState();
  }

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    HospitalLogController hospitalLogController =
        Get.find<HospitalLogController>();

    Size size = MediaQuery.of(context).size;
    return GetBuilder<UserController>(builder: (uController) {
      print(
          'uController.userModel!.tasks : ${uController.userModel!.tasks?.length}');

      for (TaskModel task in uController.userModel!.tasks!) {
        print('task : ${task}');
      }

      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd(Get.locale.toString())
                            .format(DateTime.now()),
                        style: subHeadingStyle,
                      ),
                      Text(
                        AppString.today.tr,
                        style: headingStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: RS.h10, left: RS.w10 * 2),
              child: DatePicker(
                DateTime.now(),
                locale: Get.locale.toString(),
                onDateChange: (selectedDate) {
                  now = selectedDate;

                  setState(() {});
                },
                height: RS.h10 * 10,
                initialSelectedDate: now,
                width: RS.w10 * 8,
                selectionColor: Colors.pinkAccent,
                dateTextStyle: TextStyle(
                    fontSize: RS.w10 * 2,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
                dayTextStyle: TextStyle(
                    fontSize: RS.w10 * 1.6,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
                monthTextStyle: TextStyle(
                    fontSize: RS.w10 * 1.4,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ),
            SizedBox(height: RS.h10 * 2),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(uController.userModel!.tasks?.length ?? 0,
                        (index) {
                      if (uController.userModel!.tasks![index].isRegular) {
                        if (AppFunction.isSameWeekDay(
                            uController.userModel!.tasks![index].taskDate,
                            now)) {
                          return TaskTile(
                            task: uController.userModel!.tasks![index],
                          );
                        }
                      } else if (AppFunction.isSameDay(
                          uController.userModel!.tasks![index].taskDate, now)) {
                        return TaskTile(
                          task: uController.userModel!.tasks![index],
                        );
                      }
                      return Container();
                    }),
                    Divider(),
                    // ...List.generate(
                    //     uController.userModel!.regularTasks![now.weekday]!.length,
                    //     (index) {
                    //   return Container(
                    //     padding: EdgeInsets.symmetric(horizontal: 20),
                    //     width: MediaQuery.of(context).size.width,
                    //     margin: EdgeInsets.only(bottom: 12),
                    //     child: Container(
                    //       padding: EdgeInsets.all(16),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(16),
                    //           color: Colors.pinkAccent),
                    //       child: Text(
                    //         uController.userModel!
                    //             .regularTasks![now.weekday]![index].scheduleTime,
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // })
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

String intDayToString(int? day) {
  switch (day) {
    case 1:
      return '월';
    case 2:
      return '화';
    case 3:
      return '수';
    case 4:
      return '목';
    case 5:
      return '금';
    case 6:
      return '토';
    case 7:
      return '일';
    default:
      return '월';
  }
}
