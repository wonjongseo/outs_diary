import 'package:hive/hive.dart';
import 'package:ours_log/models/done_pill_day_modal.dart';
import 'package:uuid/uuid.dart';

import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/health_model.dart';

part 'diary_model.g.dart';

@HiveType(typeId: AppConstant.diaryModelHiveId)
class DiaryModel {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late int createdAt;
  @HiveField(2)
  final DateTime dateTime;
  @HiveField(3)
  final int fealIndex;
  @HiveField(4)
  List<DonePillDayModel>? donePillDayModels;

  @HiveField(5)
  final String? whatTodo;
  @HiveField(6)
  final List<String>? imagePath;
  @HiveField(7)
  final HealthModel? health;

  @HiveField(8)
  final int? painfulIndex;

  DiaryModel({
    required this.dateTime,
    required this.fealIndex,
    this.whatTodo,
    this.imagePath,
    this.painfulIndex,
    this.donePillDayModels,
    this.health,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'DiaryModel(id: $id, createdAt: $createdAt, dateTime: $dateTime, fealIndex: $fealIndex, whatTodo: $whatTodo, imagePath: $imagePath, health: $health, painfulIndex: $painfulIndex)';
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
