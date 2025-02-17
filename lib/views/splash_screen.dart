import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/image_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/views/onBoarding/onBoarding_screen.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding1/onBoarding1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initControllers();
    navigate();
    super.initState();
  }

  initControllers() async {
    Get.put(UserController());
    Get.put(DiaryController());
    Get.put(HospitalLogController());
    Get.put(ImageController());
  }

  void navigate() async {
    await Future.delayed(Duration(milliseconds: 500));
    Get.off(() => OnBoardingScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImagePath.appIcon,
          width: RS.w10 * 30,
        ),
      ),
    );
  }
}
