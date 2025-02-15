import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/respository/setting_repository.dart';

class BackgroundController extends GetxController {
  int backgroundIndex = 0;

  List<String> get iconImagePaths {
    switch (backgroundIndex) {
      case 0:
        return AppConstant.fillingIcons1;
      case 1:
        return AppConstant.fillingIcons2;
      default:
        return AppConstant.fillingIcons1;
    }
  }

  void getBackGroundIndex() async {
    backgroundIndex =
        await SettingRepository.getInt(AppConstant.backgroundIndexKey);

    update();
  }
}
