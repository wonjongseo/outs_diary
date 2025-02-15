import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';

import 'dart:math' as math;

class BackGround2 extends StatelessWidget {
  const BackGround2({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    Color color = Get.isDarkMode
        ? Colors.white.withOpacity(.2)
        : Colors.white.withOpacity(.5);

    List<String> backgrounds = [
      AppImagePath.background3,
      AppImagePath.background4,
      AppImagePath.background5,
    ];
    List<String> backgrounds2 = [
      AppImagePath.background22,
      AppImagePath.background22,
      AppImagePath.background21,
    ];

    List<double> lefts = [80, -120, 120];
    List<double> rights = [-80, 120, -120];
    List<double> tops = [-100, 160, 400];
    List<double> scales = [.6, .8, 1];
    // List<double> scales = [
    //   (math.Random().nextInt(10) + 1) / 10.0,
    //   (math.Random().nextInt(10) + 1) / 10.0,
    //   (math.Random().nextInt(10) + 1) / 10.0
    // ];

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          ...List.generate(
            backgrounds.length,
            (index) => Positioned(
              left: lefts[index],
              right: rights[index],
              top: tops[index],
              child: Transform.scale(
                scale: scales[index],
                child: Image.asset(backgrounds[index],
                    fit: BoxFit.fill,
                    colorBlendMode: BlendMode.modulate,
                    color: color),
              ),
            ),
          ),
          // Positioned(
          //   left: 80,
          //   right: -80,
          //   top: -100,
          //   child: Transform.scale(
          //     scale: .6,
          //     child: Image.asset(AppImagePath.background4,
          //         fit: BoxFit.fill,
          //         colorBlendMode: BlendMode.modulate,
          //         color: color),
          //   ),
          // ),
          // Positioned(
          //   left: -120,
          //   right: 120,
          //   top: 160,
          //   child: Transform(
          //     alignment: Alignment.center,
          //     transform: Matrix4.rotationY(math.pi),
          //     child: Transform.scale(
          //       scale: .8,
          //       child: Image.asset(
          //         AppImagePath.background3,
          //         fit: BoxFit.fill,
          //         colorBlendMode: BlendMode.modulate,
          //         color: color,
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: 120,
          //   right: -120,
          //   top: 400,
          //   child: Image.asset(
          //     AppImagePath.background5,
          //     fit: BoxFit.fill,
          //     colorBlendMode: BlendMode.modulate,
          //     color: color,
          //   ),
          // ),
          widget,
        ],
      ),
    );
  }
}
