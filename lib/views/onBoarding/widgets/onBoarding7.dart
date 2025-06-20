import 'package:ours_log/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

import 'package:ours_log/common/widgets/custom_toggle_btn.dart';
import 'package:ours_log/controller/onboarding_controller.dart';
import 'package:ours_log/models/day_period_type.dart';

class Onboarding7 extends StatelessWidget {
  const Onboarding7({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(builder: (cn) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(AppString.doYouAlarmWhenDrinkPill.tr),
            const SizedBox(height: 15),
            CustomToggleBtn(
              onTap: cn.togglePillAlarm,
              isSelected: [cn.isAlermEnable, !cn.isAlermEnable],
              isChecked: cn.isAlermEnable,
            ),
            const SizedBox(height: 30),
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(left: 30, right: 20),
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: isAlermEnable ? null : Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: isAlermEnable
                  ? AppColors.primaryColor.withValues(alpha: .8)
                  : Colors.grey,
              borderRadius: BorderRadius.circular(15),
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
                const SizedBox(width: 10),
                const Icon(Icons.keyboard_arrow_down)
              ],
            ),
          )
        ],
      ),
    );
  }
}
