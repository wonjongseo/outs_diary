import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';

part 'blood_pressure_model.g.dart';

@HiveType(typeId: AppConstant.bloodPressureModelHiveId)
class BloodPressureModel {
  @HiveField(0)
  List<int>? max;
  @HiveField(1)
  List<int>? min;

  BloodPressureModel({
    this.max,
    this.min,
  });

  int get avgMax {
    if (max == null) {
      return 0;
    }
    int avg = 0;
    int count = 0;
    for (var bloodPressure in max!) {
      if (bloodPressure != 0) {
        count++;
      }
      avg += bloodPressure;
    }
    if (count == 0) {
      return 0;
    }
    avg = (avg / count).toInt();

    return avg;
  }

  int get avgMin {
    if (min == null) {
      return 0;
    }
    int avg = 0;
    int count = 0;
    for (var bloodPressure in min!) {
      if (bloodPressure != 0) {
        count++;
      }
      avg += bloodPressure;
    }

    if (count == 0) {
      return 0;
    }
    avg = (avg / count).toInt();

    return avg;
  }

  @override
  String toString() => 'BloodPressureModel(max: $max, min: $min)';
}
