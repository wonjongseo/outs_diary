import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app.dialog.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/notification_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    NotificationService notificationService = NotificationService();

    return GetBuilder<UserController>(builder: (userController) {
      return GestureDetector(
        onTap: () async {
          int count = 0;
          String titleName = task.isRegular // MESSAGE TODO
              ? '"${DateFormat.EEEE(Get.locale.toString()).format(task.taskDate)}의 정기 알림"'
              : '(${DateFormat.yMMMEd(Get.locale.toString()).format(task.taskDate)}의 알림)\n"${task.taskName}"';
          bool result = await AppDialog.selectionDialog(
              title: Text('$titleName 을 끄시나요?'));

          if (result) {
            for (var notification in task.notifications) {
              count++;
              notificationService.cancellNotifications(notification.alermId);
            }

            userController.deleteTask(task);

            AppSnackbar.showSuccessChangedMsgSnackBar(
                '$count${AppString.cancledNotification.tr}');
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: RS.w10 * 2),
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: RS.w10 * 1.2),
          child: Container(
            padding: EdgeInsets.all(RS.w10 * 1.6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.primaryColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.taskName,
                        style: TextStyle(
                          fontSize: RS.w10 * 1.6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey[200],
                            size: RS.w10 * 1.8,
                          ),
                          SizedBox(width: RS.w10 * .4),
                          Text(
                            DateFormat.Hm(Get.locale.toString())
                                .format(task.taskDate),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[100],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: RS.h10 * 1.2),
                      Text(
                        task.isRegular ? AppString.regularSchedule.tr : '',
                        style: TextStyle(
                          fontSize: RS.w10 * 1.5,
                          color: Colors.grey[100],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: RS.w10),
                  height: RS.h10 * 6,
                  width: .5,
                  color: Colors.grey[200]!.withOpacity(.7),
                ),
                FaIcon(
                  FontAwesomeIcons.xmark,
                  size: RS.w10 * 2.2,
                  color: AppColors.white,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
