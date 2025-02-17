import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

import 'package:ours_log/controller/user_controller.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GetBuilder<UserController>(builder: (backgroundController) {
        Color color = Get.isDarkMode
            ? Colors.white
                .withOpacity(backgroundController.backgroundData.opacity[0])
            : Colors.white
                .withOpacity(backgroundController.backgroundData.opacity[1]);
        return Stack(
          children: [
            ...List.generate(
              backgroundController.backgroundData.images.length,
              (index) => Positioned(
                left: backgroundController.backgroundData.lefts[index],
                right: backgroundController.backgroundData.rights[index],
                top: backgroundController.backgroundData.tops[index],
                child: Transform.scale(
                  scale: backgroundController.backgroundData.scales[index],
                  child: Image.asset(
                      backgroundController.backgroundData.images[index],
                      fit: BoxFit.fill,
                      colorBlendMode: BlendMode.modulate,
                      color: color),
                ),
              ),
            ),
            widget,
          ],
        );
      }),
    );
  }
}
