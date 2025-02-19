import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/models/task_model.dart';

class EditNotificationScreen extends StatelessWidget {
  const EditNotificationScreen({super.key, required this.taskModel});

  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (taskModel.isRegular) ...[
                Text.rich(
                  TextSpan(
                    text: taskModel.taskName,
                    children: [
                      TextSpan(text: '(정기 알람)'),
                    ],
                  ),
                ),
                Column(
                  children: List.generate(
                    taskModel.notifications.length,
                    (index) {
                      return Text(
                        DateFormat.EEEE(Get.locale.toString()).format(
                            taskModel.notifications[index].notiDateTime),
                      );
                      // return Text(
                      //   intDayToString(taskModel
                      //       .notifications[index].notiDateTime.weekday),
                      // );
                    },
                  ),
                )
              ] else ...[
                Text(
                  taskModel.taskDate.toString(),
                ),
                Text(
                  taskModel.taskName,
                ),
                Column(
                  children:
                      List.generate(taskModel.notifications.length, (index) {
                    return Text(taskModel.notifications[index].toString());
                  }),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
