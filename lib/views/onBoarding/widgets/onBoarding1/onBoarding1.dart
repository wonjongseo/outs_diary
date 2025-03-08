import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

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
            fontSize: 18,
          ),
          TextSpan(
            text: isEn
                ? '${AppString.beforeStart.tr} ${AppString.appName.tr}\n'
                : '${AppString.appName.tr}${AppString.beforeStart.tr}',
            children: [
              TextSpan(
                text: AppString.plzSetting.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
