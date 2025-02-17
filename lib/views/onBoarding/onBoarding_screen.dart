import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ours_log/common/enums/gender_type.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/onboarding_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/views/home/main_screen.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding1/onBoarding1.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding3/onBoarding3.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding2/onBoarding2.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding5.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding6.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding7.dart';

class DisplayArticle {
  final String label;
  final String description;
  List<IconData> icons;
  DisplayArticle({
    required this.label,
    required this.description,
    required this.icons,
  });
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  OnboardingController onboardingController = Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(builder: (onboardingController) {
      return Scaffold(
        appBar: _appBar(context),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: RS.h10,
                horizontal: RS.w10,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: onboardingController.bodys.length,
                      controller: onboardingController.pageController,
                      itemBuilder: (context, index) {
                        return onboardingController.bodys[index];
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _nextBtn(),
      );
    });
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (onboardingController.pageIndex != 0)
            TextButton(
              onPressed: onboardingController.backToPage,
              child: Text(AppString.back.tr),
            ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .75,
            child: LinearProgressIndicator(
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
              value: ((10 / onboardingController.bodys.length) *
                      (onboardingController.pageIndex + 1) /
                      10)
                  .toDouble(),
              color: Colors.pinkAccent,
            ),
          ),
          if (onboardingController.pageIndex == 0) SizedBox(width: RS.w10 * 3),
        ],
      ),
    );
  }

  Widget _nextBtn() {
    return SafeArea(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onboardingController.goToNextPage,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: RS.w10),
          height: RS.h10 * 6,
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              onboardingController.pageIndex ==
                      onboardingController.bodys.length - 1
                  ? AppString.start.tr
                  : AppString.next.tr,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: RS.width20,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
