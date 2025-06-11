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
    //하루에 몇번 드시고 계신가요
    var textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    return GetBuilder<OnboardingController>(builder: (onboardingController) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (onboardingController.isShownMLE)
            FadeInRight(
              child: Column(
                children: [
                  Text(AppString.whatTimeDoYouDrinkPill.tr, style: textStyle),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
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
          // 어떤 요일에 복용하고 계신가요
          if (onboardingController.isShownDays)
            FadeInRight(
              child: Column(
                children: [
                  Text(AppString.whatWeekDayYouDrink.tr, style: textStyle),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        WeekDayType.values.length + 1,
                        (index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () =>
                                  onboardingController.onClickEveryDay(),
                              child: Container(
                                width: 80,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      onboardingController.isEveryDaySelected()
                                          ? Border.all(
                                              color: AppColors.primaryColor,
                                              width: 2)
                                          : Border.all(color: Colors.grey),
                                ),
                                child:
                                    Center(child: Text(AppString.everyDay.tr)),
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: () => onboardingController.onSelectWeekdays(
                                WeekDayType.values[index - 1]),
                            child: Container(
                              width: 80,
                              height: 60,
                              decoration: BoxDecoration(
                                  border: onboardingController.selectedWeekDays
                                          .contains(
                                              WeekDayType.values[index - 1])
                                      ? Border.all(
                                          color: AppColors.primaryColor,
                                          width: 2)
                                      : Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child:
                                    Text(WeekDayType.values[index - 1].label),
                              ),
                            ),
                          );
                        },
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
