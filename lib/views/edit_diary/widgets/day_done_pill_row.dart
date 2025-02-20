import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/done_circle_icon.dart';
import 'package:ours_log/controller/edit_diary_controller.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';

class DayDonePillRow extends StatelessWidget {
  const DayDonePillRow({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDiaryController>(builder: (editDiaryController) {
      return ColTextAndWidget(
        label: '약',
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            editDiaryController.donePillDayModels.length,
            (index) {
              return GestureDetector(
                onTap: () =>
                    editDiaryController.onToggleDonePillDayModel(index),
                child: DoneCircleIcon(
                  backgroundColor:
                      editDiaryController.donePillDayModels[index].isDone
                          ? AppColors.primaryColor
                          : Colors.grey,
                  label: editDiaryController
                      .donePillDayModels[index].dayPeriod.label,
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
