import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';

part 'user_util_model.g.dart';

@HiveType(typeId: AppConstant.userUtilModelHiveId)
class UserUtilModel {
  @HiveField(0)
  bool expandedTemperature;
  @HiveField(1)
  bool expandedPulse;
  @HiveField(2)
  bool expandedBloodPressure;

  UserUtilModel({
    this.expandedTemperature = true,
    this.expandedPulse = true,
    this.expandedBloodPressure = true,
  });

  @override
  String toString() =>
      'UserUtilModel(expandedTemperature: $expandedTemperature, expandedPulse: $expandedPulse, expandedBloodPressure: $expandedBloodPressure)';
}
