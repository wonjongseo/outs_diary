import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

import 'package:ours_log/controller/onboarding_controller.dart';

class Onboarding8 extends StatelessWidget {
  const Onboarding8({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10 * 2,
          vertical: 10,
        ),
        child: Column(children: [
          Text(AppString.plzInputAppColor.tr),
          SizedBox(height: 10 * 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  controller.selectedColorIndex = 0;
                  controller.update();
                },
                child: CircleAvatar(
                  radius: 10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.priPinkClr,
                  child: controller.selectedColorIndex == 0
                      ? Icon(Icons.done)
                      : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.selectedColorIndex = 1;
                  controller.update();
                },
                child: CircleAvatar(
                  child: controller.selectedColorIndex == 1
                      ? Icon(Icons.done)
                      : null,
                  radius: 10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.priYellowClr,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.selectedColorIndex = 2;
                  controller.update();
                },
                child: CircleAvatar(
                  radius: 10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.priGreenClr,
                  child: controller.selectedColorIndex == 2
                      ? Icon(Icons.done)
                      : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.selectedColorIndex = 3;
                  controller.update();
                },
                child: CircleAvatar(
                  radius: 10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.priBluishClr,
                  child: controller.selectedColorIndex == 3
                      ? Icon(Icons.done)
                      : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.selectedColorIndex = 4;
                  controller.update();
                },
                child: CircleAvatar(
                  radius: 10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.priPubbleClr,
                  child: controller.selectedColorIndex == 4
                      ? Icon(Icons.done)
                      : null,
                ),
              ),
            ],
          )
        ]),
      );
    });
  }
}
