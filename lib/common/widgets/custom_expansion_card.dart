import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class CustomExpansionCard extends StatelessWidget {
  const CustomExpansionCard(
      {super.key,
      required this.title,
      this.children,
      required this.child,
      this.subTitle,
      this.titleWidget,
      this.subTitleWidget});

  final String title;
  final Widget? titleWidget;
  final String? subTitle;
  final Widget? subTitleWidget;
  final List<Widget>? children;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      initiallyExpanded: true,
      elevation: 0,
      title: titleWidget == null ? Text(title) : titleWidget!,
      subtitle: subTitleWidget == null && subTitle == null
          ? null
          : subTitleWidget == null
              ? Text(subTitle!)
              : subTitleWidget!,
      expandedColor: Get.isDarkMode ? AppColors.black : Colors.white,
      shadowColor: Colors.transparent,
      children: children == null
          ? [
              Padding(
                padding: EdgeInsets.symmetric(vertical: RS.h10),
                child: child,
              )
            ]
          : children!,
    );
  }
}
