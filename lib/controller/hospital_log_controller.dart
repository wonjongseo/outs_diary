import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/respository/hospital_log_repository.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/views/hospital_visit_log/add_hospital_visit_log_screen.dart';
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

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  void onInit() {
    getAll();
    selectedDay = focusedDay;

    selectedEvents = ValueNotifier(getEventsForDay(selectedDay!));
    super.onInit();
  }

  void onChageCalendar(DateTime cfocusedDay) {
    focusedDay = cfocusedDay;
    update();
  }

  List<HospitalLogModel> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void save(HospitalLogModel hospitalLogModel) async {
    hospitalLogRepository.insert(hospitalLogModel);

    getAll();

    List hospitalNames =
        await SettingRepository.getList(AppConstant.hospitalNamesBox);

    if (hospitalNames.contains(hospitalLogModel.hospitalName)) {
      hospitalNames.remove(hospitalLogModel.hospitalName);
    }
    hospitalNames.add(hospitalLogModel.hospitalName);
    if (hospitalNames.length > 5) {
      hospitalNames.removeAt(0);
    }

    SettingRepository.setList(AppConstant.hospitalNamesBox, hospitalNames);
  }

  void delete(HospitalLogModel hospitalLogModel) {
    hospitalLogRepository.delete(hospitalLogModel);
    getAll();
  }

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
      Get.to(() => AddHospitalVisitLogScreen(selectedDate: cSelectedDay));
    }
    update();
  }
}
