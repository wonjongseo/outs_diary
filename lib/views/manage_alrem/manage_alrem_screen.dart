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
      // for (NotificationModel notification
      //     in uController.userModel!.notifications ?? []) {
      //   print('notification.dateTime : ${notification.notiDateTime}');
      // }
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
            if (uController.userModel!.regularTasks![now.weekday] != null)
              Column(
                children: [
                  ...List.generate(uController.userModel!.tasks?.length ?? 0,
                      (index) {
                    if (AppFunction.isSameDay(
                        uController.userModel!.tasks![index].taskDate, now)) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.pinkAccent),
                          child: Text(
                            '${uController.userModel!.tasks![index].taskDate.hour}:${uController.userModel!.tasks![index].taskDate.minute}',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  }),
                  Divider(),
                  ...List.generate(
                      uController.userModel!.regularTasks![now.weekday]!.length,
                      (index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.pinkAccent),
                        child: Text(
                          uController.userModel!
                              .regularTasks![now.weekday]![index].scheduleTime,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  })
                ],
              )
          ],
        ),
      );
    });
    return GetBuilder<UserController>(builder: (uController) {
      // uController.userModel!.drinkPillAlerms!.forEach((key, value) {
      //   print(key);
      //   print(value);
      // });
      // print('uController.userModel : ${uController.userModel}');

      return Scaffold(
        appBar: AppBar(),
        body: BackgroundWidget(
            widget: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: RS.h10 * 2,
              horizontal: RS.w10 * 1.6,
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        uController.userModel!.regularTasks!.entries.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(right: RS.w10 * 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 100,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  intDayToString(e.key - 1),
                                ),
                              ),
                            ),
                            SizedBox(height: RS.h10),
                            Column(
                              children: e.value.map((alarm) {
                                return GestureDetector(
                                  onTap: () {
                                    print('alarm. : ${alarm.alermId}');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 60,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.pinkAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text(alarm.scheduleTime))),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        )),
      );
    });
  }
}

String intDayToString(int? day) {
  switch (day) {
    case 0:
      return '월';
    case 1:
      return '화';
    case 2:
      return '수';
    case 3:
      return '목';
    case 4:
      return '금';
    case 5:
      return '토';
    case 6:
      return '일';
    default:
      return '월';
  }
}
