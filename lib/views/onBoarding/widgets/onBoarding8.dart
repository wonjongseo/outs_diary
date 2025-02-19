import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/onboarding_controller.dart';

class Onboarding8 extends StatelessWidget {
  const Onboarding8({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(builder: (controller) {
      print('controller.backgroundIndex : ${controller.backgroundIndex}');

      return Column(children: [
        Text('앱의 메인 색상을 선택해주세요!'),
        SizedBox(height: RS.h10 * 3),
        // Text('앱의 메인 색상을 선택해주세요!'),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  controller.selectedColorIndex = 0;
                  controller.update();
                },
                child: CircleAvatar(
                  radius: RS.w10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.pinkClr,
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
                  radius: RS.w10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.yellowClr,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.selectedColorIndex = 2;
                  controller.update();
                },
                child: CircleAvatar(
                  radius: RS.w10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.greenClr,
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
                  radius: RS.w10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.bluishClr,
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
                  radius: RS.w10 * 3,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.pubbleClr,
                  child: controller.selectedColorIndex == 4
                      ? Icon(Icons.done)
                      : null,
                ),
              ),
            ],
          ),
        )
      ]);
    });
  }
}
