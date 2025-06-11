import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

import 'package:ours_log/common/widgets/custom_expansion_card.dart';
import 'package:ours_log/controller/edit_diary_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/is_expandtion_type.dart';
import 'package:ours_log/models/poop_condition_type.dart';

class PoopDayPeriod extends StatelessWidget {
  const PoopDayPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return GetBuilder<EditDiaryController>(
      builder: (editDiaryController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
            top: 14,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? AppColors.black : AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ...List.generate(
                DayPeriodType.values.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Container(
                          constraints: const BoxConstraints(minWidth: 75),
                          child: Text(DayPeriodType.values[index].label),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _dropdown(editDiaryController, index),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              CustomExpansionCard(
                initiallyExpanded: userController.userModel!.userUtilModel
                        .expandedFields[IsExpandtionType.poopConditionImage] ??
                    false,
                onExpansionChanged: (bool v) => userController
                    .toggleExpanded(IsExpandtionType.poopConditionImage),
                title: AppString.checkPoopConditionByImage.tr,
                child: Image.asset(AppImagePath.poopCondition),
              ),
            ],
          ),
        );
      },
    );
  }

  DropdownButton2<PoopConditionType?> _dropdown(
      EditDiaryController editDiaryController, int index) {
    return DropdownButton2<PoopConditionType?>(
      isExpanded: true,
      value: editDiaryController.getDayPeriodPoopCondition(index),
      underline: const SizedBox(),
      items: [
        ...List.generate(PoopConditionType.values.length, (index) {
          PoopConditionType poopCondition = PoopConditionType.values[index];
          return DropdownMenuItem(
            value: poopCondition,
            child: Text(
              poopCondition.label,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          );
        }),
      ],
      onChanged: (v) => editDiaryController.setDayPeriodPoopCondition(index, v),
    );
  }
}
