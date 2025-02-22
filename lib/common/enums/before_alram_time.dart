import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';

enum BeforeAlarmTimeType {
  oneDay(24),
  sixHour(06),
  oneHour(01),
  any(00);

  final int hour;
  const BeforeAlarmTimeType(this.hour);
}

extension BeforeAlarmTypeExtension on BeforeAlarmTimeType {
  String? get label {
    switch (this) {
      case BeforeAlarmTimeType.oneDay:
        return '1${AppString.beforeDay.tr}';
      case BeforeAlarmTimeType.sixHour:
        return '6${AppString.beforeHour.tr}';
      case BeforeAlarmTimeType.oneHour:
        return '1${AppString.beforeHour.tr}';
      case BeforeAlarmTimeType.any:
        return null;
    }
  }
}
