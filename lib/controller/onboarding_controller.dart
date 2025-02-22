import 'dart:math';

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
  List<int> selectedMorningLunchEvening = []; // 0:아침, 1:점심, 2: 저녁
  List<WeekDayType> selectedDays = []; // 0:월, 1: 화

  void onSelectMorningLunchEvening(int index) {
    bool isSelected = selectedMorningLunchEvening.contains(index);
    if (isSelected) {
      selectedMorningLunchEvening.remove(index);
    } else {
      selectedMorningLunchEvening.add(index);
    }
    update();
  }

  void onSelectDays(WeekDayType index) {
    bool isSelected = selectedDays.contains(index);
    if (isSelected) {
      selectedDays.remove(index);
    } else {
      selectedDays.add(index);
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
    print('togglePillAlarm');
    if (v == 0) {
      isAlermEnable = true;
      PermissionService().permissionWithNotification();
    } else {
      isAlermEnable = false;
    }

    update();
  }

  void changePillTime(DayPeriodType dayPeriodType, BuildContext context) async {
    TimeOfDay? timeOfDay = await AppFunction.pickTime(context,
        helpText: AppString.plzAlarmTime.tr,
        errorInvalidText: AppString.plzInputCollectTime.tr);

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
    List<String> times = [];
    List<DayPeriodType>? dayPeriodTypes = [];

    selectedDays.sort((a, b) => a.index.compareTo(b.index));
    List<int> days = List.generate(
        selectedDays.length, (index) => selectedDays[index].index + 1);

    if (selectedMorningLunchEvening.contains(0)) {
      times.add(morningTime);
      dayPeriodTypes.add(DayPeriodType.morning);
    }
    if (selectedMorningLunchEvening.contains(1)) {
      times.add(lunchTime);
      dayPeriodTypes.add(DayPeriodType.afternoon);
    }
    if (selectedMorningLunchEvening.contains(2)) {
      times.add(eveningTime);
      dayPeriodTypes.add(DayPeriodType.evening);
    }
    if (isAlermEnable) {
      for (int day in days) {
        if (selectedMorningLunchEvening.contains(0)) {
          int hour = int.parse(morningTime.split(':')[0]);
          int minute = int.parse(morningTime.split(':')[1]);
          int id = AppFunction.createIdByDay(day, hour, minute);

          DateTime? taskTime =
              await notificationService.scheduleWeeklyNotification(
            title:
                '💊 (${AppString.morning.tr}) ${AppString.drinkPillAlram.tr}',
            message:
                '(${intDayToString(day)}) $morningTime ${AppString.timeToDrink.tr}',
            channelDescription: AppString.pillcCannelDescription.tr,
            id: id,
            weekday: day,
            hour: hour,
            minute: minute,
          );

          if (taskTime == null) {
            break;
          }
          tasks.add(
            TaskModel(
              taskName: '${AppString.morning.tr}${AppString.pillText.tr}',
              taskDate: taskTime,
              notifications: [
                NotificationModel(notiDateTime: taskTime, alermId: id)
              ],
              isRegular: true,
            ),
          );
        }

        if (selectedMorningLunchEvening.contains(1)) {
          int hour = int.parse(lunchTime.split(':')[0]);
          int minute = int.parse(lunchTime.split(':')[1]);
          int id = AppFunction.createIdByDay(day, hour, minute);

          DateTime? taskTime =
              await notificationService.scheduleWeeklyNotification(
            title: '💊 (${AppString.lunch.tr}) ${AppString.drinkPillAlram.tr}',
            message:
                '(${intDayToString(day)}) $lunchTime ${AppString.timeToDrink.tr}',
            channelDescription: AppString.pillcCannelDescription.tr,
            id: id,
            weekday: day,
            hour: hour,
            minute: minute,
          );
          if (taskTime == null) {
            break;
          }
          tasks.add(
            TaskModel(
              taskName: '${AppString.lunch.tr}${AppString.pillText.tr}',
              taskDate: taskTime,
              notifications: [
                NotificationModel(notiDateTime: taskTime, alermId: id)
              ],
              isRegular: true,
            ),
          );
        }

        if (selectedMorningLunchEvening.contains(2)) {
          int hour = int.parse(eveningTime.split(':')[0]);
          int minute = int.parse(eveningTime.split(':')[1]);
          int id = AppFunction.createIdByDay(day, hour, minute);

          DateTime? taskTime =
              await notificationService.scheduleWeeklyNotification(
            title:
                '💊 (${AppString.evening.tr}) ${AppString.drinkPillAlram.tr}',
            message:
                '(${intDayToString(day)}) $eveningTime ${AppString.timeToDrink.tr}',
            channelDescription: AppString.pillcCannelDescription.tr,
            id: id,
            weekday: day,
            hour: hour,
            minute: minute,
          );
          if (taskTime == null) {
            break;
          }
          tasks.add(
            TaskModel(
              taskName: '${AppString.evening.tr}${AppString.pillText.tr}',
              taskDate: taskTime,
              notifications: [
                NotificationModel(notiDateTime: taskTime, alermId: id)
              ],
              isRegular: true,
            ),
          );
        }
      }
    }

    UserModel userModel = UserModel(
      selectedPillDays: selectedDays,
      backgroundIndex: backgroundIndex,
      fealIconIndex: fealIconIndex,
      colorIndex: selectedColorIndex,
      tasks: tasks,
      dayPeriodTypes: dayPeriodTypes,
    );

    userController.saveUser(userModel);

    Get.off(() => const MainScreen());

    AppSnackbar.showSuccessMsgSnackBar(AppString.completeSetting.tr,
        duration: const Duration(seconds: 1));
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
