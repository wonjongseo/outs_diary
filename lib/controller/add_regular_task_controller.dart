import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app.dialog.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:ours_log/services/notification_service.dart';

class AddRegularTaskController extends GetxController {
  List<List<TaskModel>> tasksPerWeekDay = [];
  late PageController pageController;
  int pageIndex = 0;

  UserController userCon = Get.find<UserController>();
  NotificationService notificationService = NotificationService();

  @override
  void onInit() {
    tasksPerWeekDay = List.generate(WeekDayType.values.length, (_) => []);
    pageController = PageController(initialPage: pageIndex);
    if (userCon.userModel!.tasks != null) {
      for (TaskModel task in userCon.userModel!.tasks!) {
        if (!task.isRegular) continue;
        tasksPerWeekDay[task.taskDate.weekday - 1].add(task);
      }
    }
    for (var task in tasksPerWeekDay) {
      task.sort((a, b) => a.taskDate.compareTo(b.taskDate));
    }

    super.onInit();
  }

  bool isTapchangeWeekday = false;
  void onTapchangeWeekday(int index) {
    if (isTapchangeWeekday) return;
    isTapchangeWeekday = true;
    pageIndex = index;
    update();
    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    isTapchangeWeekday = false;
  }

  void deleteTask(int index, int index2) async {
    List<TaskModel> tasks = tasksPerWeekDay[index];
    TaskModel task = tasks[index2];
    String taskName = task.taskName;
    bool result = await AppDialog.selectionDialog(
        title: isEn
            ? Text(
                '${AppString.previousDeletePetMsg4.tr} (${AppString.regularSchedule.tr}) $taskName?',
              )
            : Text(
                '(${AppString.regularSchedule.tr}) $taskName${AppString.previousDeletePetMsg4.tr}',
              ),
        connent: Text(AppString.areYouDeleteMsg.tr));

    if (result) {
      tasks.remove(task);
      update();
      userCon.deleteTask(task);
      AppSnackbar.showMessageSnackBar(
        message: '$taskName${AppString.deletedMsg.tr}',
      );
    }
  }

  Future<void> changeAlarmTime(
    BuildContext context,
    TaskModel task,
  ) async {
    int weekDay = pageIndex + 1;
    int beforeHour = task.taskDate.hour;
    int beforeMinute = task.taskDate.minute;
    TimeOfDay? timeOfDay = await AppFunction.pickTime(context,
        initialTime: TimeOfDay(hour: beforeHour, minute: beforeMinute));

    if (timeOfDay == null) return;

    if (timeOfDay.hour == beforeHour && timeOfDay.minute == beforeMinute) {
      return;
    }

    int hour = timeOfDay.hour;
    int minute = timeOfDay.minute;

    task.taskDate = DateTime(task.taskDate.year, task.taskDate.month,
        task.taskDate.day, hour, minute);
    update();

    userCon.deleteTask(task);
    // int day = task.taskDate.day;
    int id = AppFunction.createIdByDay(weekDay, hour, minute);

    // return;
    String message = AppString.timeToDrink.tr;

    DateTime? taskTime = await notificationService.scheduleWeeklyNotification(
      title: '💊 ${AppString.drinkPillAlram.tr}',
      message: message,
      channelDescription: AppString.pillcCannelDescription.tr,
      id: id,
      weekday: weekDay,
      hour: hour,
      minute: minute,
    );

    if (taskTime == null) return;
    TaskModel taskModel = TaskModel(
      taskName: task.taskName,
      taskDate: taskTime,
      notifications: [NotificationModel(notiDateTime: taskTime, alermId: id)],
      isRegular: true,
    );
    userCon.addTask(taskModel);

    update();
    AppSnackbar.showMessageSnackBar(message: AppString.editedAlramTime.tr);
  }
}
