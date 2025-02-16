import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';

import 'dart:math' as math;

import 'package:ours_log/controller/background_controller.dart';

class BackGround2 extends StatelessWidget {
  const BackGround2({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    Color color = Get.isDarkMode
        ? Colors.white.withOpacity(.2)
        : Colors.white.withOpacity(.5);

    List<double> lefts = [80, -120, 120];
    List<double> rights = [-80, 120, -120];
    List<double> tops = [-100, 160, 400];
    List<double> scales = [.6, .8, 1];

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GetBuilder<BackgroundController>(builder: (backgroundController) {
        return Stack(
          children: [
            ...List.generate(
              backgroundController.backgrounds.length,
              (index) => Positioned(
                left: lefts[index],
                right: rights[index],
                top: tops[index],
                child: Transform.scale(
                  scale: scales[index],
                  child: Image.asset(backgroundController.backgrounds[index],
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
