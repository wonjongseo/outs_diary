import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';

import 'dart:math' as math;

class BackGround2 extends StatelessWidget {
  const BackGround2({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned(
        //   left: 80,
        //   right: -80,
        //   top: -100,
        //   child: Transform.scale(
        //     scale: .6,
        //     child: Image.asset(
        //       AppImagePath.background4,
        //       fit: BoxFit.fill,
        //     ),
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
        //       ),
        //     ),
        //   ),
        // ),
        // Positioned(
        //   left: 120,
        //   right: -120,
        //   bottom: -120,
        //   child: Container(
        //     child: Image.asset(
        //       AppImagePath.background5,
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
        widget,
      ],
    );
  }
}
