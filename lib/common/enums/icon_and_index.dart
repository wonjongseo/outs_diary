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
  snowflake(9, FontAwesomeIcons.snowflake),
  //
  one(10, FontAwesomeIcons.one),
  two(11, FontAwesomeIcons.two),
  three(12, FontAwesomeIcons.three),
  four(13, FontAwesomeIcons.four),
  five(14, FontAwesomeIcons.five),
  six(15, FontAwesomeIcons.six),
  seven(16, FontAwesomeIcons.seven),
  eight(17, FontAwesomeIcons.eight),
  nine(18, FontAwesomeIcons.nine),
  zero(19, FontAwesomeIcons.zero),

  //

  tired(19, FontAwesomeIcons.faceTired),
  dizzy(19, FontAwesomeIcons.faceDizzy),
  flushed(19, FontAwesomeIcons.faceFlushed),
  ;

  final int iconIndex;
  final IconData iconData;

  const IconAndIndex(this.iconIndex, this.iconData);
}

extension IconAndIndexExtension on IconAndIndex {
  String get title {
    switch (iconIndex) {
      case 0:
        return AppString.veryGood.tr;
      case 1:
        return AppString.good.tr;
      case 2:
        return AppString.soso.tr;
      case 3:
        return AppString.bad.tr;
      case 4:
        return AppString.veryBad.tr;
      case 5:
        return '아주 나쁨';
      case 6:
        return AppString.cloud.tr;
      case 7:
        return AppString.wind.tr;
      case 8:
        return AppString.rain.tr;
      case 9:
        return AppString.snow.tr;

      default:
        return '';
    }
  }
}
