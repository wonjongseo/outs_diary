import 'package:hive/hive.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/user_util_model.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:uuid/uuid.dart';

import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/task_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: AppConstant.userModelHiveId)
class UserModel {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late int createdAt;
  @HiveField(2)
  List<WeekDayType>? selectedPillDays; // 월 화 수 는 등록되어있고,
  @HiveField(3)
  List<DayPeriodType>? dayPeriodTypes; //아침, 점심,  저녁도 있고
  @HiveField(4)
  int? colorIndex;
  @HiveField(5)
  List<TaskModel>? tasks; // 시간은 여기서 ?
  @HiveField(6)
  int? backgroundIndex;
  @HiveField(7)
  int? fealIconIndex;
  @HiveField(8)
  UserUtilModel userUtilModel = UserUtilModel();

  UserModel({
    this.selectedPillDays,
    this.colorIndex,
    this.tasks,
    this.backgroundIndex,
    this.fealIconIndex,
    this.dayPeriodTypes,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, createdAt: $createdAt, selectedDays: $selectedPillDays, colorIndex: $colorIndex, tasks: $tasks, backgroundIndex: $backgroundIndex, fealIconIndex: $fealIconIndex, )';
  }
}
