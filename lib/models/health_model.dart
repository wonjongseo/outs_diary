import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/models/blood_pressure_model.dart';

part 'health_model.g.dart';

@HiveType(typeId: AppConstant.healthModelHiveId)
class HealthModel {
  @HiveField(0)
  List<double>? temperatures;
  @HiveField(1)
  List<double>? basicTemperatures;
  @HiveField(2)
  BloodPressureModel? bloodPressures;
  @HiveField(3)
  List<double>? weights;
  @HiveField(4)
  List<int>? pulses;

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
    int count = 0;
    for (var temperature in temperatures!) {
      if (temperature != 0) {
        count++;
      }
      avg += temperature;
    }
    if (count == 0) return 0.0;
    avg = double.parse((avg / count).toStringAsFixed(2));

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

  int get avgMaxBloodPressure {
    if (bloodPressures == null) {
      return 0;
    }

    return bloodPressures!.avgMax;
  }

  int get avgMinBloodPressure {
    if (bloodPressures == null) {
      return 0;
    }

    return bloodPressures!.avgMin;
  }

  double get avgWeight {
    if (weights == null) {
      return 0.0;
    }
    double avg = 0.0;
    int count = 0;

    for (var weight in weights!) {
      if (weight != 0) {
        count++;
      }
      avg += weight;
    }
    if (count == 0) {
      return 0;
    }
    avg = double.parse((avg / count).toStringAsFixed(2));
    return avg;
  }

  double get avgPulse {
    if (pulses == null) {
      return 0.0;
    }
    double avg = 0.0;
    int count = 0;

    for (var pulse in pulses!) {
      if (pulse != 0) {
        count++;
      }
      avg += pulse;
    }
    if (count == 0) {
      return 0;
    }
    avg = double.parse((avg / count).toStringAsFixed(1));
    return avg;
  }

  bool get argIsNotZero {
    return avgTemperature != 0 ||
        avgBasicTemperature != 0 ||
        avgMaxBloodPressure != 0 ||
        avgMinBloodPressure != 0 ||
        avgWeight != 0 ||
        avgPulse != 0;
  }

  String get tooltipMsgTemperature {
    String message = '';
    if (temperatures == null) return message;

    if (temperatures![0] != 0) {
      message += '${AppString.morning.tr}: ${temperatures![0]}';
    }

    if (temperatures![1] != 0) {
      message += ' ${AppString.lunch.tr}: ${temperatures![1]}';
    }
    if (temperatures![2] != 0) {
      message += ' ${AppString.evening.tr}: ${temperatures![2]}';
    }

    return message;
  }

  String get tooltipMsgBasicTemperature {
    String message = '';
    if (basicTemperatures == null) return message;

    if (basicTemperatures![0] != 0) {
      message += '${AppString.morning.tr}: ${basicTemperatures![0]}';
    }

    if (basicTemperatures![1] != 0) {
      message += ' ${AppString.lunch.tr}: ${basicTemperatures![1]}';
    }
    if (basicTemperatures![2] != 0) {
      message += ' ${AppString.evening.tr}: ${basicTemperatures![2]}';
    }

    return message;
  }

  // String get tooltipMsgBloodPressure {
  //   String message = '';
  //   if (bloodPressures == null) return message;

  //   if (bloodPressures![0] != 0) {
  //     message += '${AppString.morning.tr}: ${bloodPressures![0]}';
  //   }

  //   if (bloodPressures![1] != 0) {
  //     message += ' ${AppString.lunch.tr}: ${bloodPressures![1]}';
  //   }
  //   if (bloodPressures![2] != 0) {
  //     message += ' ${AppString.evening.tr}: ${bloodPressures![2]}';
  //   }

  //   return message;
  // }

  String get tooltipMsgWeight {
    String message = '';
    if (weights == null) return message;

    if (weights![0] != 0) {
      message += '${AppString.morning.tr}: ${weights![0]}';
    }

    if (weights![1] != 0) {
      message += ' ${AppString.lunch.tr}: ${weights![1]}';
    }
    if (weights![2] != 0) {
      message += ' ${AppString.evening.tr}: ${weights![2]}';
    }

    return message;
  }

  String get tooltipMsgPulse {
    String message = '';
    if (pulses == null) return message;

    if (pulses![0] != 0) {
      message += '${AppString.morning.tr}: ${pulses![0]}';
    }

    if (pulses![1] != 0) {
      message += ' ${AppString.lunch.tr}: ${pulses![1]}';
    }
    if (pulses![2] != 0) {
      message += ' ${AppString.evening.tr}: ${pulses![2]}';
    }

    return message;
  }

  @override
  String toString() {
    return 'HealthModel(temperatures: $temperatures, basicTemperatures: $basicTemperatures, bloodPressures: $bloodPressures, weights: $weights, pulses: $pulses)';
  }
}
