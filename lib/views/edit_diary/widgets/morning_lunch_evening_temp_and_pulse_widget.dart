import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/user_controller.dart';

class MorningLunchEveningTempAndPulseWidget extends StatelessWidget {
  const MorningLunchEveningTempAndPulseWidget({
    super.key,
    required this.controllers,
    required this.sufficText,
    required this.keyboardType,
    required this.maxLength,
  });

  final List<TextEditingController> controllers;
  final String sufficText;
  final TextInputType keyboardType;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return Container(
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
            Column(
              children: [
                Row(
                  children: [
                    Text(AppString.morning.tr),
                    SizedBox(width: RS.w10 * 2),
                    Expanded(
                      child: CustomTextFormField(
                        maxLength: maxLength,
                        keyboardType: keyboardType,
                        controller: controllers[0],
                        sufficIcon: Text(
                          sufficText,
                          style: textFieldSufficStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: RS.h10),
                Row(
                  children: [
                    Text(AppString.lunch.tr),
                    SizedBox(width: RS.w10 * 2),
                    Expanded(
                      child: CustomTextFormField(
                        maxLength: maxLength,
                        controller: controllers[1],
                        keyboardType: keyboardType,
                        sufficIcon: Text(
                          sufficText,
                          style: textFieldSufficStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: RS.h10),
                Row(
                  children: [
                    Text(AppString.evening.tr),
                    SizedBox(width: RS.w10 * 2),
                    Expanded(
                      child: CustomTextFormField(
                        maxLength: maxLength,
                        controller: controllers[2],
                        keyboardType: keyboardType,
                        sufficIcon: Text(
                          sufficText,
                          style: textFieldSufficStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
