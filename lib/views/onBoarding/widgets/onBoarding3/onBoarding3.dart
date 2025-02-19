import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';

import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/feal_icon_row.dart';
import 'package:ours_log/controller/onboarding_controller.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.8,
            fontWeight: FontWeight.bold,
            fontSize: RS.width18,
          ),
          TextSpan(text: AppString.plzSelectFealIcon.tr),
        ),
        SizedBox(height: RS.h10),
        GetBuilder<OnboardingController>(builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: RS.w10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                AppConstant.fealIconLists.length,
                (index) {
                  bool isSelected = controller.fealIconIndex == index;
                  return GestureDetector(
                    onTap: () => controller.setFealIconIndex(index),
                    child: FealIconRow(
                      isSelected: isSelected,
                      fealIcon: AppConstant.fealIconLists[index],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
