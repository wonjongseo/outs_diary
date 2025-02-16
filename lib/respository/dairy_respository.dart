import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/diary_model.dart';

class DiaryRepository {
  Future<void> saveDiary(DiaryModel diary) async {
    var box = await Hive.openBox<DiaryModel>(AppConstant.diaryModelBox);

    await box.put(diary.id, diary);

    print('diary saved!');
  }

  Future<bool> isExistDiary(DiaryModel diary) async {
    var box = await Hive.openBox<DiaryModel>(AppConstant.diaryModelBox);

    // 데이터 저장
    // await box.add(diary);
    // bool isExistdiary = await box.containsKey(
    //     '${diary.name}-${UtilFunction.getDayYYYYMMDD(diary.birthDay)}-${diary.genderType.gender}');
    bool isExistdiary = await box.containsKey(diary.id);

    return isExistdiary;
  }

  Future<void> deleteDiary(DiaryModel diary) async {
    var box = await Hive.openBox<DiaryModel>(AppConstant.diaryModelBox);

    // 데이터 저장
    // await box.delete(
    //     '${diary.name}-${UtilFunction.getDayYYYYMMDD(diary.birthDay)}-${diary.genderType.gender}');
    await box.delete(diary.id);
    print('Dog Deleted!');
  }

  Future<List<DiaryModel>> loadDiariesInMonth(DateTime dateTime) async {
    var box = await Hive.openBox<DiaryModel>(AppConstant.diaryModelBox);

    List<DiaryModel> diariesInMonth = box.values
        .where((diary) =>
            diary.dateTime.year == dateTime.year &&
            diary.dateTime.month == dateTime.month)
        .toList();
    diariesInMonth.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return diariesInMonth;
  }

  Future<List<DiaryModel>> loadDiaries() async {
    var box = await Hive.openBox<DiaryModel>(AppConstant.diaryModelBox);

    // 데이터 읽기
    List<DiaryModel> diarys = box.values.toList();
    diarys.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    for (var diary in diarys) {}
    return diarys;
  }
}
