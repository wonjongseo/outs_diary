import 'dart:math';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/user_model.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:ours_log/services/permission_service.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding8.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:ours_log/services/notification_service.dart';
import 'package:ours_log/views/home/main_screen.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding1/onBoarding1.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding2/onBoarding2.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding3/onBoarding3.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding5.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding6.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding7.dart';

class OnboardingController extends GetxController {
  // For OnBoarding2
  int backgroundIndex = 0;
  void setBackgroundIndex(int index) {
    backgroundIndex = index;
    update();
  }

  // For OnBoarding3
  int fealIconIndex = 0;
  void setFealIconIndex(int index) {
    fealIconIndex = index;
    update();
  }

  // For OnBoarding5
  bool? isDrinkingPill;
  void onTapIsDrinkPill(bool value) {
    isDrinkingPill = value;
    update();
  }

  // For OnBoarding6
  bool isShownMLE = true;
  bool isShownDays = false;
  List<DayPeriodType> pillTimeDayPeriod = []; // 0:아침, 1:점심, 2: 저녁
  List<WeekDayType> selectedWeekDays = []; // 0:월, 1: 화

  void onSelectMorningLunchEvening(DayPeriodType index) {
    bool isSelected = pillTimeDayPeriod.contains(index);
    if (isSelected) {
      pillTimeDayPeriod.remove(index);
    } else {
      pillTimeDayPeriod.add(index);
    }
    update();
  }

  void onSelectDays(WeekDayType index) {
    bool isSelected = selectedWeekDays.contains(index);
    if (isSelected) {
      selectedWeekDays.remove(index);
    } else {
      selectedWeekDays.add(index);
    }
    update();
  }

  // For OnBoarding7
  bool isAlermEnable = false;
  String morningTime = '08:30';
  String lunchTime = '12:30';
  String eveningTime = '18:30';
  NotificationService notificationService = NotificationService();

  // For OnBoarding8
  int selectedColorIndex = 0;

  int pageIndex = 0;
  late PageController pageController;
  Duration pageDuration = const Duration(milliseconds: 200);
  Curve pageCurves = Curves.linear;

  void backToPage() {
    if (pageIndex == 6 && isDrinkingPill == null) {
      pageIndex -= 3;
    } else {
      pageIndex--;
    }

    pageController.jumpToPage(pageIndex);
    update();
  }

  void goToNextPage() {
    if (pageIndex == 3 && (isDrinkingPill ?? false) == false) {
      pageIndex += 2;
    } else {
      if (pageIndex == 4 && (isShownMLE == false || isShownDays == false)) {
        if (isShownMLE == false && isShownDays == false) {
          isShownMLE = true;
        } else if (isShownMLE && isShownDays == false) {
          isShownDays = true;
        }

        update();
        return;
      }
    }

    if (pageIndex == bodys.length - 1) {
      goToMainScreenAndSaveUserData();
      return;
    }
    pageIndex++;
    pageController.jumpToPage(pageIndex);

    update();
  }

  void togglePillAlarm(int v) {
    if (v == 0) {
      isAlermEnable = true;
      PermissionService().permissionWithNotification();
    } else {
      isAlermEnable = false;
    }

    update();
  }

  String getAlramTimeDayPeriod(DayPeriodType dayPeriodType) {
    switch (dayPeriodType) {
      case DayPeriodType.morning:
        return morningTime;
      case DayPeriodType.afternoon:
        return lunchTime;
      case DayPeriodType.evening:
        return eveningTime;
    }
  }

  void changePillTime(DayPeriodType dayPeriodType, BuildContext context) async {
    String pillTime = getAlramTimeDayPeriod(dayPeriodType);
    int hour = int.tryParse(pillTime.split(':')[0]) ?? 0;
    int minute = int.tryParse(pillTime.split(':')[1]) ?? 0;

    TimeOfDay? timeOfDay = await AppFunction.pickTime(
      context,
      helpText: AppString.plzAlarmTime.tr,
      errorInvalidText: AppString.plzInputCollectTime.tr,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );

    if (timeOfDay == null) {
      return;
    }
    switch (dayPeriodType) {
      case DayPeriodType.morning:
        morningTime = '${timeOfDay.hour}:${timeOfDay.minute}';
        break;
      case DayPeriodType.afternoon:
        lunchTime = '${timeOfDay.hour}:${timeOfDay.minute}';
        break;
      case DayPeriodType.evening:
        eveningTime = '${timeOfDay.hour}:${timeOfDay.minute}';
        break;
    }

    update();
  }

  void goToMainScreenAndSaveUserData() async {
    List<TaskModel> tasks = [];

    selectedWeekDays.sort((a, b) => a.index.compareTo(b.index));
    List<int> days = List.generate(
        selectedWeekDays.length, (index) => selectedWeekDays[index].index + 1);

    for (int day in days) {
      for (DayPeriodType pillTime in pillTimeDayPeriod) {
        int hour = int.parse(getAlramTimeDayPeriod(pillTime).split(':')[0]);
        int minute = int.parse(getAlramTimeDayPeriod(pillTime).split(':')[1]);
        int id = AppFunction.createIdByDay(day, hour, minute);

        DateTime now = tz.TZDateTime.now(tz.local);
        DateTime? taskTime =
            tz.TZDateTime(tz.local, now.year, now.month, day, hour, minute);

        if (isAlermEnable) {
          String message = isEn
              ? '(${intDayToString(day)}) ${getAlramTimeDayPeriod(pillTime)} ${AppString.timeToDrink.tr}'
              : '(${intDayToString(day)}) $hour${AppString.hour.tr} $minute${AppString.minute.tr} ${AppString.timeToDrink.tr}';

          taskTime = await notificationService.scheduleWeeklyNotification(
            title: '💊 (${pillTime.label}) ${AppString.drinkPillAlram.tr}',
            message: message,
            channelDescription: AppString.pillcCannelDescription.tr,
            id: id,
            weekday: day,
            hour: hour,
            minute: minute,
          );
        }

        if (taskTime == null) {
          break;
        }

        tasks.add(
          TaskModel(
            taskName: '${pillTime.label}${AppString.pillText.tr}',
            taskDate: taskTime,
            notifications: [
              NotificationModel(notiDateTime: taskTime, alermId: id)
            ],
            isRegular: true,
          ),
        );
      }
    }

    UserModel userModel = UserModel(
      selectedPillDays: selectedWeekDays,
      backgroundIndex: backgroundIndex,
      fealIconIndex: fealIconIndex,
      colorIndex: selectedColorIndex,
      tasks: tasks,
      dayPeriodTypes: pillTimeDayPeriod,
    );

    userController.saveUser(userModel);

    Get.off(() => const MainScreen());

    AppSnackbar.showSuccessMsgSnackBar(
      AppString.completeSetting.tr,
      duration: const Duration(minutes: 1),
    );
  }

  UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    pageController = PageController(initialPage: pageIndex);
    setBodys();
    super.onInit();
  }

  void setBodys() {
    bodys.addAll([
      const OnBoarding1(),
      FadeInRight(child: const OnBoarding2()),
      FadeInRight(child: const OnBoarding3()),
      FadeInRight(child: const Onboarding5()),
      FadeInRight(child: const Onboarding6()),
      FadeInRight(child: const Onboarding7()),
      FadeInRight(child: const Onboarding8()),
    ]);
  }

  List<Widget> bodys = [];
}
