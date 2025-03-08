import 'package:get/utils.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

import 'package:ours_log/controller/onboarding_controller.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/week_day_type.dart';

class Onboarding6 extends StatelessWidget {
  const Onboarding6({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10 * 1.8,
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
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                          List.generate(DayPeriodType.values.length, (index) {
                        return GestureDetector(
                          onTap: () =>
                              onboardingController.onSelectMorningLunchEvening(
                            DayPeriodType.values[index],
                          ),
                          child: Container(
                            width: 10 * 10,
                            height: 10 * 10,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border: onboardingController.pillTimeDayPeriod
                                        .contains(DayPeriodType.values[index])
                                    ? Border.all(
                                        color: AppColors.primaryColor, width: 2)
                                    : Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10 * 2.5)),
                            child: Center(
                              child: Text(DayPeriodType.values[index].label),
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
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          WeekDayType.values.length,
                          (index) {
                            return GestureDetector(
                              onTap: () =>
                                  onboardingController.onSelectWeekdays(
                                WeekDayType.values[index],
                              ),
                              child: Container(
                                width: 10 * 8,
                                height: 10 * 10,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    border: onboardingController
                                            .selectedWeekDays
                                            .contains(WeekDayType.values[index])
                                        ? Border.all(
                                            color: AppColors.primaryColor,
                                            width: 2)
                                        : Border.all(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.circular(10 * 1.5)),
                                child: Center(
                                  child: Text(WeekDayType.values[index].label),
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
