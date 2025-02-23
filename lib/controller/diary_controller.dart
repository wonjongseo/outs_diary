import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/views/home/main_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/respository/dairy_respository.dart';
import 'package:ours_log/views/edit_diary/edit_diary_screen.dart';

class DiaryController extends GetxController {
  DateTime now = DateTime.now();
  late DateTime selectedDay;
  late DateTime focusedDay;

  RxList<DiaryModel> _diaries = <DiaryModel>[].obs;
  RxList<DiaryModel> get diaries => _diaries;

  ScrollController scrollController = ScrollController();

  DiaryModel? selectedDiary;
  DiaryRepository _diaryRepository = DiaryRepository();

  @override
  void onInit() async {
    selectedDay = now;
    focusedDay = now;

    getAllData();
    super.onInit();
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay = focusedDay;
    selectedDiary = null;
    getAllData();
  }

  void onDatSelected(DateTime cSelectedDay, DateTime cFocusedDay) {
    selectedDay = cSelectedDay;

    focusedDay = cFocusedDay;

    if (kEvents[cSelectedDay] != null) {
      selectedDiary = kEvents[cSelectedDay]![0];
      AppFunction.scrollGoToBottom(scrollController);
      update();
      return;
    }
    selectedDiary = null;

    bool isNextDay = AppFunction.isNextDay(now, cSelectedDay);

    if (!isNextDay) {
      Get.to(() => EditDiaryScreen(selectedDay: selectedDay));
    } else {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          '경고',
          '미래는 저장할 수 없어요.',
          icon: const Icon(Icons.done),
          borderWidth: 1,
          borderColor: Colors.redAccent,
        );
      }
    }
  }

  void getAllData() async {
    selectedDiary = null;
    _diaries.assignAll(await _diaryRepository.loadDiariesInMonth(focusedDay));

    kEvents.clear();
    for (var diary in _diaries) {
      if (kEvents[diary.dateTime] == null) {
        kEvents[diary.dateTime] = [];
      }
      kEvents[diary.dateTime]!.add(diary);
    }

    update();
  }

  void delete() {
    _diaryRepository.deleteDiary(selectedDiary!);
    selectedDiary = null;
    getAllData();
  }

  void insert(DiaryModel diaryModel) async {
    _diaryRepository.saveDiary(diaryModel);
    getAllData();
    selectedDiary = diaryModel;

    Get.offAll(() => const MainScreen());
    await Future.delayed(const Duration(milliseconds: 100));
    AppFunction.scrollGoToBottom(scrollController);
  }

  final kEvents = LinkedHashMap<DateTime, List<DiaryModel>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  List<DiaryModel> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }
}
