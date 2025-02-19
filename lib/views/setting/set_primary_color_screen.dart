import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/onboarding_controller.dart';
import 'package:ours_log/controller/user_controller.dart';

class SetPrimaryColorScreen extends StatelessWidget {
  const SetPrimaryColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<UserController>(builder: (controller) {
          return Column(children: [
            Text('앱의 메인 색상을 선택해주세요!'),
            SizedBox(height: RS.h10 * 3),
            // Text('앱의 메인 색상을 선택해주세요!'),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.userModel!.colorIndex = 0;
                      controller.update();
                    },
                    child: CircleAvatar(
                      radius: RS.w10 * 3,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.priPinkClr,
                      child: controller.userModel!.colorIndex == 0
                          ? Icon(Icons.done)
                          : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.userModel!.colorIndex = 1;
                      controller.update();
                    },
                    child: CircleAvatar(
                      child: controller.userModel!.colorIndex == 1
                          ? Icon(Icons.done)
                          : null,
                      radius: RS.w10 * 3,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.priYellowClr,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.userModel!.colorIndex = 2;
                      controller.update();
                    },
                    child: CircleAvatar(
                      radius: RS.w10 * 3,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.priGreenClr,
                      child: controller.userModel!.colorIndex == 2
                          ? Icon(Icons.done)
                          : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.userModel!.colorIndex = 3;
                      controller.update();
                    },
                    child: CircleAvatar(
                      radius: RS.w10 * 3,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.priBluishClr,
                      child: controller.userModel!.colorIndex == 3
                          ? Icon(Icons.done)
                          : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.userModel!.colorIndex = 4;
                      controller.update();
                    },
                    child: CircleAvatar(
                      radius: RS.w10 * 3,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.priPubbleClr,
                      child: controller.userModel!.colorIndex == 4
                          ? Icon(Icons.done)
                          : null,
                    ),
                  ),
                ],
              ),
            )
          ]);
        }));
  }
}
