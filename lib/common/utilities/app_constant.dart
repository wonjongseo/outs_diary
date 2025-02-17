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

  static const String expensiveModelModelBox = 'expensives';
  static const String categoryModelModelBox = 'categories';
  static const String groceriesModelModelBox = 'groceries';
  static const String settingLanguageKey = 'settingLanguage';
  static const String lastPetIndexKey = 'lastPetIndex';
  static const String lastBottomTapIndexKey = 'lastBottomTapIndex';
  static const String hospitalNamesBox = 'hospitalNames';

  static const String countOfReiveRequestionKey = 'countOfReiveRequestion';
  static const String hasReviewedKey = 'hasReviewed';
  static const String backgroundIndexKey = 'backgroundIndex';
  static const String fealIndexKey = 'fealIndex';
  static const String isDarkModeKey = 'isDarkMode';

  static const int countOfStampIcon = 18;

  static const String editCategorySign = "-@+편집+@-";

  static const int invalidNumber = -9192939;

  static List<String> fillingIcons1 = [
    AppImagePath.very_good1,
    AppImagePath.good1,
    AppImagePath.soso1,
    AppImagePath.bad1,
    AppImagePath.very_bad1,
  ];

  static List<String> fillingIcons2 = [
    AppImagePath.very_good2,
    AppImagePath.good2,
    AppImagePath.soso2,
    AppImagePath.bad2,
    AppImagePath.very_bad2,
  ];

  static List<String> fillingIcons3 = [
    AppImagePath.very_good3,
    AppImagePath.good3,
    AppImagePath.soso3,
    AppImagePath.bad3,
    AppImagePath.very_bad3,
  ];

  static List<String> fillingIcons4 = [
    AppImagePath.very_good4,
    AppImagePath.good4,
    AppImagePath.soso4,
    AppImagePath.bad4,
    AppImagePath.very_bad4,
  ];
  static List<String> fillingIcons5 = [
    AppImagePath.very_good5,
    AppImagePath.good5,
    AppImagePath.soso5,
    AppImagePath.bad5,
    AppImagePath.very_bad5,
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
}

class IconAndText {
  final String text;
  final int iconIndex;

  IconAndText({required this.text, required this.iconIndex});
}
