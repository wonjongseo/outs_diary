import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/enums/icon_and_index.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';

class AppConstant {
  static const int diaryModelHiveId = 0;
  static const int healthModelHiveId = 1;
  static const int hospitalLogModelHiveId = 2;
  static const int stampModelHiveId = 3;
  static const int todoModelHiveId = 4;
  static const int catModelHiveId = 5;
  static const int nutritionModelHiveId = 6;
  static const int makerModelHiveId = 7;
  static const int handmadeModelHiveId = 8;
  static const int groceriesModelHiveId = 9;
  static const int expensiveModelHiveId = 10;
  static const int categoryModelHiveId = 11;

  static const String settingModelBox = 'settings';
  static const String diaryModelBox = 'diarys';
  static const String hospitalLogModelBox = 'hospitalLogs';
  static const String stampModelBox = 'stamps';
  static const String todoModelBox = 'todos';
  static const String nutritionModelModelBox = 'nutritions';
  static const String expensiveModelModelBox = 'expensives';
  static const String categoryModelModelBox = 'categories';
  static const String groceriesModelModelBox = 'groceries';
  static const String settingLanguageKey = 'settingLanguage';
  static const String lastPetIndexKey = 'lastPetIndex';
  static const String lastBottomTapIndexKey = 'lastBottomTapIndex';
  static const String hospitalNamesBox = 'hospitalNames';

  static const String countOfReiveRequestionKey = 'countOfReiveRequestion';
  static const String hasReviewedKey = 'hasReviewed';

  static const int countOfStampIcon = 18;

  static const String editCategorySign = "-@+편집+@-";

  static const int invalidNumber = -9192939;

  static List<String> fillingIcons = [
    AppImagePath.feal1,
    AppImagePath.feal2,
    AppImagePath.feal3,
    AppImagePath.feal4,
    AppImagePath.feal5,
  ];

  static List<IconAndIndex> faceIcons = [
    IconAndIndex.faceLaughBeam,
    IconAndIndex.faceMehBlank,
    IconAndIndex.faceFrown,
    IconAndIndex.faceSadTear,
    IconAndIndex.faceAngry,
  ];
  static List<IconAndIndex> weatherIcons = [
    IconAndIndex.sun,
    IconAndIndex.cloud,
    IconAndIndex.wind,
    IconAndIndex.umbrella,
    IconAndIndex.snowflake,
  ];

  static List<IconAndIndex> zeroToNineIcons = [
    IconAndIndex.zero,
    IconAndIndex.one,
    IconAndIndex.two,
    IconAndIndex.three,
    IconAndIndex.four,
    IconAndIndex.five,
    IconAndIndex.six,
    IconAndIndex.seven,
    IconAndIndex.eight,
    IconAndIndex.nine,
  ];

  // static List<IconData> fillingIcons = [
  //   FontAwesomeIcons.faceLaughBeam,
  //   FontAwesomeIcons.faceMehBlank,
  //   FontAwesomeIcons.faceFrown,
  //   FontAwesomeIcons.faceSadTear,
  //   FontAwesomeIcons.faceAngry,
  // ];

  // static List<IconData> weatherIcons = [
  //   FontAwesomeIcons.sun,
  //   FontAwesomeIcons.cloud,
  //   FontAwesomeIcons.wind,
  //   FontAwesomeIcons.umbrella,
  //   FontAwesomeIcons.snowflake,
  // ];

  // static List<IconData> dummyIcons = [
  //   FontAwesomeIcons.faceLaughBeam,
  //   FontAwesomeIcons.faceMehBlank,
  //   FontAwesomeIcons.faceFrown,
  //   FontAwesomeIcons.faceSadTear,
  //   FontAwesomeIcons.faceAngry,
  //   FontAwesomeIcons.faceLaughBeam,
  //   FontAwesomeIcons.faceMehBlank,
  //   FontAwesomeIcons.faceFrown,
  //   FontAwesomeIcons.faceSadTear,
  //   FontAwesomeIcons.faceAngry,
  // ];
}

class IconAndText {
  final String text;
  final int iconIndex;

  IconAndText({required this.text, required this.iconIndex});
}
