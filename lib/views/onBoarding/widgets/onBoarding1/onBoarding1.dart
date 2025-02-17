import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/enums/gender_type.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.8,
            fontWeight: FontWeight.bold,
            fontSize: RS.width18,
          ),
          TextSpan(
            text: '${AppString.appName.tr}${AppString.beforeStart.tr}',
            children: [
              TextSpan(
                text: AppString.plzSetting.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: RS.width16,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: RS.height20),
      ],
    );
  }
}
