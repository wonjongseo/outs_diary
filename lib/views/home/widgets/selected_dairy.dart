import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/common/widgets/done_circle_icon.dart';
import 'package:ours_log/controller/image_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/poop_condition_type.dart';
import 'package:ours_log/views/edit_diary/edit_diary_screen.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/full_Image_screen.dart';
import 'package:ours_log/views/home/widgets/aver_health_value.dart';

class SelectedDiary extends StatelessWidget {
  const SelectedDiary({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.black : AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GetBuilder<DiaryController>(builder: (diaryController) {
        DiaryModel diaryModel = diaryController.selectedDiary!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FealIconAndDay(userController, diaryController),
            const Divider(),
            SizedBox(height: 10),
            if (diaryModel.donePillDayModels!.isNotEmpty) ...[
              _donePill(diaryModel, diaryController),
              SizedBox(height: 10 * 1.5),
            ],
            if (diaryModel.health != null &&
                diaryModel.health!.argIsNotZero) ...[
              _healthFiguare(diaryModel),
              SizedBox(height: 10 * 1.5),
            ],
            if (diaryModel.poopConditions != null &&
                diaryModel.poopConditions!.isNotEmpty) ...[
              _poopCondition(diaryModel, diaryController),
              SizedBox(height: 10 * 1.5),
            ],
            ColTextAndWidget(
              vertical: 5,
              label: '${AppString.health.tr} ${AppString.memo.tr}',
              widget: CustomTextFormField(
                readOnly: true,
                hintStyle: const TextStyle(),
                hintText: diaryModel.whatTodo,
                maxLines: (diaryModel.whatTodo ?? '').split('\n').length,
              ),
            ),
            SizedBox(height: 10),
            if (diaryModel.imagePath != null &&
                diaryModel.imagePath!.isNotEmpty) ...[
              ColTextAndWidget(
                vertical: 5,
                label: AppString.photo.tr,
                widget: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      diaryModel.imagePath!.length,
                      (index) {
                        String imageUrl =
                            '${ImageController.instance.path}/${diaryModel.imagePath![index]}';
                        return GestureDetector(
                          onTap: () =>
                              Get.to(() => FullmageScreen(fileImage: imageUrl)),
                          child: Container(
                            width: 10 * 12,
                            height: 10 * 14,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10 * 2),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: FileImage(File(imageUrl)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10 * 1.5),
            ]
          ],
        );
      }),
    );
  }

  ColTextAndWidget _healthFiguare(DiaryModel diaryModel) {
    return ColTextAndWidget(
      vertical: 5,
      label: AppString.averageHealthValue.tr,
      labelWidget: diaryModel.painfulIndex == null
          ? null
          : Text('${AppString.painLevel.tr}: ${diaryModel.painfulIndex!}'),
      widget: const AverHealthValue(),
    );
  }

  ColTextAndWidget _poopCondition(
      DiaryModel diaryModel, DiaryController diaryController) {
    return ColTextAndWidget(
      vertical: 5,
      label: AppString.poop.tr,
      widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            diaryModel.poopConditions!.length,
            (index) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10 * .6),
                        constraints: BoxConstraints(minWidth: 10 * 7.5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10 * .3),
                        ),
                        child: Center(
                          child: Text(
                            diaryController.selectedDiary!
                                .poopConditions![index].dayPeriodType.label,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? textWhiteOrBlack
                                  : textBlackOrWhite,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        diaryController.selectedDiary!.poopConditions![index]
                            .poopConditionType.label,
                      ),
                    ],
                  )),
            ),
          )),
    );
  }

  ColTextAndWidget _donePill(
      DiaryModel diaryModel, DiaryController diaryController) {
    return ColTextAndWidget(
      vertical: 5,
      label: AppString.doDrinkPill.tr,
      widget: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            diaryModel.donePillDayModels!.length,
            (index) => DoneCircleIcon(
              backgroundColor: diaryController
                      .selectedDiary!.donePillDayModels![index].isDone
                  ? AppColors.primaryColor
                  : Colors.grey,
              label: diaryModel.donePillDayModels![index].dayPeriod.label,
            ),
          ),
        ),
      ),
    );
  }

  Row _FealIconAndDay(
      UserController userController, DiaryController diaryController) {
    DiaryModel diaryModel = diaryController.selectedDiary!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              userController.feals[diaryModel.fealIndex],
              width: 10 * 6,
            ),
            SizedBox(width: 10),
            Text(
              DateFormat.MMMEd(Get.locale.toString())
                  .format(diaryModel.dateTime),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => Get.to(
                () => EditDiaryScreen(
                  selectedDay: diaryModel.dateTime,
                  diaryModel: diaryController.selectedDiary,
                ),
              ),
              icon: FaIcon(
                FontAwesomeIcons.pen,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () => diaryController.delete(),
              icon: FaIcon(
                FontAwesomeIcons.trashCan,
                size: 20,
              ),
            ),
          ],
        )
      ],
    );
  }
}
