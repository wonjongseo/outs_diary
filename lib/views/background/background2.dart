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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            left: 80,
            right: -80,
            top: -100,
            child: Transform.scale(
              scale: .6,
              child: Image.asset(AppImagePath.background4,
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.modulate,
                  color: color),
            ),
          ),
          Positioned(
            left: -120,
            right: 120,
            top: 160,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Transform.scale(
                scale: .8,
                child: Image.asset(
                  AppImagePath.background3,
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.modulate,
                  color: color,
                ),
              ),
            ),
          ),
          Positioned(
            left: 120,
            right: -120,
            top: 400,
            child: Image.asset(
              AppImagePath.background5,
              fit: BoxFit.fill,
              colorBlendMode: BlendMode.modulate,
              color: color,
            ),
          ),
          widget,
        ],
      ),
    );
  }
}
