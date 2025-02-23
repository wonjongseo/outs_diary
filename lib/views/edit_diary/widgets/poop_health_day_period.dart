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
                padding: EdgeInsets.symmetric(vertical: RS.h5),
                child: Row(
                  children: [
                    Text(DayPeriodType.values[index].label),
                    SizedBox(width: RS.w10 * 2),
                    Expanded(
                      child: CustomTextFormField(
                        hintStyle: const TextStyle(),
                        readOnly: true,
                        hintText: editDiaryController
                                    .getDayPeriodPoopCondition(index) ==
                                null
                            ? ''
                            : editDiaryController
                                .getDayPeriodPoopCondition(index)!
                                .label,
                        widget: Row(
                          children: [
                            DropdownButton(
                              padding: EdgeInsets.only(right: RS.w10),
                              iconSize: RS.w10 * 2.5,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              underline: const SizedBox(),
                              items: List.generate(
                                  PoopConditionType.values.length, (index) {
                                PoopConditionType poopCondition =
                                    PoopConditionType.values[index];
                                return DropdownMenuItem(
                                  value: poopCondition,
                                  child: Text(poopCondition.label),
                                );
                              }),
                              onChanged: (v) => editDiaryController
                                  .setDayPeriodPoopCondition(index, v),
                            ),
                            if (editDiaryController
                                    .getDayPeriodPoopCondition(index) !=
                                null)
                              IconButton(
                                  onPressed: () {
                                    editDiaryController
                                        .setDayPeriodPoopCondition(index, null);
                                  },
                                  icon: const Icon(Icons.remove))
                          ],
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
