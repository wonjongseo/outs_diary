import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/feal_icon_row.dart';
import 'package:ours_log/controller/user_controller.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({Key? key}) : super(key: key);

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
            text: isKo ? '아이콘을 선택해주세요!' : 'どんな記録を入れますか？',
          ),
        ),
        SizedBox(height: RS.h10),
        GetBuilder<UserController>(builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: RS.w10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                controller.fealIconLists.length,
                (index) {
                  bool isSelected = controller.fealIconIndex == index;
                  return GestureDetector(
                    onTap: () => controller.setFealIconIndex(index),
                    child: FealIconRow(
                      isSelected: isSelected,
                      fealIcon: controller.fealIconLists[index],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
