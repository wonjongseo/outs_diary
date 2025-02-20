import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/add_diary_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/add_diary/widgets/morning_lunch_evening_temp_and_pulse_widget.dart';

class HealthInfoTextFields extends StatelessWidget {
  const HealthInfoTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    AddDiaryController addDiaryController = Get.find<AddDiaryController>();
    return GetBuilder<UserController>(builder: (userController) {
      return CustomExpansionCard(
        title: AppString.health.tr,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: RS.w10),
          child: Column(
            children: [
              MorningLunchEveningTempAndPulseWidget(
                keyboardType: TextInputType.number,
                maxLength: 3,
                controllers: addDiaryController.temperatureCtls,
                label: AppString.temperature.tr,
                sufficText: '°C',
                // enableMorLunEvenTextField:
                //     userController.userModel!.enableMorLunEvenTempTextField!,
              ),
              MorningLunchEveningTempAndPulseWidget(
                keyboardType: TextInputType.number,
                maxLength: 3,
                controllers: addDiaryController.pulseCtls,
                label: AppString.pulse.tr,
                sufficText: '回/min',
                // enableMorLunEvenTextField:
                //     userController.userModel!.enableMorLunEvenPulseTextField!,
              ),
              MorningLunchEveningTempAndPulseWidget(
                keyboardType: TextInputType.number,
                maxLength: 3,
                controllers: addDiaryController.maxBloodPressureCtls,
                label: AppString.bloodPressure.tr,
                sufficText: 'mm Hg',
                // enableMorLunEvenTextField: userController
                //     .userModel!.enableMorLunEvenBloodPressureTextField!,
              ),
              ColTextAndWidget(
                label: '체중',
                widget: CustomTextFormField(
                  controller: addDiaryController.weightCtls[0],
                  hintText: AppString.weight.tr,
                  sufficIcon: Text(
                    'kg',
                    style: textFieldSufficStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
