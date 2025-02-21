import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/image_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/models/user_model.dart';
import 'package:ours_log/respository/user_respository.dart';
import 'package:ours_log/views/home/main_screen.dart';
import 'package:ours_log/views/onBoarding/onBoarding_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    navigate();
  }

  UserModelRepository userModelRepository = UserModelRepository();

  void navigate() async {
    UserModel? users = await userModelRepository.loadUser();

    await Future.delayed(const Duration(milliseconds: 500));
    if (users == null) {
      Get.off(() => OnBoardingScreen());
    } else {
      Get.off(() => const MainScreen());
    }
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
