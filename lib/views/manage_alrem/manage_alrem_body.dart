import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';

import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/views/manage_alrem/widgets/task_tile.dart';

class ManageAlermBody extends StatefulWidget {
  const ManageAlermBody({super.key});

  @override
  State<ManageAlermBody> createState() => _ManageAlermBodyState();
}

class _ManageAlermBodyState extends State<ManageAlermBody> {
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    log('ManageAlermBody');
    return GetBuilder<UserController>(builder: (uController) {
      return Column(
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
              selectionColor: AppColors.primaryColor,
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
                          uController.userModel!.tasks![index].taskDate, now)) {
                        return FadeInRight(
                          child: TaskTile(
                            task: uController.userModel!.tasks![index],
                          ),
                        );
                      }
                    } else if (AppFunction.isSameDay(
                        uController.userModel!.tasks![index].taskDate, now)) {
                      return FadeInRight(
                        child: TaskTile(
                          task: uController.userModel!.tasks![index],
                        ),
                      );
                    }
                    return Container();
                  }),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
