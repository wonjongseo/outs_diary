import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/admob/global_banner_admob.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

import 'package:ours_log/common/widgets/custom_button.dart';
import 'package:ours_log/common/widgets/weekday_selector.dart';
import 'package:ours_log/controller/add_regular_task_controller.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:ours_log/views/background/background_widget.dart';
import 'package:ours_log/views/setting/add_regular_alram_screen.dart';

class SettingAlramScreen extends StatelessWidget {
  const SettingAlramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddRegularTaskController addScheduleController =
        Get.put(AddRegularTaskController());
    return Scaffold(
      appBar: AppBar(title: Text(AppString.notification.tr)),
      bottomNavigationBar: _bottomNavigationBar(),
      body: BackgroundWidget(
        child: SafeArea(
            child: GetBuilder<AddRegularTaskController>(builder: (con) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: List.generate(
                      WeekDayType.values.length,
                      (index) {
                        return WeekdaySelector(
                            fontSize: 10 * 1.8,
                            onTap: () =>
                                addScheduleController.onTapchangeWeekday(index),
                            isSelected:
                                addScheduleController.pageIndex == index,
                            weekDay: WeekDayType.values[index].label);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: const Divider(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: PageView.builder(
                  controller: addScheduleController.pageController,
                  itemCount: addScheduleController.tasksPerWeekDay.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10 * 2),
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            addScheduleController.tasksPerWeekDay[index].length,
                            (index2) {
                              return _taskTile(
                                addScheduleController,
                                context,
                                index,
                                index2,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        })),
      ),
    );
  }

  Container _taskTile(AddRegularTaskController addScheduleController,
      BuildContext context, int index, int index2) {
    List<TaskModel> tasks = addScheduleController.tasksPerWeekDay[index];
    TaskModel task = tasks[index2];
    return Container(
      padding: EdgeInsets.only(
        top: 10 * 1.2,
        bottom: 10 * 1.2,
        left: 10 * 2,
        right: 5,
      ),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10 * 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10 * 10,
            child: Text(task.taskName),
          ),
          GestureDetector(
            onTap: () => addScheduleController.changeAlarmTime(context, task),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 * 2),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer),
                  SizedBox(width: 10),
                  Text(
                    DateFormat('HH:mm', Get.locale.toString())
                        .format(task.taskDate),
                  ),
                  SizedBox(width: 10),
                  const Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => addScheduleController.deleteTask(index, index2),
            icon: const FaIcon(FontAwesomeIcons.trashCan),
          )
        ],
      ),
    );
  }
}

class _bottomNavigationBar extends StatelessWidget {
  const _bottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            label: AppString.addRegularTask.tr,
            onTap: () => Get.to(
              () => const AddRegularAlramScreen(),
            ),
          ),
          SizedBox(height: 10),
          const GlobalBannerAdmob()
        ],
      ),
    );
  }
}
