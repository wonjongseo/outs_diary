import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';

part 'health_model.g.dart';

@HiveType(typeId: AppConstant.healthModelHiveId)
class HealthModel {
  @HiveField(0)
  double? temperature;
  @HiveField(1)
  double? basicTemperature;
  @HiveField(2)
  double? bloodPressure;
  @HiveField(3)
  double? weight;
  @HiveField(4)
  double? pulse;

  HealthModel({
    this.temperature,
    this.basicTemperature,
    this.bloodPressure,
    this.weight,
    this.pulse,
  });
}
