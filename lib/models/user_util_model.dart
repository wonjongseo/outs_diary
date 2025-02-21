import 'package:hive/hive.dart';

import 'package:ours_log/models/is_expandtion_type.dart';
import 'package:ours_log/common/utilities/app_constant.dart';

part 'user_util_model.g.dart';

@HiveType(typeId: AppConstant.userUtilModelHiveId)
class UserUtilModel {
  @HiveField(0)
  late Map<IsExpandtionType, bool> expandedFields;

  @HiveField(1)
  bool isCricleGraph = false;

  UserUtilModel()
      : expandedFields = {
          for (var field in IsExpandtionType.values) field: true,
        };

  @override
  String toString() => 'UserUtilModel(expandedFields: $expandedFields)';
}
