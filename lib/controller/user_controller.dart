import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/datas/background_data.dart';
import 'package:ours_log/datas/feal_icon_data.dart';
import 'package:ours_log/respository/setting_repository.dart';

class UserController extends GetxController {
  bool? isDrinkingPill;
  int backgroundIndex = 0;
  int fealIconIndex = 0;

  TextEditingController teCrl = TextEditingController();

  void aa(int index) {
    bool isSelected = selectedMorningLunchEvening.contains(index);
    if (isSelected) {
      selectedMorningLunchEvening.remove(index);
    } else {
      selectedMorningLunchEvening.add(index);
    }
    update();
  }

  void bb(int index) {
    bool isSelected = selectedDays.contains(index);
    if (isSelected) {
      selectedDays.remove(index);
    } else {
      selectedDays.add(index);
    }
    update();
  }

  List<int> selectedMorningLunchEvening = [];
  List<int> selectedDays = [];

  void onTapIsDrinkPill(bool value) {
    isDrinkingPill = value;
    update();
  }

  List<String> get feals {
    return fealIconLists[fealIconIndex].iconPath;
  }

  BackgroundData get backgroundData {
    return backgroundLists[backgroundIndex];
  }

  @override
  void onInit() {
    getBackgroundIndex();
    super.onInit();
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

  List<FealIconData> fealIconLists = [
    FealIconData(
        iconPath: AppConstant.fillingIcons1,
        title: AppString.fealIcon1Name.tr,
        description: AppString.fealIcon1Des.tr),
    FealIconData(
        iconPath: AppConstant.fillingIcons2,
        title: AppString.fealIcon2Name.tr,
        description: AppString.fealIcon2Des.tr),
    FealIconData(
        iconPath: AppConstant.fillingIcons3,
        title: AppString.fealIcon3Name.tr,
        description: AppString.fealIcon3Des.tr),
    FealIconData(
        iconPath: AppConstant.fillingIcons4,
        title: AppString.fealIcon4Name.tr,
        description: AppString.fealIcon4Des.tr),
    FealIconData(
        iconPath: AppConstant.fillingIcons5,
        title: AppString.fealIcon5Name.tr,
        description: AppString.fealIcon5Des.tr),
  ];

  List<BackgroundData> backgroundLists = [
    BackgroundData(
      images: [],
      description: '배경 없음',
      lefts: [],
      rights: [],
      tops: [],
      scales: [],
      opacity: [1, 1], // dont' remove this
    ),
    BackgroundData(
      images: [
        AppImagePath.background11,
        AppImagePath.background12,
        AppImagePath.background13,
      ],
      description: AppString.background1Desc.tr,
      lefts: [80, -120, 120],
      rights: [-80, 120, -120],
      tops: [-100, 160, 400],
      scales: [.6, .8, 1],
      opacity: [.2, .5],
    ),
    BackgroundData(
      // 다람쥐
      images: [
        AppImagePath.background22,
        // AppImagePath.background23,
        AppImagePath.background22,
        AppImagePath.background21,
      ],
      description: AppString.background2Desc.tr,
      lefts: [85, -120, 120],
      rights: [-85, 120, -120],
      tops: [-100, 140, 350],
      scales: [.5, .5, 1],
      opacity: [.2, .3],
    ),
    BackgroundData(
      images: [
        AppImagePath.background33,
        AppImagePath.background32,
        AppImagePath.background31,
      ],
      description: AppString.background3Desc.tr,
      lefts: [85, -120, 120],
      rights: [-85, 120, -120],
      tops: [-100, 160, 350],
      scales: [1, .6, .8],
      opacity: [.5, .3],
    ),
    BackgroundData(
      images: [
        AppImagePath.background41,
        AppImagePath.background43,
        AppImagePath.background42,
      ],
      description: AppString.background4Desc.tr,
      lefts: [80, -120, 120],
      rights: [-80, 120, -120],
      tops: [-100, 160, 400],
      scales: [.6, .8, 1],
      opacity: [.2, .5],
    ),
  ];
}
