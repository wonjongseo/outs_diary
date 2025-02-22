import 'package:hive/hive.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/user_model.dart';

class UserModelRepository {
  Future<void> saveUser(UserModel user) async {
    var box = await Hive.openBox<UserModel>(AppConstant.userModelBox);

    await box.put(user.id, user);

    print('user saved!');
  }

  Future<bool> isExistUser(UserModel user) async {
    var box = await Hive.openBox<UserModel>(AppConstant.userModelBox);

    bool isExistUser = await box.containsKey(user.id);

    return isExistUser;
  }

  Future<void> deleteUser(UserModel user) async {
    var box = await Hive.openBox<UserModel>(AppConstant.userModelBox);

    await box.delete(user.id);
    print('User Deleted!');
  }

  Future<void> deleteAll() async {
    var box = await Hive.openBox<UserModel>(AppConstant.userModelBox);

    box.deleteFromDisk();
    print('User All DELETE !!');
  }

  Future<UserModel?> loadUser() async {
    var box = await Hive.openBox<UserModel>(AppConstant.userModelBox);

    List<UserModel> user = box.values.toList();

    return user.isEmpty ? null : user.first;
  }

  Future<bool> savedUser() async {
    var box = await Hive.openBox<UserModel>(AppConstant.userModelBox);

    List<UserModel> user = box.values.toList();

    return user.isEmpty ? false : true;
  }
}
