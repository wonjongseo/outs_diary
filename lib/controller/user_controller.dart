import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/datas/background_data.dart';
import 'package:ours_log/models/user_model.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/respository/user_respository.dart';

class UserController extends GetxController {
  int backgroundIndex = 0;
  int fealIconIndex = 0;

  late UserModel? userModel;

  UserModelRepository userModelRepository = UserModelRepository();

  List<String> get feals {
    return AppConstant.fealIconLists[fealIconIndex].iconPath;
  }

  BackgroundData get backgroundData {
    return AppConstant.backgroundLists[backgroundIndex];
  }

  @override
  void onInit() async {
    getUser();
    getBackgroundIndex();
    super.onInit();
  }

  void getUser() async {
    userModel = await userModelRepository.loadUser();
    print('userModel : ${userModel}');

    update();
  }

  void getFealIconIndex() async {
    fealIconIndex = await SettingRepository.getInt(
      AppConstant.fealIndexKey,
    );
    update();
  }

  void setFealIconIndex(int index) {
    fealIconIndex = index;
    update();

    SettingRepository.setInt(
      AppConstant.fealIndexKey,
      fealIconIndex,
    );
  }

  void getBackgroundIndex() async {
    backgroundIndex = await SettingRepository.getInt(
      AppConstant.backgroundIndexKey,
    );
    update();
  }

  void setBackgroundIndex(int index) {
    backgroundIndex = index;
    update();

    SettingRepository.setInt(
      AppConstant.backgroundIndexKey,
      backgroundIndex,
    );
  }

  void getBackGroundIndex() async {
    backgroundIndex =
        await SettingRepository.getInt(AppConstant.backgroundIndexKey);

    update();
  }
}
