import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/controller/onboarding_controller.dart';
import 'package:ours_log/models/alerm_modal.dart';
import 'package:uuid/uuid.dart';

part 'user_model.g.dart';

@HiveType(typeId: AppConstant.userModelHiveId)
class UserModel {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late int createdAt;

  @HiveField(2)
  List<int>? selectedMorningLunchEvening; // 0:아침, 1:점심, 2: 저녁
  @HiveField(3)
  List<int>? selectedDays; // 0:월, 1: 화
  @HiveField(4)
  List<AlermModel>? drinkPillAlerms;

  @HiveField(7)
  int? backgroundIndex;
  @HiveField(8)
  int? fealIconIndex;

  UserModel({
    this.selectedMorningLunchEvening,
    this.selectedDays,
    this.drinkPillAlerms,
    this.backgroundIndex,
    this.fealIconIndex,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }
}
