import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/views/home/main_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/respository/dairy_respository.dart';
import 'package:ours_log/respository/monthly_repository.dart';
import 'package:ours_log/views/add_diary/add_diary_screen.dart';

// class MontlyController extends GetxController {
//   DateTime now = DateTime.now();
//   late DateTime selectedDay;
//   late DateTime focusedDay;

//   PeriodModel periodModel = PeriodModel();

//   ScrollController scrollController = ScrollController();
//   DiaryController diaryController = Get.find<DiaryController>();

//   final kEvents = LinkedHashMap<DateTime, List<DiaryModel>>(
//     equals: isSameDay,
//     hashCode: getHashCode,
//   );

//   List<DiaryModel> getEventsForDay(DateTime day) {
//     // Implementation example
//     return kEvents[day] ?? [];
//   }

//   void onPageChanged(DateTime focusedDay) {
//     this.focusedDay = focusedDay;
//     diaryController.getAllData();
//   }

//   void onDatSelected(DateTime cSelectedDay, DateTime cFocusedDay) {
//     if (kEvents[cSelectedDay] != null) {
//       selectedDiary = kEvents[cSelectedDay]![0];
//       AppFunction.scrollGoToTop(scrollController);
//       update();
//       return;
//     }
//     selectedDiary = null;

//     if (cSelectedDay.difference(now).isNegative) {
//       Get.to(() => AddDiaryScreen(selectedDay: selectedDay));
//     } else {
//       if (!Get.isSnackbarOpen) {
//         Get.snackbar(
//           '경고',
//           '미래는 저장할 수 없어요.',
//           icon: Icon(Icons.done),
//           borderWidth: 1,
//           borderColor: Colors.redAccent,
//         );
//       }
//     }
//     selectedDay = cSelectedDay;
//     focusedDay = cFocusedDay;
//   }

//   @override
//   void onInit() async {
//     selectedDay = now;
//     focusedDay = now;
//     AppFunction.requestPermisson();
//     super.onInit();
//   }
// }

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

    AppFunction.requestPermisson();
    getAllData();
    super.onInit();
  }

  void onPageChanged(DateTime focusedDay) {
    print('focusedDay : ${focusedDay}');

    this.focusedDay = focusedDay;
    selectedDiary = null;
    getAllData();
  }

  void onDatSelected(DateTime cSelectedDay, DateTime cFocusedDay) {
    if (kEvents[cSelectedDay] != null) {
      selectedDiary = kEvents[cSelectedDay]![0];
      AppFunction.scrollGoToTop(scrollController);
      update();
      return;
    }
    selectedDiary = null;

    if (cSelectedDay.difference(now).isNegative) {
      Get.to(() => AddDiaryScreen(
            selectedDay: selectedDay,
          ));
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
    selectedDay = cSelectedDay;
    focusedDay = cFocusedDay;
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

  void insert(DiaryModel diaryModel) {
    _diaryRepository.saveDiary(diaryModel);
    selectedDiary = diaryModel;
    getAllData();
    Get.offAll(() => MainScreen());
  }

  final kEvents = LinkedHashMap<DateTime, List<DiaryModel>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  List<DiaryModel> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }
}
