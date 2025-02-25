import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

enum ImageAndIndex {
  veryGood(0, 'faceLaughBeam'),
  good(1, 'faceMehBlank'),
  soso(2, 'faceFrown'),
  bad(3, 'faceSadTear'),
  veryBood(4, 'faceAngry'),
  sun(5, 'sun'),
  cloud(6, 'cloud'),
  wind(7, 'wind'),
  umbrella(8, 'umbrella'),
  snowflake(9, 'snowflake'),
  //
  one(10, 'one'),
  two(11, 'two'),
  three(12, 'three'),
  four(13, 'four'),
  five(14, 'five'),
  six(15, 'six'),
  seven(16, 'seven'),
  eight(17, 'eight'),
  nine(18, 'nine'),
  zero(19, 'zero'),

  tired(19, 'faceTired'),
  dizzy(19, 'faceDizzy'),
  flushed(19, 'faceFlushed'),
  ;

  final int imageIndex;
  final String imagePath;

  const ImageAndIndex(this.imageIndex, this.imagePath);
}

extension IconAndIndexExtension on ImageAndIndex {
  String get title {
    switch (imageIndex) {
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
        return AppString.veryBad.tr;

      default:
        return '';
    }
  }
}
