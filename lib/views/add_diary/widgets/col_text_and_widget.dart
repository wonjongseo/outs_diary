import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class ColTextAndWidget extends StatelessWidget {
  const ColTextAndWidget({
    Key? key,
    required this.label,
    // this.onTapIcon,
    this.labelWidget,
    required this.widget,
  }) : super(key: key);

  final String label;
  // final Function()? onTapIcon;
  final Widget? labelWidget;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: RS.width8,
      ).copyWith(
        top: RS.height14,
        bottom: RS.h10,
      ),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.black : AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: RS.w10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(label), if (labelWidget != null) labelWidget!],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: RS.height20,
              bottom: RS.height15,
              right: RS.w10,
              left: RS.w10,
            ),
            child: widget,
          ),
        ],
      ),
    );
  }
}
