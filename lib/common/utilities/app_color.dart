import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/controller/onboarding_controller.dart';
import 'package:ours_log/controller/user_controller.dart';

class AppColors {
  AppColors._();

  // static Color getPrimaryColor(int index) {
  //   if (Get.isDarkMode) {
  //     print('Dark');

  //     switch (index) {
  //       case 0:
  //         return darkPinkClr;
  //       case 1:
  //         return darkYellowClr;
  //       case 2:
  //         return darkGreenClr;
  //       case 3:
  //         return darkBluishClr;
  //       case 4:
  //         return darkPubbleClr;
  //       default:
  //         return darkPinkClr;
  //     }
  //   } else {
  //     print('Light');
  //     switch (index) {
  //       case 0:
  //         return pinkClr;
  //       case 1:
  //         return yellowClr;
  //       case 2:
  //         return greenClr;
  //       case 3:
  //         return bluishClr;
  //       case 4:
  //         return pubbleClr;
  //       default:
  //         return pinkClr;
  //     }
  //   }
  // }

  static Color get primaryColor {
    int selectedColorIndex = 0;
    if (Get.isRegistered<OnboardingController>()) {
      OnboardingController onboardingController =
          Get.find<OnboardingController>();
      selectedColorIndex = onboardingController.selectedColorIndex;
    }

    if (Get.isRegistered<UserController>()) {
      UserController userController = Get.find<UserController>();
      if (userController.userModel != null) {
        selectedColorIndex = userController.userModel!.colorIndex ?? 3;
      }
    }

    if (Get.isDarkMode) {
      switch (selectedColorIndex) {
        case 0:
          return darkPinkClr;
        case 1:
          return darkYellowClr;
        case 2:
          return darkGreenClr;
        case 3:
          return darkBluishClr;
        case 4:
          return darkPubbleClr;
      }
    } else {
      switch (selectedColorIndex) {
        case 0:
          return pinkClr;
        case 1:
          return yellowClr;
        case 2:
          return greenClr;
        case 3:
          return bluishClr;

        case 4:
          return pubbleClr;
      }
    }

    return pubbleClr;
  }

  static const Color pinkClr = Color(0xFFff4667);
  static const Color yellowClr = Color(0xFFFFB746);
  static const Color greenClr = Color(0xFF00C853);
  static const Color bluishClr = Color(0xFF4e5ae8);
  static const Color pubbleClr = Color(0xFF6200EA);

  static const Color darkPinkClr = Color(0xFFb32d4c);
  static const Color darkYellowClr = Color(0xFFb27934);
  static const Color darkGreenClr = Color(0xFF007a38);
  static const Color darkBluishClr = Color(0xFF3a44b7);
  static const Color darkPubbleClr = Color(0xFF3e009e);

  static const Color darkPinkClr2 = Color(0xFFcc0033);
  static const Color darkYellowClr2 = Color(0xFFcc7a00);
  static const Color darkGreenClr2 = Color(0xFF007A3D);
  static const Color darkBluishClr2 = Color(0xFF3D5AFE);
  static const Color darkPubbleClr2 = Color(0xFF3700B3);

  static const Color darkPinkClrSecondary2 = Color(0xFF4A148C);
  static const Color darkYellowClrSecondary2 = Color(0xFF009688);
  static const Color darkGreenClrSecondary2 = Color(0xFFB71C1C);
  static const Color darkBluishClrSecondary2 = Color(0xFF1A237E);
  static const Color darkPubbleClrSecondary2 = Color(0xFF880E4F);

  //
  static const Color secondaryColor = Color(0xFFFC2E20);
  static const Color greenDark = Color(0xFF00A884);
  static const Color greenLight = Color(0xFF008069);

  static const Color greyDark = Color(0xFF8696A0);
  static const Color greyLight = Color(0xFF667781);
  static const Color black = Color(0xFF111B21);
  static const Color white = Color(0xFFFFFFFF);
  // static const Color white = Color(0xFFFFF5F5);
  // static const Color white = Color(0xFFE7F2F8);
  static const Color greyBackground = Color(0xFF202C33);
}
