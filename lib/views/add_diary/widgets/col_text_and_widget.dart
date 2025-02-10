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
        bottom: RS.height10,
      ),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.backgroundDark : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: RS.width10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label),
                if (labelWidget != null) labelWidget!
                // if (onTapIcon != null)
                //   GestureDetector(
                //     onTap: onTapIcon,
                //     child: const Icon(Icons.keyboard_arrow_down),
                //   )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: RS.height20,
              bottom: RS.height15,
              right: RS.width10,
              left: RS.width10,
            ),
            child: widget,
          ),
        ],
      ),
    );
  }
}
