import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: AppConstant.taskModelHiveId)
class TaskModel {
  @HiveField(0)
  String taskName;
  @HiveField(1)
  DateTime taskDate;
  @HiveField(2)
  late String id;
  @HiveField(3)
  late int createdAt;
  @HiveField(4)
  List<NotificationModel> notifications;
  TaskModel({
    required this.taskName,
    required this.taskDate,
    required this.notifications,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }
}
