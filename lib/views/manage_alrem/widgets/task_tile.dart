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
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/notification_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/views/manage_alrem/change_notification_screen.dart';

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
          String titleName = task.isRegular
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

            AppSnackbar.showSuccessChangedMsgSnackBar('$count개의 알람이 취소되었습니다.');
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 12),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _getBGClr(0),
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
                          fontSize: 16,
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
                            size: 18,
                          ),
                          SizedBox(width: 4),
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
                      SizedBox(height: 12),
                      Text(
                        task.isRegular ? '정기 일정' : '',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[100],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
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

  Color _getBGClr(int index) {
    switch (index) {
      // case 0:
      //   return primaryClr;
      // case 1:
      //   return pinkClr;
      // case 2:
      //   return yellowClr;

      default:
        return AppColors.primaryColor;
    }
  }
}
