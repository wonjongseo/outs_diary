import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';

part 'user_util_model.g.dart';

@HiveType(typeId: AppConstant.userUtilModelHiveId)
class UserUtilModel {
  // dont swap field
  @HiveField(0)
  bool expandedTemperature;
  @HiveField(1)
  bool expandedPulse;
  @HiveField(2)
  bool expandedBloodPressure;
  @HiveField(3)
  bool expandedPainLevel;
  @HiveField(4)
  bool expandedFealGraph;

  @HiveField(5)
  bool expandedWeightGraph;

  @HiveField(6)
  bool expandedTemperatureGraph;
  @HiveField(7)
  bool expandedPulseGraph;
  @HiveField(8)
  bool expandedBloodPressureGraph;
  @HiveField(9)
  bool expandedPainLevelGraph;

  UserUtilModel({
    this.expandedTemperature = true,
    this.expandedPulse = true,
    this.expandedBloodPressure = true,
    this.expandedPainLevel = true,
    this.expandedFealGraph = true,
    this.expandedWeightGraph = true,
    this.expandedTemperatureGraph = true,
    this.expandedPulseGraph = true,
    this.expandedBloodPressureGraph = true,
    this.expandedPainLevelGraph = true,
  });

  @override
  String toString() =>
      'UserUtilModel(expandedTemperature: $expandedTemperature, expandedPulse: $expandedPulse, expandedBloodPressure: $expandedBloodPressure)';
}
