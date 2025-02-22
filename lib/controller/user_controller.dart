import 'package:get/get.dart';
import 'package:ours_log/models/is_expandtion_type.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:collection/collection.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/user_model.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/respository/user_respository.dart';
import 'package:ours_log/services/notification_service.dart';

class UserController extends GetxController {
  UserModel? userModel;

  void saveUser(UserModel userModel) {
    userModelRepository.saveUser(userModel);
    getUser();
  }

  bool isDarkMode = false;

  UserModelRepository userModelRepository = UserModelRepository();

  void toggleExpanded(IsExpandtionType field) {
    if (!userModel!.userUtilModel.expandedFields.containsKey(field)) return;

    userModel!.userUtilModel.expandedFields[field] =
        !userModel!.userUtilModel.expandedFields[field]!;

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

  NotificationService notificationService = NotificationService();

  Future<void> deleteTaskFromNotificationList(
    List<NotificationModel>? notifications,
  ) async {
    if (notifications == null) return;
    if (userModel == null) return;
    if (userModel!.tasks == null) return;

    final listEquals = const ListEquality().equals;
    int deleteTaskIndex = 0;
    for (; deleteTaskIndex < userModel!.tasks!.length; deleteTaskIndex++) {
      TaskModel task = userModel!.tasks![deleteTaskIndex];
      if (listEquals(task.notifications, notifications)) {
        for (NotificationModel notification in notifications) {
          await notificationService.cancellNotifications(notification.alermId);
        }
        break;
      }
    }

    deleteTask(userModel!.tasks![deleteTaskIndex]);
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
  }

  Future<void> getUser() async {
    userModel = await userModelRepository.loadUser();
    print('userModel?.tasks?.length : ${userModel?.tasks?.length}');

    // for (var task in userModel!.tasks ?? []) {
    //   print('task : ${task}');
    // }
    update();
  }
}
