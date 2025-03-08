import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class BackGround1Sample extends StatelessWidget {
  const BackGround1Sample(
      {super.key, required this.backgrounds, required this.isSelected});

  final List<String> backgrounds;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    Color color = Get.isDarkMode
        ? Colors.white.withOpacity(.2)
        : Colors.white.withOpacity(.5);

    List<double> lefts = [80, -80, 40];
    List<double> rights = [-80, 80, -40];
    List<double> tops = [-60, 80, 250];
    List<double> scales = [.5, .7, .9];
    return Container(
        width: 300,
        height: 500,
        decoration: BoxDecoration(
          color: boxBlackOrWhite,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey,
            width: isSelected ? 3 : 2,
          ),
        ),
        child: Stack(
            // alignment: AlignmentDirectional.center,
            children: [
              ...List.generate(
                backgrounds.length,
                (index) => Positioned(
                  left: lefts[index],
                  right: rights[index],
                  top: tops[index],
                  child: Transform.scale(
                    scale: scales[index],
                    child: Image.asset(
                      backgrounds[index],
                      fit: BoxFit.fill,
                      colorBlendMode: BlendMode.modulate,
                      color: color,
                    ),
                  ),
                ),
              ),
            ]));
  }
}
