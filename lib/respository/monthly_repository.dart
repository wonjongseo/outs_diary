import 'package:hive_flutter/hive_flutter.dart';

class MonthlyRepository {
  static Future<DateTime?> getPeroid(
      {required DateTime dateTime, required bool isStart}) async {
    var box = await Hive.openBox<DateTime>('peroidBox');
    String yearAndMonth = '${dateTime.year}-${dateTime.month}';

    String key = '${yearAndMonth}_${isStart ? 'Start' : 'end'}_peroid}';
    return box.get(key);
  }

  static void setPeroid(
      {required bool isStart, required DateTime dateTime}) async {
    var box = await Hive.openBox<DateTime>('peroidBox');
    String yearAndMonth = '${dateTime.year}-${dateTime.month}';
    String key = '${yearAndMonth}_${isStart ? 'Start' : 'end'}_peroid}';

    DateTime yearAndMonthDT =
        DateTime(dateTime.year, dateTime.month, dateTime.day);
    box.put(key, yearAndMonthDT);
  }
}
