import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';

part 'is_expandtion_type.g.dart';

@HiveType(typeId: AppConstant.isExpandtionTypeHiveId)
enum IsExpandtionType {
  @HiveField(0)
  temperature,
  @HiveField(1)
  pulse,
  @HiveField(2)
  bloodPressure,
  @HiveField(3)
  painLevel,
  @HiveField(4)
  fealGraph,
  @HiveField(5)
  weightGraph,
  @HiveField(6)
  temperatureGraph,
  @HiveField(7)
  pulseGraph,
  @HiveField(8)
  bloodPressureGraph,
  @HiveField(9)
  painLevelGraph,
  @HiveField(10)
  poopCondition,

  @HiveField(11)
  isFealLineGraphFirst,
}
