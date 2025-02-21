import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/day_period_type.dart';

class InputHealthDayPeriod extends StatelessWidget {
  const InputHealthDayPeriod({
    super.key,
    required this.controllers,
    required this.sufficText,
    required this.keyboardType,
    required this.maxLength,
    this.hintText,
    this.hintText2,
    this.controllers2,
  });

  final String? hintText;
  final String? hintText2;
  final List<TextEditingController> controllers;
  final List<TextEditingController>? controllers2;
  final String sufficText;
  final TextInputType keyboardType;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
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
                        maxLength: maxLength,
                        keyboardType: keyboardType,
                        hintText: hintText,
                        controller: controllers[index],
                        sufficIcon: Text(
                          sufficText,
                          style: textFieldSufficStyle,
                        ),
                      ),
                    ),
                    if (controllers2 != null) ...[
                      SizedBox(width: RS.w10),
                      Expanded(
                        child: CustomTextFormField(
                          keyboardType: TextInputType.number,
                          hintText: hintText2,
                          controller: controllers2![index],
                          maxLength: 3,
                          sufficIcon: Text(
                            sufficText,
                            style: textFieldSufficStyle,
                          ),
                        ),
                      ),
                    ]
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
