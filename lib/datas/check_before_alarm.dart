import 'package:ours_log/common/enums/before_alram_time.dart';

class CheckBeforeAlram {
  BeforeAlarmTimeType beforeAlarmType;
  bool isChecked;

  CheckBeforeAlram({
    required this.beforeAlarmType,
    required this.isChecked,
  });

  @override
  String toString() =>
      'CheckBeforeAlram(beforeAlarmType: $beforeAlarmType, isChecked: $isChecked)';
}
