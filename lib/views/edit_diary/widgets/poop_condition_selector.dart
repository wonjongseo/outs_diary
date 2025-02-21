import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/common/widgets/done_circle_icon.dart';
import 'package:ours_log/controller/edit_diary_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/is_expandtion_type.dart';
import 'package:ours_log/models/poop_condition_type.dart';

class PoopConditionSelector extends StatelessWidget {
  const PoopConditionSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return CustomExpansionCard(
        title: '응아',
        initiallyExpanded: userController.userModel!.userUtilModel
                .expandedFields[IsExpandtionType.pulse] ??
            false,
        onExpansionChanged: (bool v) =>
            userController.toggleExpanded(IsExpandtionType.pulse),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: RS.width8,
            ).copyWith(
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
                  return Row(
                    children: [
                      Text(DayPeriodType.values[index].label),
                      SizedBox(width: RS.w10 * 2),
                      Expanded(
                        child: CustomTextFormField(widget: Text('data')),
                      ),
                    ],
                  );
                })
                // Row(
                //   children: [
                //     Text(AppString.morning.tr),
                //     SizedBox(width: RS.w10 * 2),
                //     Expanded(
                //       child: CustomTextFormField(widget: Text('data')),
                //     ),
                //   ],
                // ),
                // SizedBox(height: RS.h10),
                // Row(
                //   children: [
                //     Text(AppString.lunch.tr),
                //     SizedBox(width: RS.w10 * 2),
                //     Expanded(
                //       child: CustomTextFormField(widget: Text('data')),
                //     ),
                //   ],
                // ),
                // SizedBox(height: RS.h10),
                // Row(
                //   children: [
                //     Text(AppString.evening.tr),
                //     SizedBox(width: RS.w10 * 2),
                //     Expanded(
                //       child: CustomTextFormField(widget: Text('data')),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// class PoopConditionSelector extends StatelessWidget {
//   const PoopConditionSelector({super.key});

//   @override
//   Widget build(BuildContext context) {
//     UserController userController = Get.find<UserController>();
//     return GetBuilder<EditDiaryController>(
//       builder: (editDiaryController) {
//         return CustomExpansionCard(
//           title: '응아 상태',
//           initiallyExpanded: userController.userModel!.userUtilModel
//                   .expandedFields[IsExpandtionType.poopCondition] ??
//               false,
//           onExpansionChanged: (bool v) =>
//               userController.toggleExpanded(IsExpandtionType.poopCondition),
//           child: Container(
//             padding: EdgeInsets.only(
//               left: RS.w10,
//               right: RS.w10,
//               bottom: RS.w10,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: List.generate(
//                 editDiaryController.poopConditionTypes.length + 1,
//                 (index) {
//                   if (editDiaryController.poopConditionTypes.length > index) {
//                     // dont' remove
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: RS.h10),
//                       child: CustomTextFormField(
//                         hintText:
//                             editDiaryController.poopConditionTypes[index].label,
//                         widget: DropdownButton(
//                           iconSize: RS.w10 * 3.5,
//                           underline: const SizedBox(),
//                           items: PoopConditionType.values
//                               .map((condition) => DropdownMenuItem(
//                                     value: condition,
//                                     child: Text(condition.label),
//                                   ))
//                               .toList(),
//                           onChanged: (v) {
//                             editDiaryController.selectPoopCondition(
//                               v!,
//                               index: index,
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   }
//                   return CustomTextFormField(
//                     hintText: '',
//                     widget: DropdownButton(
//                       iconSize: RS.w10 * 3.5,
//                       underline: const SizedBox(),
//                       items: PoopConditionType.values
//                           .map(
//                             (condition) => DropdownMenuItem(
//                                 value: condition, child: Text(condition.label)),
//                           )
//                           .toList(),
//                       onChanged: (v) {
//                         editDiaryController.selectPoopCondition(v!);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
