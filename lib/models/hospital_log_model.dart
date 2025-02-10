import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:ours_log/common/utilities/app_constant.dart';

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

  HospitalLogModel({
    this.startTime,
    required this.dateTime,
    required this.hospitalName,
    required this.imagesPath,
    this.pills,
    this.officeName,
    this.diseaseName,
    this.diagnosis,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'HospitalLogModel(\nid: $id, \ncreatedAt: $createdAt, \nstartTime: $startTime, \ndateTime: $dateTime, \nhospitalName: $hospitalName, \nimagesPath: $imagesPath, \nofficeName: $officeName, \ndiseaseName: $diseaseName, \ndiagnosis: $diagnosis)';
  }
}
