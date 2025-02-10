import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';

class SettingRepository {
  static Future<void> setBool(String key, bool value) async {
    var box = await Hive.openBox(AppConstant.settingModelBox);

    await box.put(key, value);
  }

  static Future<bool> getBool(String key) async {
    var box = await Hive.openBox(AppConstant.settingModelBox);

    return box.get(key, defaultValue: false);
  }

  static Future<void> setList(String key, List value) async {
    var box = await Hive.openBox(AppConstant.settingModelBox);

    await box.put(key, value);
  }

  static Future<List> getList(String key) async {
    var box = await Hive.openBox(AppConstant.settingModelBox);

    return box.get(key, defaultValue: []);
  }

  // static Future<void> setSet(String key, Set<String> value) async {
  //   var box = await Hive.openBox<Set<String>>(AppConstant.settingModelBox);

  //   await box.put(key, value);
  // }

  // static Future<Set<String>> getSet(String key) async {
  //   var box = await Hive.openBox<Set<String>>(AppConstant.settingModelBox);

  //   return box.get(key) ?? <String>{};
  // }

  static Future<void> setString(String key, String value) async {
    var box = await Hive.openBox(AppConstant.settingModelBox);

    await box.put(key, value);
  }

  static Future<String> getString(String key) async {
    var box = await Hive.openBox(AppConstant.settingModelBox);

    return box.get(key, defaultValue: '');
  }

  static Future<void> setInt(String key, int value) async {
    var box = await Hive.openBox(AppConstant.settingModelBox);

    await box.put(key, value);
  }

  static Future<int> getInt(String key) async {
    var box = await Hive.openBox(AppConstant.settingModelBox);

    return box.get(key, defaultValue: 0);
  }
}
