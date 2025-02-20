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
import 'package:ours_log/controller/image_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/views/add_diary/add_diary_screen.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/full_Image_screen.dart';
import 'package:ours_log/views/home/widgets/circle_aver_health_widget.dart';

class SelectedDiary extends StatelessWidget {
  const SelectedDiary({super.key, required this.diaryController});

  final DiaryController diaryController;

  @override
  Widget build(BuildContext context) {
    UserController backgroundController = Get.find<UserController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.w10),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      backgroundController
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
                      onPressed: () async {
                        // diaryController.getAllData();

                        Get.to(
                          () => AddDiaryScreen(
                            selectedDay:
                                diaryController.selectedDiary!.dateTime,
                            diaryModel: diaryController.selectedDiary,
                          ),
                        );
                      },
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
            if (diaryController.selectedDiary!.health != null) ...[
              averHealthValue(),
            ],
            ColTextAndWidget(
              label: AppString.whatDidYouHintMsg.tr,
              widget: CustomTextFormField(
                hintText: diaryController.selectedDiary!.whatTodo,
                maxLines: (diaryController.selectedDiary!.whatTodo ?? '')
                    .split('\n')
                    .length,
              ),
            ),
            if (diaryController.selectedDiary!.imagePath != null &&
                diaryController.selectedDiary!.imagePath!.isNotEmpty)
              ColTextAndWidget(
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

  Widget averHealthValue() {
    return Padding(
      padding: EdgeInsets.all(RS.w10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (diaryController.selectedDiary!.health!.temperatures != null)
            Tooltip(
              message:
                  diaryController.selectedDiary!.health!.tooltipMsgTemperature,
              triggerMode: TooltipTriggerMode.tap,
              child: CircleAverHealthWidget(
                title: AppString.temperature.tr,
                averValue:
                    diaryController.selectedDiary!.health!.avgTemperature,
              ),
            ),
          if (diaryController.selectedDiary!.health!.pulses != null)
            Tooltip(
              message: diaryController.selectedDiary!.health!.tooltipMsgPulse,
              triggerMode: TooltipTriggerMode.tap,
              child: CircleAverHealthWidget(
                title: AppString.pulse.tr,
                averValue: diaryController.selectedDiary!.health!.avgPulse,
              ),
            ),
          if (diaryController.selectedDiary!.health!.weights != null)
            Tooltip(
              message: diaryController.selectedDiary!.health!.tooltipMsgWeight,
              triggerMode: TooltipTriggerMode.tap,
              child: CircleAverHealthWidget(
                title: AppString.weight.tr,
                averValue: diaryController.selectedDiary!.health!.avgWeight,
              ),
            ),
        ],
      ),
    );
  }
}
