import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ours_log/common/enums/gender_type.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/views/home/main_screen.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding1/onBoarding1.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding3/onBoarding3.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding2/onBoarding2.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding4/onBoarding4.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding5.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding6.dart';

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

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageIndex = 0;
  late PageController pageController;

  Duration pageDuration = const Duration(milliseconds: 200);
  Curve pageCurves = Curves.linear;

  bool isShownMLE = false;
  bool isShownDays = false;

  late List<Widget> bodys;
  @override
  void initState() {
    pageController = PageController(initialPage: pageIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      bodys = [
        const OnBoarding1(),
        const OnBoarding2(),
        const OnBoarding3(),
        const Onboarding5(),
        if (userController.isDrinkingPill ?? false)
          Onboarding6(
            isShownMLE: isShownMLE,
            isShownDays: isShownDays,
          ),
      ];
      return Scaffold(
        appBar: _appBar(),
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
                      itemCount: bodys.length,
                      controller: pageController,
                      itemBuilder: (context, index) {
                        return bodys[index];
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

  AppBar _appBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: backToPage,
            child: Text(AppString.back.tr),
          ),
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
              value: ((10 / bodys.length) * (pageIndex + 1) / 10).toDouble(),
              color: Colors.pinkAccent,
            ),
          ),
          SizedBox(width: RS.w10 * 3),
        ],
      ),
    );
  }

  Widget _nextBtn() {
    return SafeArea(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: goToNextPage,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: RS.w10),
          height: RS.h10 * 6,
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              pageIndex == bodys.length - 1
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

  void backToPage() {
    pageIndex--;
    pageController.previousPage(
      duration: pageDuration,
      curve: pageCurves,
    );
    setState(() {});
  }

  void goToNextPage() {
    if (pageIndex == 4 && (isShownMLE == false || isShownDays == false)) {
      if (isShownMLE == false && isShownDays == false) {
        isShownMLE = true;
      } else if (isShownMLE && isShownDays == false) {
        isShownDays = true;
      }

      setState(() {});
      return;
    }

    if (pageIndex == bodys.length - 1) {
      Get.off(() => const MainScreen());
      return;
    }
    pageIndex++;
    pageController.nextPage(
      duration: pageDuration,
      curve: pageCurves,
    );
    setState(() {});
  }
}
