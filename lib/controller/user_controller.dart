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

  void toggleExpanded(bool v, int index) {
    switch (index) {
      case 0:
        userModel!.userUtilModel.expandedTemperature = v;
        break;
      case 1:
        userModel!.userUtilModel.expandedPulse = v;
        break;
      case 2:
        userModel!.userUtilModel.expandedBloodPressure = v;
        break;
      case 3:
        userModel!.userUtilModel.expandedPainLevel = v;
        break;
      case 4:
        userModel!.userUtilModel.expandedFealGraph = v;
        break;
      case 5:
        userModel!.userUtilModel.expandedWeightGraph = v;
        break;
      case 6:
        userModel!.userUtilModel.expandedTemperatureGraph = v;
        break;
      case 7:
        userModel!.userUtilModel.expandedPulseGraph = v;
        break;
      case 8:
        userModel!.userUtilModel.expandedBloodPressureGraph = v;
        break;
      case 9:
        userModel!.userUtilModel.expandedPainLevelGraph = v;
        break;
    }

    userModelRepository.saveUser(userModel!);

    update();
  }

  void toggleExpandedPainLevel(bool v) {
    userModel!.userUtilModel!.expandedPainLevel =
        !userModel!.userUtilModel!.expandedPainLevel;

    userModelRepository.saveUser(userModel!);

    update();
  }

  void toggleExpandedTemperature(bool v) {
    userModel!.userUtilModel!.expandedTemperature =
        !userModel!.userUtilModel!.expandedTemperature;

    userModelRepository.saveUser(userModel!);

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

    update();
  }
}

// class UserUtilController extends GetxController {
//   bool expandedTemperature = true;
//   bool expandedPulse = true;
//   bool expandedBloodPressure = true;
//   bool expandedPainLevel = true;
//   bool expandedFealGraph = true;
//   bool expandedTemperatureGraph = true;
//   bool expandedPulseGraph = true;
//   bool expandedBloodPressureGraph = true;
//   bool expandedPainLevelGraph = true;

//   UserController userController = Get.find<UserController>();

//   @override
//   void onInit() {
//     expandedTemperature =
//         userController.userModel!.userUtilModel.expandedTemperature;
//     expandedPulse = userController.userModel!.userUtilModel.expandedPulse;
//     expandedBloodPressure =
//         userController.userModel!.userUtilModel.expandedBloodPressure;
//     expandedPainLevel =
//         userController.userModel!.userUtilModel.expandedPainLevel;
//     expandedFealGraph =
//         userController.userModel!.userUtilModel.expandedFealGraph;
//     expandedTemperatureGraph =
//         userController.userModel!.userUtilModel.expandedTemperatureGraph;
//     expandedPulseGraph =
//         userController.userModel!.userUtilModel.expandedPulseGraph;
//     expandedBloodPressureGraph =
//         userController.userModel!.userUtilModel.expandedBloodPressureGraph;
//     expandedPainLevelGraph =
//         userController.userModel!.userUtilModel.expandedPainLevelGraph;
//     super.onInit();
//   }

//   void toggleExpandedPainLevel(bool v) {
//     userController.userModel!.userUtilModel!.expandedPainLevel =
//         !userController.userModel!.userUtilModel!.expandedPainLevel;

//     userController.userModelRepository.saveUser(userController.userModel!);

//     update();
//   }
// }
