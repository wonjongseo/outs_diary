import 'package:get/utils.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

import 'package:ours_log/controller/onboarding_controller.dart';

class Onboarding5 extends StatelessWidget {
  const Onboarding5({super.key});

  @override
  Widget build(BuildContext context) {
    // 약을 복용중이신가요?
    Size size = MediaQuery.of(context).size;
    return GetBuilder<OnboardingController>(builder: (onboardingController) {
      return Column(
        children: [
          Text(
            AppString.doYouDrinkPill.tr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => onboardingController.onTapIsDrinkPill(true),
                child: Container(
                  width: size.width / 3 - 30,
                  height: size.width / 3 - 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: onboardingController.isDrinkingPill != null &&
                            onboardingController.isDrinkingPill == true
                        ? Border.all(color: AppColors.primaryColor, width: 2)
                        : Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.yesText.tr),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => onboardingController.onTapIsDrinkPill(false),
                child: Container(
                  width: size.width / 3 - 30,
                  height: size.width / 3 - 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: onboardingController.isDrinkingPill != null &&
                            onboardingController.isDrinkingPill == false
                        ? Border.all(color: AppColors.primaryColor, width: 2)
                        : Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.noText.tr),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
