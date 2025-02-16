import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';

part 'health_model.g.dart';

@HiveType(typeId: AppConstant.healthModelHiveId)
class HealthModel {
  @HiveField(0)
  List<double>? temperatures;
  @HiveField(1)
  List<double>? basicTemperatures;
  @HiveField(2)
  List<double>? bloodPressures;
  @HiveField(3)
  List<double>? weights;
  @HiveField(4)
  List<double>? pulses;

  HealthModel({
    this.temperatures,
    this.basicTemperatures,
    this.bloodPressures,
    this.weights,
    this.pulses,
  });

  double get avgTemperature {
    if (temperatures == null) {
      return 0.0;
    }
    double avg = 0.0;
    for (var temperature in temperatures!) {
      avg += temperature;
    }
    avg = double.parse((avg / temperatures!.length).toStringAsFixed(1));

    return avg;
  }

  double get avgBasicTemperature {
    if (basicTemperatures == null) {
      return 0.0;
    }
    double avg = 0.0;
    for (var basicTemperature in basicTemperatures!) {
      avg += basicTemperature;
    }
    avg = double.parse((avg / basicTemperatures!.length).toStringAsFixed(1));

    return avg;
  }

  double get avgBloodPressure {
    if (bloodPressures == null) {
      return 0.0;
    }
    double avg = 0.0;
    for (var bloodPressure in bloodPressures!) {
      avg += bloodPressure;
    }
    avg = double.parse((avg / bloodPressures!.length).toStringAsFixed(1));

    return avg;
  }

  double get avgWeight {
    if (weights == null) {
      return 0.0;
    }
    double avg = 0.0;
    for (var weight in weights!) {
      avg += weight;
    }
    avg = double.parse((avg / weights!.length).toStringAsFixed(1));
    return avg;
  }

  double get avgPulse {
    if (pulses == null) {
      return 0.0;
    }
    double avg = 0.0;
    for (var pulse in pulses!) {
      avg += pulse;
    }
    avg = double.parse((avg / pulses!.length).toStringAsFixed(1));
    return avg;
  }
}
