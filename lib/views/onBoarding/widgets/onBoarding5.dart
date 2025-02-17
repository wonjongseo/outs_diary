import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/user_controller.dart';

class Onboarding5 extends StatelessWidget {
  const Onboarding5({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<UserController>(builder: (userController) {
      return Column(
        children: [
          Text(
            '약을 복용중이신가요 ?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: RS.w10 * 1.8,
            ),
          ),
          SizedBox(height: RS.h10 * 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  userController.onTapIsDrinkPill(true);
                },
                child: Container(
                  width: size.width / 3 - 30,
                  height: size.width / 3 - 30,
                  decoration: BoxDecoration(
                    color: userController.isDrinkingPill != null &&
                            userController.isDrinkingPill == true
                        ? Colors.pinkAccent
                        : null,
                    borderRadius: BorderRadius.circular(RS.w10 * 1.5),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('네'),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  userController.onTapIsDrinkPill(false);
                },
                child: Container(
                  width: size.width / 3 - 30,
                  height: size.width / 3 - 30,
                  decoration: BoxDecoration(
                    color: userController.isDrinkingPill != null &&
                            userController.isDrinkingPill == false
                        ? Colors.pinkAccent
                        : null,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('아니요'),
                        // FaIcon(FontAwesomeIcons.venus),
                        // SizedBox(height: RS.h10),
                        // Text(AppString.female.tr),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
