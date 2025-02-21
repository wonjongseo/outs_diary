import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/notification_model.dart';

part 'hospital_log_model.g.dart';

@HiveType(typeId: AppConstant.hospitalLogModelHiveId)
class HospitalLogModel {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late int createdAt;
  @HiveField(2)
  String? startTime;
  @HiveField(3)
  final DateTime dateTime;
  @HiveField(4)
  final String hospitalName;
  @HiveField(5)
  List<String> imagesPath;
  @HiveField(6)
  String? officeName;
  @HiveField(7)
  String? diseaseName;
  @HiveField(8)
  String? diagnosis;
  @HiveField(9)
  List<String>? pills;
  @HiveField(10)
  List<NotificationModel>? notifications;

  HospitalLogModel({
    this.startTime,
    required this.dateTime,
    required this.hospitalName,
    required this.imagesPath,
    this.officeName,
    this.diseaseName,
    this.diagnosis,
    this.pills,
    this.notifications,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'HospitalLogModel(id: $id, createdAt: $createdAt, startTime: $startTime, dateTime: $dateTime, hospitalName: $hospitalName, imagesPath: $imagesPath, officeName: $officeName, diseaseName: $diseaseName, diagnosis: $diagnosis, pills: $pills, notificationId: $notifications)';
  }
}
