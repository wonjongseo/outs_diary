import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/respository/setting_repository.dart';

class BackgroundController extends GetxController {
  int backgroundIndex = 0;
  int fealIconIndex = 0;

  List<String> get feals {
    return fealss[fealIconIndex];
  }

  List<String> get backgrounds {
    return backgroundss[backgroundIndex];
  }

  @override
  void onInit() {
    getBackgroundIndex();
    super.onInit();
  }

  void getFealIconIndex() async {
    fealIconIndex = await SettingRepository.getInt(
      AppConstant.fealIndexBox,
    );
    update();
  }

  void setFealIconIndex(int index) {
    fealIconIndex = index;
    update();

    SettingRepository.setInt(
      AppConstant.fealIndexBox,
      fealIconIndex,
    );
  }

  void getBackgroundIndex() async {
    backgroundIndex = await SettingRepository.getInt(
      AppConstant.backgroundIndexBox,
    );
    update();
  }

  void setBackgroundIndex(int index) {
    backgroundIndex = index;
    update();

    SettingRepository.setInt(
      AppConstant.backgroundIndexBox,
      backgroundIndex,
    );
  }

  void getBackGroundIndex() async {
    backgroundIndex =
        await SettingRepository.getInt(AppConstant.backgroundIndexKey);

    update();
  }

  List<List<String>> fealss = [
    AppConstant.fillingIcons1,
    AppConstant.fillingIcons2,
    AppConstant.fillingIcons1
  ];

  List<List<String>> backgroundss = [
    [
      AppImagePath.background11,
      AppImagePath.background12,
      AppImagePath.background13,
    ],
    [
      AppImagePath.background22,
      AppImagePath.background23,
      AppImagePath.background21,
    ],
    [
      AppImagePath.background31,
      AppImagePath.background32,
      AppImagePath.background33,
    ],
  ];
}
