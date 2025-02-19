import 'package:ours_log/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/onboarding_controller.dart';

class Onboarding7 extends StatefulWidget {
  const Onboarding7({super.key});

  @override
  State<Onboarding7> createState() => _Onboarding7State();
}

class _Onboarding7State extends State<Onboarding7> {
  @override
  Widget build(BuildContext context) {
    OnboardingController userController = Get.find<OnboardingController>();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.w10 * 2,
        vertical: RS.h10,
      ),
      child: Column(
        children: [
          Text(AppString.doYouAlarmWhenDrinkPill.tr),
          SizedBox(height: RS.h10 * 1.5),
          ToggleButtons(
            onPressed: (v) {
              setState(() {
                v == 0
                    ? userController.isAlermEnable = true
                    : userController.isAlermEnable = false;
              });
            },
            borderRadius: BorderRadius.circular(20),
            isSelected: [
              userController.isAlermEnable,
              !userController.isAlermEnable
            ],
            children: [
              Text(
                'ON',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: userController.isAlermEnable
                      ? AppColors.primaryColor
                      : null,
                ),
              ),
              Text(
                'OFF',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: !userController.isAlermEnable
                        ? AppColors.primaryColor
                        : null),
              )
            ],
          ),
          SizedBox(height: RS.h10 * 3),
          if (userController.selectedMorningLunchEvening.contains(0))
            GestureDetector(
              onTap: !userController.isAlermEnable
                  ? null
                  : () async {
                      TimeOfDay? timeOfDay = await AppFunction.pickTime(context,
                          helpText: AppString.plzAlarmTime.tr,
                          errorInvalidText: AppString.plzInputCollectTime.tr);
                      if (timeOfDay == null) {
                        return;
                      }
                      userController.morningTime =
                          '${timeOfDay.hour}:${timeOfDay.minute}';
                      setState(() {});
                    },
              child: AppointPillTime(
                title: AppString.morning.tr,
                time: userController.morningTime,
                isAlermEnable: userController.isAlermEnable,
              ),
            ),
          if (userController.selectedMorningLunchEvening.contains(1))
            GestureDetector(
              onTap: !userController.isAlermEnable
                  ? null
                  : () async {
                      TimeOfDay? timeOfDay = await AppFunction.pickTime(context,
                          helpText: AppString.plzAlarmTime.tr,
                          errorInvalidText: AppString.plzInputCollectTime.tr);
                      if (timeOfDay == null) {
                        return;
                      }
                      userController.lunchTime =
                          '${timeOfDay.hour}:${timeOfDay.minute}';
                      setState(() {});
                    },
              child: AppointPillTime(
                isAlermEnable: userController.isAlermEnable,
                title: AppString.lunch.tr,
                time: userController.lunchTime,
              ),
            ),
          if (userController.selectedMorningLunchEvening.contains(2))
            GestureDetector(
              onTap: !userController.isAlermEnable
                  ? null
                  : () async {
                      TimeOfDay? timeOfDay = await AppFunction.pickTime(context,
                          helpText: AppString.plzAlarmTime.tr,
                          errorInvalidText: AppString.plzInputCollectTime.tr);
                      if (timeOfDay == null) {
                        return;
                      }
                      userController.eveningTime =
                          '${timeOfDay.hour}:${timeOfDay.minute}';
                      setState(() {});
                    },
              child: AppointPillTime(
                isAlermEnable: userController.isAlermEnable,
                title: AppString.evening.tr,
                time: userController.eveningTime,
              ),
            ),
        ],
      ),
    );
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
                    fontSize: RS.w10 * 1.8,
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
