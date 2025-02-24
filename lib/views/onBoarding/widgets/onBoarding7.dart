import 'package:ours_log/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_toggle_btn.dart';
import 'package:ours_log/controller/onboarding_controller.dart';
import 'package:ours_log/models/day_period_type.dart';

class Onboarding7 extends StatelessWidget {
  const Onboarding7({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(builder: (cn) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: RS.w10 * 2,
          vertical: RS.h10,
        ),
        child: Column(
          children: [
            Text(AppString.doYouAlarmWhenDrinkPill.tr),
            SizedBox(height: RS.h10 * 1.5),
            CustomToggleBtn(
              onTap: cn.togglePillAlarm,
              isSelected: [cn.isAlermEnable, !cn.isAlermEnable],
              isChecked: cn.isAlermEnable,
            ),
            SizedBox(height: RS.h10 * 3),
            Column(
              children: List.generate(cn.pillTimeDayPeriod.length, (index) {
                return GestureDetector(
                  onTap: !cn.isAlermEnable
                      ? null
                      : () => cn.changePillTime(
                          cn.pillTimeDayPeriod[index], context),
                  child: AppointPillTime(
                    title: cn.pillTimeDayPeriod[index].label,
                    time: cn.getAlramTimeDayPeriod(cn.pillTimeDayPeriod[index]),
                    isAlermEnable: cn.isAlermEnable,
                  ),
                );
              }),
            ),
            if (1 == 2)
              Column(
                children: [
                  if (cn.pillTimeDayPeriod.contains(DayPeriodType.morning))
                    GestureDetector(
                      onTap: !cn.isAlermEnable
                          ? null
                          : () =>
                              cn.changePillTime(DayPeriodType.morning, context),
                      child: AppointPillTime(
                        title: AppString.morning.tr,
                        time: cn.morningTime,
                        isAlermEnable: cn.isAlermEnable,
                      ),
                    ),
                  if (cn.pillTimeDayPeriod.contains(DayPeriodType.afternoon))
                    GestureDetector(
                      onTap: !cn.isAlermEnable
                          ? null
                          : () => cn.changePillTime(
                              DayPeriodType.afternoon, context),
                      child: AppointPillTime(
                        isAlermEnable: cn.isAlermEnable,
                        title: AppString.lunch.tr,
                        time: cn.lunchTime,
                      ),
                    ),
                  if (cn.pillTimeDayPeriod.contains(DayPeriodType.evening))
                    GestureDetector(
                      onTap: !cn.isAlermEnable
                          ? null
                          : () =>
                              cn.changePillTime(DayPeriodType.evening, context),
                      child: AppointPillTime(
                        isAlermEnable: cn.isAlermEnable,
                        title: AppString.evening.tr,
                        time: cn.eveningTime,
                      ),
                    ),
                ],
              )
          ],
        ),
      );
    });
  }
}

class AppointPillTime extends StatelessWidget {
  const AppointPillTime({
    super.key,
    required this.title,
    required this.time,
    required this.isAlermEnable,
  });
  final String title;
  final String time;
  final bool isAlermEnable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: RS.h10),
      padding: EdgeInsets.only(left: RS.w10 * 3, right: RS.w10 * 2),
      height: RS.h10 * 7.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RS.w10 * 2),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.timer,
                color: isAlermEnable ? null : Colors.grey,
              ),
              SizedBox(width: RS.w10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: RS.w10 * 2,
                  color: isAlermEnable ? null : Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            height: RS.h10 * 4,
            padding: EdgeInsets.symmetric(horizontal: RS.w10),
            decoration: BoxDecoration(
              color: isAlermEnable
                  ? AppColors.primaryColor.withValues(alpha: .8)
                  : Colors.grey,
              borderRadius: BorderRadius.circular(RS.w10 * 1.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isAlermEnable ? null : Colors.grey,
                  ),
                ),
                SizedBox(width: RS.w10),
                const Icon(Icons.keyboard_arrow_down)
              ],
            ),
          )
        ],
      ),
    );
  }
}
