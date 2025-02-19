import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/user_model.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/respository/user_respository.dart';

class UserController extends GetxController {
  late UserModel? userModel;

  void saveUser(UserModel userModel) {
    userModelRepository.saveUser(userModel);
    getUser();
  }

  bool isDarkMode = false;

  UserModelRepository userModelRepository = UserModelRepository();

  void toggleExpandedTemperature(bool v) {
    userModel!.userUtilModel!.expandedTemperature =
        !userModel!.userUtilModel!.expandedTemperature;

    userModelRepository.saveUser(userModel!);
    print('userModel!.userUtilModel! : ${userModel!.userUtilModel!}');

    update();
  }

  void toggleExpandedPulse(bool v) {
    userModel!.userUtilModel!.expandedPulse =
        !userModel!.userUtilModel!.expandedPulse;

    userModelRepository.saveUser(userModel!);
    update();
  }

  void toggleExpandedbloodPressure(bool v) {
    userModel!.userUtilModel!.expandedBloodPressure =
        !userModel!.userUtilModel!.expandedBloodPressure;

    userModelRepository.saveUser(userModel!);
    update();
  }

  void addTask(TaskModel task) {
    if (userModel == null) return;
    if (userModel!.tasks == null) {
      userModel!.tasks = [];
    }
    userModel!.tasks!.add(task);
    userModelRepository.saveUser(userModel!);

    getUser();
  }

  void changePrimaryColor(int index) {
    userModel!.colorIndex = index;
    userModelRepository.saveUser(userModel!);
    getUser();
  }

  void deleteTask(TaskModel task) {
    if (userModel == null) return;
    if (userModel!.tasks == null) {
      return;
    }
    userModel!.tasks!.remove(task);
    userModelRepository.saveUser(userModel!);

    getUser();
  }

  List<String> get feals {
    return AppConstant.fealIconLists[userModel?.fealIconIndex ?? 0].iconPath;
  }

  void setBackgroundIndex(int index) {
    if (userModel == null) return;
    userModel!.backgroundIndex = index;
    userModelRepository.saveUser(userModel!);
    // saved IT and Get again
    getUser();
  }

  void setFealIconIndex(int index) {
    if (userModel == null) return;
    userModel!.fealIconIndex = index;
    userModelRepository.saveUser(userModel!);
    // saved IT and Get again
    getUser();
  }

  @override
  void onInit() async {
    getUser();
    getThemeData();
    // getBackgroundIndex();
    super.onInit();
  }

  void getThemeData() async {
    isDarkMode =
        await SettingRepository.getBool(AppConstant.isDarkModeKey) ?? false;
    print('isDarkMode : ${isDarkMode}');
  }

  void getUser() async {
    userModel = await userModelRepository.loadUser();
    print('userModel.userUtilModel : ${userModel!.userUtilModel}');

    update();
  }
}
