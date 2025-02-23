import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/weekday_selector.dart';
import 'package:ours_log/controller/add_regular_task_controller.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:ours_log/views/setting/add_regular_alram_screen.dart';

class SettingAlramScreen extends StatelessWidget {
  const SettingAlramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddRegularTaskController addScheduleController =
        Get.put(AddRegularTaskController());
    return Scaffold(
      appBar: AppBar(),
      body:
          SafeArea(child: GetBuilder<AddRegularTaskController>(builder: (con) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: RS.w10),
                child: Row(
                  children: List.generate(
                    WeekDayType.values.length,
                    (index) {
                      return WeekdaySelector(
                          fontSize: RS.w10 * 1.8,
                          onTap: () =>
                              addScheduleController.onTapchangeWeekday(index),
                          isSelected: addScheduleController.pageIndex == index,
                          weekDay: WeekDayType.values[index].label);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: RS.h10),
            GestureDetector(
              onTap: () => Get.to(() => const AddRegularAlramScreen()),
              child: Container(
                margin: EdgeInsets.only(right: RS.w10),
                width: RS.w10 * 16,
                height: RS.h10 * 4.5,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.addRegularTask.tr,
                      style: TextStyle(
                        color: textBlackOrWhite,
                        fontSize: RS.w10 * 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: RS.w10),
                    const Icon(Icons.add)
                  ],
                ),
              ),
            ),
            SizedBox(height: RS.h10),
            Expanded(
              child: PageView.builder(
                controller: addScheduleController.pageController,
                itemCount: addScheduleController.tasksPerWeekDay.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: RS.h10, horizontal: RS.w10 * 2.5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          addScheduleController.tasksPerWeekDay[index].length,
                          (index2) {
                            List<TaskModel> tasks =
                                addScheduleController.tasksPerWeekDay[index];
                            TaskModel task = tasks[index2];
                            return Container(
                              padding: EdgeInsets.only(
                                top: RS.h10 * 1.2,
                                bottom: RS.h10 * 1.2,
                                left: RS.h10 * 2,
                                right: RS.h5,
                              ),
                              margin: EdgeInsets.all(RS.w10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(task.taskName),
                                  GestureDetector(
                                    onTap: () => addScheduleController
                                        .changeAlarmTime(context, task),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: RS.h10,
                                        horizontal: RS.w10,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: RS.w5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(RS.w10 * 2),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.timer),
                                          SizedBox(width: RS.w10),
                                          Text(
                                            DateFormat('HH:mm',
                                                    Get.locale.toString())
                                                .format(task.taskDate),
                                          ),
                                          SizedBox(width: RS.w10),
                                          const Icon(Icons.keyboard_arrow_down)
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () => addScheduleController
                                          .deleteTask(index, index2),
                                      icon: const FaIcon(
                                          FontAwesomeIcons.trashCan))
                                ],
                              ),
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
    );
  }
}
