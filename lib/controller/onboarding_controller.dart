import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/regular_task_modal.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/user_model.dart';
import 'package:ours_log/views/manage_alrem/manage_alrem_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:ours_log/controller/notification_controller.dart';
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
  List<int> selectedDays = []; // 0:월, 1: 화

  void onSelectMorningLunchEvening(int index) {
    bool isSelected = selectedMorningLunchEvening.contains(index);
    if (isSelected) {
      selectedMorningLunchEvening.remove(index);
    } else {
      selectedMorningLunchEvening.add(index);
    }
    update();
  }

  void onSelectDays(int index) {
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
// if Check
  void _permissionWithNotification() async {
    if (await Permission.notification.isDenied &&
        !await Permission.notification.isPermanentlyDenied) {
      await [Permission.notification].request();
    }
  }

  int pageIndex = 0;
  late PageController pageController;
  Duration pageDuration = const Duration(milliseconds: 200);
  Curve pageCurves = Curves.linear;

  void backToPage() {
    pageIndex--;
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

  void goToMainScreenAndSaveUserData() async {
    // Map<int, List<RegularTaskModel>> alerms = {};
    List<TaskModel> tasks = [];
    List<String> times = [];

    if (isAlermEnable) {
      selectedDays.sort((a, b) => a.compareTo(b));
      List<int> days = List.generate(
          selectedDays.length, (index) => selectedDays[index] + 1);

      if (selectedMorningLunchEvening.contains(0)) {
        times.add(morningTime);
      }
      if (selectedMorningLunchEvening.contains(1)) {
        times.add(lunchTime);
      }
      if (selectedMorningLunchEvening.contains(2)) {
        times.add(eveningTime);
      }
      DateTime now = DateTime.now();
      for (int day in days) {
        if (selectedMorningLunchEvening.contains(0)) {
          int hour = int.parse(morningTime.split(':')[0]);
          int minute = int.parse(morningTime.split(':')[1]);
          int id = AppFunction.createIdByDay(day, hour, minute);

          DateTime? taskTime =
              await notificationService.scheduleWeeklyNotification(
            title: '💊 아침 약 복용 알림',
            message:
                '${day}/${intDayToString(day)}/${morningTime} 시간에 약을 복용하세요!',
            channelDescription: '매주 특정 요일 및 시간에 알림을 받습니다',
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
              taskName: '아침 약',
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
            title: '💊잠심 약 복용 알림',
            message: '${day}/${intDayToString(day)}/${lunchTime} 시간에 약을 복용하세요!',
            channelDescription: '매주 특정 요일 및 시간에 알림을 받습니다',
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
              taskName: '점심 약',
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
            title: '💊저녁 약 복용 알림',
            message:
                '${day}/${intDayToString(day)}/${eveningTime} 시간에 약을 복용하세요!',
            channelDescription: '매주 특정 요일 및 시간에 알림을 받습니다',
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
              taskName: '저녁 약',
              taskDate: taskTime,
              notifications: [
                NotificationModel(notiDateTime: taskTime, alermId: id)
              ],
              isRegular: true,
            ),
          );
        }
        // for (String time in times) {
        //   int hour = int.parse(time.split(':')[0]);
        //   int minute = int.parse(time.split(':')[1]);

        //   int id = day * Random().nextInt(1000) +
        //       hour * Random().nextInt(100) +
        //       minute +
        //       Random().nextInt(10);

        //   notificationService.scheduleWeeklyNotification(
        //     title: '💊 약 복용 알림',
        //     message: '${day}/${intDayToString(day)}/${time} 시간에 약을 복용하세요!',
        //     channelDescription: '매주 특정 요일 및 시간에 알림을 받습니다',
        //     id: id,
        //     weekday: day,
        //     hour: hour,
        //     minute: minute,
        //   );
        // }
      }
    }

    UserModel userModel = UserModel(
      selectedMorningLunchEvening: times,
      selectedDays: selectedDays,
      backgroundIndex: backgroundIndex,
      fealIconIndex: fealIconIndex,
      tasks: tasks,
    );

    // return;

    userController.saveUser(userModel);

    Get.off(() => const MainScreen());
  }

  UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    _permissionWithNotification();
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
      FadeInRight(child: Onboarding6()),
      FadeInRight(child: const Onboarding7()),
    ]);
  }

  List<Widget> bodys = [];
}
