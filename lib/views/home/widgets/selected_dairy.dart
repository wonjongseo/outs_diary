import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/common/widgets/done_circle_icon.dart';
import 'package:ours_log/controller/image_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/views/edit_diary/edit_diary_screen.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/full_Image_screen.dart';
import 'package:ours_log/views/home/widgets/aver_health_value.dart';

class SelectedDiary extends StatelessWidget {
  const SelectedDiary({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    DiaryController diaryController = Get.find<DiaryController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.w10 / 2),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      userController
                          .feals[diaryController.selectedDiary!.fealIndex],
                      width: RS.w10 * 6,
                    ),
                    SizedBox(width: RS.w10),
                    Text(
                      DateFormat.MMMEd(Get.locale.toString())
                          .format(diaryController.selectedDiary!.dateTime),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.to(
                        () => EditDiaryScreen(
                          selectedDay: diaryController.selectedDiary!.dateTime,
                          diaryModel: diaryController.selectedDiary,
                        ),
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.pen,
                        size: RS.width20,
                      ),
                    ),
                    IconButton(
                      onPressed: () => diaryController.delete(),
                      icon: FaIcon(
                        FontAwesomeIcons.trashCan,
                        size: RS.width20,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            SizedBox(height: RS.h10),
            ColTextAndWidget(
              vertical: RS.h10 / 2,
              label: AppString.healthMemo,
              widget: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    diaryController.selectedDiary!.donePillDayModels!.length,
                    (index) => DoneCircleIcon(
                      backgroundColor: diaryController
                              .selectedDiary!.donePillDayModels![index].isDone
                          ? AppColors.primaryColor
                          : Colors.grey,
                      label: diaryController.selectedDiary!
                          .donePillDayModels![index].dayPeriod.label,
                    ),
                  ),
                ),
              ),
            ),
            if (diaryController.selectedDiary!.health != null &&
                diaryController.selectedDiary!.health!.argIsNotZero) ...[
              ColTextAndWidget(
                vertical: RS.h10 / 2,
                label: AppString.average.tr,
                widget: const AverHealthValue(),
              ),
            ],
            if (diaryController.selectedDiary!.donePillDayModels != null &&
                diaryController
                    .selectedDiary!.donePillDayModels!.isNotEmpty) ...[
              ColTextAndWidget(
                vertical: RS.h10 / 2,
                label: AppString.healthMemo,
                widget: CustomTextFormField(
                  hintText: diaryController.selectedDiary!.whatTodo,
                  maxLines: (diaryController.selectedDiary!.whatTodo ?? '')
                      .split('\n')
                      .length,
                ),
              ),
            ],
            if (diaryController.selectedDiary!.imagePath != null &&
                diaryController.selectedDiary!.imagePath!.isNotEmpty)
              ColTextAndWidget(
                vertical: RS.h10 / 2,
                label: AppString.photo.tr,
                widget: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      diaryController.selectedDiary!.imagePath!.length,
                      (index) {
                        String imageUrl =
                            '${ImageController.instance.path}/${diaryController.selectedDiary!.imagePath![index]}';
                        return GestureDetector(
                          onTap: () =>
                              Get.to(() => FullmageScreen(fileImage: imageUrl)),
                          child: Container(
                            width: RS.w10 * 12,
                            height: RS.w10 * 14,
                            margin: EdgeInsets.only(right: RS.w10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(RS.w10 * 2),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: FileImage(
                                  File(imageUrl),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
