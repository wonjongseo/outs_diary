import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';

import 'dart:math' as math;

import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/datas/background_data.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GetBuilder<UserController>(builder: (backgroundController) {
        BackgroundData backgroundData = AppConstant.backgroundLists[
            backgroundController.userModel?.backgroundIndex ?? 0];

        Color color = Get.isDarkMode
            ? Colors.white.withOpacity(backgroundData.opacity[0])
            : Colors.white.withOpacity(backgroundData.opacity[1]);

        return Stack(
          children: [
            ...List.generate(
              backgroundData.images.length,
              (index) => Positioned(
                left: backgroundData.lefts[index],
                right: backgroundData.rights[index],
                top: backgroundData.tops[index],
                child: Transform.scale(
                  scale: backgroundData.scales[index],
                  child: Image.asset(backgroundData.images[index],
                      fit: BoxFit.fill,
                      colorBlendMode: BlendMode.modulate,
                      color: color),
                ),
              ),
            ),
            child,
          ],
        );
      }),
    );
  }
}
