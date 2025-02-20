import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/day_period_type.dart';

part 'done_pill_day_modal.g.dart';

@HiveType(typeId: AppConstant.donePillDayModelHiveId)
class DonePillDayModel {
  @HiveField(0)
  DayPeriodType dayPeriod;
  @HiveField(1)
  bool isDone;
  DonePillDayModel({
    required this.dayPeriod,
    required this.isDone,
  });
}
