import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/respository/hospital_log_repository.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/views/edit_hospital_visit_log/edit_hospital_visit_log_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class HospitalLogController extends GetxController {
  List<HospitalLogModel> hospitalLogs = [];
  HospitalLogRepository hospitalLogRepository = HospitalLogRepository();
  SettingRepository settingRepository = SettingRepository();
  late final ValueNotifier<List<HospitalLogModel>> selectedEvents;
  ScrollController scrollController = ScrollController();

  final kEvents = LinkedHashMap<DateTime, List<HospitalLogModel>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  DateTime now = DateTime.now();
  late DateTime focusedDay;
  late DateTime selectedDay;

  @override
  void onInit() {
    getAll();
    focusedDay = now;
    selectedDay = now;

    selectedEvents = ValueNotifier(getEventsForDay(selectedDay!));
    super.onInit();
  }

  bool isSelected = false;
  void onChageCalendar(DateTime cfocusedDay) {
    focusedDay = cfocusedDay;
    isSelected = false;
    update();
  }

  List<HospitalLogModel> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void save(HospitalLogModel hospitalLogModel) async {
    hospitalLogRepository.insert(hospitalLogModel);

    getAll();

    saveLastValue(
      AppConstant.hospitalNamesBox,
      hospitalLogModel.hospitalName,
      5,
    );
    saveLastValue(AppConstant.officeNamesBox, hospitalLogModel.officeName, 5);
    saveLastValue(AppConstant.diseaseNamesBox, hospitalLogModel.diagnosis, 5);
    if (hospitalLogModel.pills != null && hospitalLogModel.pills!.isNotEmpty) {
      for (var pillName in hospitalLogModel.pills!) {
        saveLastValue(AppConstant.pillNamesBox, pillName, 8);
      }
    }
  }

  void saveLastValue(String boxKey, String? saveValue, int maxLength) async {
    if (saveValue == null || saveValue.isEmpty) return;

    List hospitalNames = await SettingRepository.getList(boxKey);

    if (hospitalNames.contains(saveValue)) {
      hospitalNames.remove(saveValue);
    }
    hospitalNames.add(saveValue);
    if (hospitalNames.length > maxLength) {
      hospitalNames.removeAt(0);
    }

    SettingRepository.setList(boxKey, hospitalNames);
  }

  delete(HospitalLogModel hospitalLogModel) async {
    UserController userController = Get.find<UserController>();
    await userController
        .deleteTaskFromNotificationList(hospitalLogModel.notifications);
    hospitalLogRepository.delete(hospitalLogModel);
    getAll();
  }

  void deleteFromTask(TaskModel task) {}

  void getAll() async {
    hospitalLogs = await hospitalLogRepository.select();
    kEvents.clear();
    for (var dummyHospitalLogModel in hospitalLogs) {
      if (kEvents[dummyHospitalLogModel.dateTime!] == null) {
        kEvents[dummyHospitalLogModel.dateTime!] = [];
      }
      kEvents[dummyHospitalLogModel.dateTime!]!.add(dummyHospitalLogModel);
    }
    selectedEvents.value = getEventsForDay(selectedDay!);
    update();
  }

  void onDaySelected(DateTime cSelectedDay, DateTime cFocusedDay) {
    selectedDay = cSelectedDay;
    focusedDay = cFocusedDay;

    selectedEvents.value = getEventsForDay(selectedDay!);

    if (selectedEvents.value.isEmpty) {
      Get.to(() => EditHospitalVisitLogScreen(selectedDate: cSelectedDay));
    }
    isSelected = true;
    update();

    AppFunction.scrollGoToBottom(scrollController, position: 150);
  }
}
