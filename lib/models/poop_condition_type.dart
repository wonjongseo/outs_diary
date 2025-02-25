import 'package:get/get_utils/get_utils.dart';
import 'package:hive/hive.dart';

import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

part 'poop_condition_type.g.dart';

@HiveType(typeId: AppConstant.poopConditionTypeHiveId)
enum PoopConditionType {
  @HiveField(0)
  severeConstipation,
  @HiveField(1)
  mildConstipation,
  @HiveField(2)
  nomarl,
  @HiveField(3)
  normal2,
  @HiveField(4)
  lackingFibre,
  @HiveField(5)
  mildDiarrhea,
  @HiveField(6)
  severeDiarrhea,
}

extension PoopConditionTypeExtension on PoopConditionType {
  String get label {
    switch (this) {
      case PoopConditionType.severeConstipation:
        return AppString.poopCondition1.tr;
      case PoopConditionType.mildConstipation:
        return AppString.poopCondition2.tr;
      case PoopConditionType.nomarl:
        return AppString.poopCondition3.tr;
      case PoopConditionType.normal2:
        return AppString.poopCondition4.tr;
      case PoopConditionType.lackingFibre:
        return AppString.poopCondition5.tr;
      case PoopConditionType.mildDiarrhea:
        return AppString.poopCondition6.tr;
      case PoopConditionType.severeDiarrhea:
        return AppString.poopCondition7.tr;
    }
  }
}
