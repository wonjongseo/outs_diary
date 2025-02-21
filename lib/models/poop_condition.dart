import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/poop_condition_type.dart';

part 'poop_condition.g.dart';

@HiveType(typeId: AppConstant.poopConditionModelHiveId)
class PoopConditionModel {
  @HiveField(0)
  PoopConditionType poopConditionType;
  @HiveField(1)
  bool isChecked;
  PoopConditionModel({
    required this.poopConditionType,
    required this.isChecked,
  });
}
