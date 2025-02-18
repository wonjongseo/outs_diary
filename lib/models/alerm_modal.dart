import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';

part 'alerm_modal.g.dart';

@HiveType(typeId: AppConstant.alermModelHiveId)
class AlermModel {
  @HiveField(0)
  final String scheduleTime;
  @HiveField(1)
  final int alermId;

  @HiveField(2)
  final bool isRegular;

  AlermModel({
    required this.scheduleTime,
    required this.alermId,
    this.isRegular = false,
  });

  @override
  String toString() =>
      'AlermModel(scheduleTime: $scheduleTime, id: $alermId, isRegular: $isRegular)';
}
