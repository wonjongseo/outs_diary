import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';

enum IconAndIndex {
  faceLaughBeam(0, FontAwesomeIcons.faceLaughBeam),
  faceMehBlank(1, FontAwesomeIcons.faceMehBlank),
  faceFrown(2, FontAwesomeIcons.faceFrown),
  faceSadTear(3, FontAwesomeIcons.faceSadTear),
  faceAngry(4, FontAwesomeIcons.faceAngry),
  sun(5, FontAwesomeIcons.sun),
  cloud(6, FontAwesomeIcons.cloud),
  wind(7, FontAwesomeIcons.wind),
  umbrella(8, FontAwesomeIcons.umbrella),
  snowflake(9, FontAwesomeIcons.snowflake);

  final int iconIndex;
  final IconData iconData;

  const IconAndIndex(this.iconIndex, this.iconData);
}

extension IconAndIndexExtension on IconAndIndex {
  String get title {
    switch (iconIndex) {
      case 0:
        return AppString.addCategoryText.tr;
      case 1:
        return AppString.addPhoto.tr;
      case 2:
        return AppString.calculateKcalText.tr;
      case 3:
        return AppString.yesTextTr.tr;
      case 5:
        return AppString.sunny.tr;
      case 6:
        return AppString.cloud.tr;
      case 7:
        return AppString.wind.tr;
      case 8:
        return AppString.rain.tr;
      case 9:
        return AppString.snow.tr;

      default:
        return AppString.addPhoto.tr;
    }
  }
}
