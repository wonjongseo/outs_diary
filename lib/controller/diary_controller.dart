import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/respository/dairy_respository.dart';
import 'package:ours_log/views/add_diary/add_diary_screen.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryController extends GetxController {
  DateTime now = DateTime.now();
  late DateTime selectedDay;
  late DateTime focusedDay;
  RxList<DiaryModel> _diaries = <DiaryModel>[].obs;

  DiaryModel? selectedDiary;
  DiaryRepository _diaryRepository = DiaryRepository();

  @override
  void onInit() async {
    selectedDay = now;
    focusedDay = now;
    requestPermisson();
    getAllData();
    super.onInit();
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay = focusedDay;
    selectedDiary = null;
    update();
  }

  void onDatSelected(DateTime cSelectedDay, DateTime cFocusedDay) {
    if (kEvents[cSelectedDay] != null) {
      selectedDiary = kEvents[cSelectedDay]![0];
      update();
    } else {
      selectedDiary = null;

      if (cSelectedDay.difference(now).isNegative) {
        Get.to(() => AddDiaryScreen(selectedDay: selectedDay));
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            '!',
            '미래는 저장할 수 없어요.',
            icon: Icon(Icons.done),
            borderWidth: 1,
            borderColor: Colors.redAccent,
          );
        }
      }
    }
    this.selectedDay = cSelectedDay;
    this.focusedDay = cFocusedDay;
  }

  getAllData() async {
    _diaries.assignAll(await _diaryRepository.loadDiaries());

    kEvents.clear();
    for (var diary in _diaries) {
      if (kEvents[diary.dateTime] == null) {
        kEvents[diary.dateTime] = [];
      }
      kEvents[diary.dateTime]!.add(diary);
    }

    update();
  }

  void requestPermisson() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      return PhotoManager.openSetting();
    }
  }

  void delete() {
    _diaryRepository.deleteDiary(selectedDiary!);
    selectedDiary = null;
    getAllData();
  }

  void insert(DiaryModel diaryModel) {
    _diaryRepository.saveDiary(diaryModel);
    selectedDiary = diaryModel;
    getAllData();
    Get.back();
  }

  final kEvents = LinkedHashMap<DateTime, List<DiaryModel>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  List<DiaryModel> getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }
}
