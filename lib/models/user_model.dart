import 'package:hive/hive.dart';
import 'package:ours_log/models/user_util_model.dart';
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
  List<int>? selectedDays; // 0:월, 1: 화
  @HiveField(3)
  int? colorIndex;
  @HiveField(4)
  List<TaskModel>? tasks;
  @HiveField(5)
  int? backgroundIndex;
  @HiveField(6)
  int? fealIconIndex;
  @HiveField(7)
  UserUtilModel userUtilModel = UserUtilModel();

  UserModel({
    this.selectedDays,
    this.colorIndex,
    this.tasks,
    this.backgroundIndex,
    this.fealIconIndex,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, createdAt: $createdAt, selectedDays: $selectedDays, colorIndex: $colorIndex, tasks: $tasks, backgroundIndex: $backgroundIndex, fealIconIndex: $fealIconIndex, )';
  }
}
