import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/edit_diary_controller.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/poop_condition_type.dart';

class PoopDayPeriod extends StatelessWidget {
  const PoopDayPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDiaryController>(builder: (editDiaryController) {
      if (editDiaryController.poopConditionTypes[0] == null) {}
      return Container(
        padding: EdgeInsets.symmetric(horizontal: RS.w10 * 1.6).copyWith(
          top: RS.height14,
          bottom: RS.h10,
        ),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ...List.generate(DayPeriodType.values.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: RS.h10 / 2),
                child: Row(
                  children: [
                    Text(DayPeriodType.values[index].label),
                    SizedBox(width: RS.w10 * 2),
                    Expanded(
                      child: CustomTextFormField(
                        hintText:
                            editDiaryController.poopConditionTypes[index] ==
                                    null
                                ? ''
                                : editDiaryController
                                    .poopConditionTypes[index]!.label,
                        widget: DropdownButton(
                          padding: EdgeInsets.only(right: RS.w10),
                          iconSize: RS.w10 * 2.5,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: const SizedBox(),
                          items: List.generate(PoopConditionType.values.length,
                              (index) {
                            PoopConditionType poopCondition =
                                PoopConditionType.values[index];
                            return DropdownMenuItem(
                              value: poopCondition,
                              child: Text(poopCondition.label),
                            );
                          }),
                          onChanged: (v) =>
                              editDiaryController.selectPoopCondition(v, index),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      );
    });
  }
}
