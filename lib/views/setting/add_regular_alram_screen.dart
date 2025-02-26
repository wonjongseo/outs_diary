import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/admob/global_banner_admob.dart';

import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/common/utilities/app_validator.dart';

import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_button.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/common/widgets/weekday_selector.dart';
import 'package:ours_log/controller/add_regular_task_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:ours_log/services/notification_service.dart';
import 'package:ours_log/views/background/background_widget.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';

class AddRegularAlramScreen extends StatefulWidget {
  const AddRegularAlramScreen({super.key});

  @override
  State<AddRegularAlramScreen> createState() => _AddRegularAlramScreenState();
}

class _AddRegularAlramScreenState extends State<AddRegularAlramScreen> {
  String? startTime;
  List<WeekDayType> selectedWeekdayIndexs = [];
  TextEditingController scheduleNameCnl = TextEditingController();
  TextEditingController scheduleMessageCnl = TextEditingController();
  NotificationService notificationService = NotificationService();
  AddRegularTaskController addScheduleController =
      Get.find<AddRegularTaskController>();
  @override
  void initState() {
    // selectedWeekdayIndexs.add(WeekDayType.values[DateTime.now().weekday - 1]);
    // selectedWeekdayIndexs
    //     .add(WeekDayType.values[addScheduleController.pageIndex]);
    super.initState();
  }

  void onTapVisitTime() async {
    TimeOfDay? pickedTime = await AppFunction.pickTime(context);

    if (pickedTime == null) {
      return;
    }
    String formatedTime = pickedTime.format(context);
    startTime = formatedTime;
    setState(() {});
  }

  bool validate() {
    if (!AppValidator.validateInputField(
        AppString.taskName.tr, scheduleNameCnl.text)) {
      return false;
    }
    if (!AppValidator.validateSelectStringField(
        AppString.taskTime.tr, startTime)) {
      return false;
    }
    if (!AppValidator.validateStringTime(startTime!)) {
      return false;
    }
    if (!AppValidator.validateSelectListField(
        AppString.weekday.tr, selectedWeekdayIndexs)) {
      return false;
    }
    return true;
  }

  void onSaveBtn() async {
    if (!validate()) {
      return;
    }

    TimeOfDay? timeOfDay = AppFunction.stringToTimeOfDay(startTime!);
    if (timeOfDay == null) return;
    selectedWeekdayIndexs.sort((a, b) => a.index.compareTo(b.index));
    List<TaskModel> tasks = [];
    String title = scheduleNameCnl.text;
    String message = scheduleMessageCnl.text;
    for (var weekday in selectedWeekdayIndexs) {
      int realWeekday = weekday.index + 1;
      int id = AppFunction.createIdByDay(
        realWeekday,
        timeOfDay.hour,
        timeOfDay.minute,
      );

      DateTime? taskTime = await notificationService.scheduleWeeklyNotification(
          id: id,
          title: title,
          message: message,
          weekday: realWeekday,
          hour: timeOfDay.hour,
          minute: timeOfDay.minute);

      if (taskTime == null) continue;

      TaskModel taskModel = TaskModel(
        taskName: scheduleNameCnl.text,
        taskDate: taskTime,
        isRegular: true,
        notifications: [NotificationModel(notiDateTime: taskTime, alermId: id)],
      );

      addScheduleController.tasksPerWeekDay[weekday.index].add(taskModel);
      tasks.add(taskModel);
    }
    addScheduleController.update();
    Get.find<UserController>().addTaskList(tasks);

    print('object');
    Get.back();
    AppSnackbar.showMessageSnackBar(
      message: '$title${AppString.enrolledMsg.tr}',
    );
  }

  void selectWeekday(int index) {
    setState(() {
      if (selectedWeekdayIndexs.contains(WeekDayType.values[index])) {
        selectedWeekdayIndexs.remove(WeekDayType.values[index]);
      } else {
        selectedWeekdayIndexs.add(WeekDayType.values[index]);
      }
    });
  }

  @override
  void dispose() {
    scheduleNameCnl.dispose();
    scheduleMessageCnl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.addRegularTask.tr)),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              label: AppString.saveText.tr,
              onTap: onSaveBtn,
            ),
            SizedBox(height: RS.h10),
            const GlobalBannerAdmob()
          ],
        ),
      ),
      body: BackgroundWidget(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ColTextAndWidget(
                      label: AppString.taskName.tr,
                      widget: CustomTextFormField(
                        controller: scheduleNameCnl,
                      ),
                    ),
                    SizedBox(height: RS.h10),
                    ColTextAndWidget(
                      label: AppString.taskMessage.tr,
                      widget: CustomTextFormField(
                        controller: scheduleMessageCnl,
                      ),
                    ),
                    SizedBox(height: RS.h10),
                    ColTextAndWidget(
                      label: AppString.taskTime.tr,
                      widget: CustomTextFormField(
                        onTap: onTapVisitTime,
                        readOnly: true,
                        hintText: startTime ?? '',
                        widget: IconButton(
                          onPressed: onTapVisitTime,
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                    ),
                    SizedBox(height: RS.h10),
                    ColTextAndWidget(
                      label: AppString.weekday.tr,
                      widget: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              List.generate(WeekDayType.values.length, (index) {
                            return WeekdaySelector(
                                height: RS.w10 * 8,
                                width: RS.w10 * 8,
                                onTap: () => selectWeekday(index),
                                isSelected: selectedWeekdayIndexs
                                    .contains(WeekDayType.values[index]),
                                weekDay: WeekDayType.values[index].label);
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
