import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';

class BackGround1 extends StatelessWidget {
  const BackGround1({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 80,
          right: -80,
          top: -200,
          child: Transform.scale(
            scale: .6,
            child: Image.asset(
              AppImagePath.background12,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: -120,
          right: 120,
          top: 70,
          child: Transform.scale(
            scale: .8,
            child: Image.asset(
              AppImagePath.background12,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: 120,
          right: -120,
          bottom: -120,
          child: Container(
            child: Image.asset(
              AppImagePath.background12,
              fit: BoxFit.fill,
            ),
          ),
        ),
        widget,
      ],
    );
  }
}
