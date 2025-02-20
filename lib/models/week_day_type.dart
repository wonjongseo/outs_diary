import 'package:get/get_utils/get_utils.dart';
import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';

part 'week_day_type.g.dart';

@HiveType(typeId: AppConstant.weekDayTypeHiveId)
enum WeekDayType {
  @HiveField(0)
  monday,
  @HiveField(1)
  tuesday,
  @HiveField(2)
  wednesday,
  @HiveField(3)
  thursday,
  @HiveField(4)
  friday,
  @HiveField(5)
  saturday,
  @HiveField(6)
  sunday,
}

extension WeekDayTypeExtenston on WeekDayType {
  // int get dayIndex {
  //   switch (this) {
  //     case WeekDayType.monday:
  //       return 0;
  //     case WeekDayType.tuesday:
  //       return 1;
  //     case WeekDayType.wednesday:
  //       return 2;
  //     case WeekDayType.thursday:
  //       return 3;
  //     case WeekDayType.friday:
  //       return 4;
  //     case WeekDayType.saturday:
  //       return 5;
  //     case WeekDayType.sunday:
  //       return 6;
  //   }
  // }

  String get label {
    switch (this) {
      case WeekDayType.monday:
        return AppString.monday.tr;
      case WeekDayType.tuesday:
        return AppString.tuesday.tr;
      case WeekDayType.wednesday:
        return AppString.wednesday.tr;
      case WeekDayType.thursday:
        return AppString.monday.tr;
      case WeekDayType.friday:
        return AppString.friday.tr;
      case WeekDayType.saturday:
        return AppString.saturday.tr;
      case WeekDayType.sunday:
        return AppString.sunday.tr;
    }
  }
}
