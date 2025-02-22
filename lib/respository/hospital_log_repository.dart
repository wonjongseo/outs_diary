import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/hospital_log_model.dart';

class HospitalLogRepository {
  Future<void> insert(HospitalLogModel hospitalLog) async {
    var box =
        await Hive.openBox<HospitalLogModel>(AppConstant.hospitalLogModelBox);

    await box.put(hospitalLog.id, hospitalLog);

    print('hospitalLog saved!');
  }

  Future<bool> isExist(HospitalLogModel hospitalLog) async {
    var box =
        await Hive.openBox<HospitalLogModel>(AppConstant.hospitalLogModelBox);
    bool isExistdiary = await box.containsKey(hospitalLog.id);

    return isExistdiary;
  }

  Future<void> delete(HospitalLogModel hospitalLog) async {
    var box =
        await Hive.openBox<HospitalLogModel>(AppConstant.hospitalLogModelBox);
    await box.delete(hospitalLog.id);
    print('hospitalLog Deleted!');
  }

  Future<List<HospitalLogModel>> select() async {
    var box =
        await Hive.openBox<HospitalLogModel>(AppConstant.hospitalLogModelBox);

    List<HospitalLogModel> hospitalLogs = box.values.toList();
    hospitalLogs.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return hospitalLogs;
  }

  Future<void> deleteAll() async {
    var box =
        await Hive.openBox<HospitalLogModel>(AppConstant.hospitalLogModelBox);

    box.deleteFromDisk();
    print('HospitalLogModel All DELETE !!');
  }
}
