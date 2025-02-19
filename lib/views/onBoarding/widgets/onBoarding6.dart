import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';

import 'package:ours_log/controller/onboarding_controller.dart';

class Onboarding6 extends StatelessWidget {
  const Onboarding6({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: RS.w10 * 1.8,
    );
    return GetBuilder<OnboardingController>(builder: (onboardingController) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (onboardingController.isShownMLE)
            FadeInRight(
              child: Column(
                children: [
                  Text(AppString.whatTimeDoYouDrinkPill.tr, style: textStyle),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: RS.h10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                          List.generate(morningLunchEvening.length, (index) {
                        return GestureDetector(
                          onTap: () => onboardingController
                              .onSelectMorningLunchEvening(index),
                          child: Container(
                            width: RS.w10 * 10,
                            height: RS.w10 * 10,
                            margin:
                                EdgeInsets.symmetric(horizontal: RS.w10 / 2),
                            decoration: BoxDecoration(
                                border: onboardingController
                                        .selectedMorningLunchEvening
                                        .contains(index)
                                    ? Border.all(
                                        color: AppColors.primaryColor, width: 2)
                                    : Border.all(color: Colors.grey, width: 1),
                                borderRadius:
                                    BorderRadius.circular(RS.w10 * 2.5)),
                            child: Center(
                              child: Text(morningLunchEvening[index]),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          if (onboardingController.isShownDays)
            FadeInRight(
              child: Column(
                children: [
                  Text(AppString.whatWeekDayYouDrink.tr, style: textStyle),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: RS.h10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          dayKo.length,
                          (index) {
                            return GestureDetector(
                              onTap: () =>
                                  onboardingController.onSelectDays(index),
                              child: Container(
                                width: RS.w10 * 8,
                                height: RS.w10 * 10,
                                margin: EdgeInsets.symmetric(
                                    horizontal: RS.w10 / 2),
                                decoration: BoxDecoration(
                                    border: onboardingController.selectedDays
                                            .contains(index)
                                        ? Border.all(
                                            color: AppColors.primaryColor,
                                            width: 2)
                                        : Border.all(
                                            color: Colors.grey, width: 1),
                                    borderRadius:
                                        BorderRadius.circular(RS.w10 * 1.5)),
                                child: Center(
                                  child: Text(dayKo[index]),
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
            )
        ],
      );
    });
  }
}
//월 수 금  일

List<String> morningLunchEvening = [
  AppString.morning.tr,
  AppString.lunch.tr,
  AppString.evening.tr
];

List<String> dayKo = [
  AppString.monday.tr,
  AppString.tuesday.tr,
  AppString.wednesday.tr,
  AppString.thursday.tr,
  AppString.friday.tr,
  AppString.saturday.tr,
  AppString.sunday.tr,
];
