import 'package:get/get_utils/get_utils.dart';
import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';

part 'poop_condition_type.g.dart';

@HiveType(typeId: AppConstant.poopConditionTypeHiveId)
enum PoopConditionType {
  @HiveField(0)
  korokoro,
  @HiveField(1)
  hard,
  @HiveField(2)
  nomarl,
  @HiveField(3)
  soft,
  @HiveField(4)
  likeMud,
  @HiveField(5)
  likeWater,
}

extension PoopConditionTypeExtension on PoopConditionType {
  String get label {
    switch (this) {
      case PoopConditionType.korokoro:
        return AppString.poopCondition1.tr;
      case PoopConditionType.hard:
        return AppString.poopCondition2.tr;
      case PoopConditionType.nomarl:
        return AppString.poopCondition3.tr;
      case PoopConditionType.soft:
        return AppString.poopCondition4.tr;
      case PoopConditionType.likeMud:
        return AppString.poopCondition5.tr;
      case PoopConditionType.likeWater:
        return AppString.poopCondition6.tr;
    }
  }
}
