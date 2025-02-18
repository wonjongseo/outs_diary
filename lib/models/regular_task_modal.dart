import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';

part 'regular_task_model.g.dart';

@HiveType(typeId: AppConstant.regularTaskModelHiveId)
class RegularTaskModel {
  @HiveField(0)
  final String scheduleTime;
  @HiveField(1)
  final int alermId;

  RegularTaskModel({
    required this.scheduleTime,
    required this.alermId,
  });

  @override
  String toString() => 'AlermModel(scheduleTime: $scheduleTime, id: $alermId)';
}
