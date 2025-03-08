import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:ours_log/common/utilities/app_color.dart';

class ColTextAndWidget extends StatelessWidget {
  const ColTextAndWidget({
    Key? key,
    required this.label,
    // this.onTapIcon,
    this.labelWidget,
    required this.widget,
    this.vertical,
  }) : super(key: key);

  final String label;
  // final Function()? onTapIcon;
  final Widget? labelWidget;
  final Widget widget;
  final double? vertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: vertical ?? 10,
      ),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.black : AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(label), if (labelWidget != null) labelWidget!],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 15,
              right: 10,
              left: 10,
            ),
            child: widget,
          ),
        ],
      ),
    );
  }
}
