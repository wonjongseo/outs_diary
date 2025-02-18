import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';

part 'task_model.g.dart';

@HiveType(typeId: AppConstant.taskModelHiveId)
class TaskModel {
  @HiveField(0)
  final DateTime dateTime;
  @HiveField(1)
  final int alermId;

  TaskModel({required this.dateTime, required this.alermId});

  @override
  String toString() => 'TaskModel(dateTime: $dateTime, alermId: $alermId)';
}
