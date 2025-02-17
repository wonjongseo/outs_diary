import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';

part 'alerm_modal.g.dart';

@HiveType(typeId: AppConstant.alermModelHiveId)
class AlermModel {
  @HiveField(0)
  String? scheduleTime;
  @HiveField(1)
  String? id;
  AlermModel({
    this.scheduleTime,
    this.id,
  });
}
