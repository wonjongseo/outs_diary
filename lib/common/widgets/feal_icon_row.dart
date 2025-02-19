import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_color.dart';

import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/datas/feal_icon_data.dart';
import 'package:ours_log/views/onBoarding/widgets/circle_done.dart';

class FealIconRow extends StatelessWidget {
  const FealIconRow({
    super.key,
    required this.isSelected,
    required this.fealIcon,
  });

  final bool isSelected;
  final FealIconData fealIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: RS.height15),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: RS.width15,
          vertical: RS.height15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleDone(isSelected: isSelected),
            SizedBox(width: RS.width15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fealIcon.title),
                SizedBox(height: RS.h10 / 2),
                Text(
                  fealIcon.description,
                  style: TextStyle(fontSize: RS.w10 * 1.2),
                ),
              ],
            ),
            SizedBox(width: RS.width20),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: List.generate(
                  fealIcon.iconPath.length,
                  (index2) => Positioned(
                    right: index2 == 0 ? null : index2 * RS.w10 * 2.7,
                    child: Container(
                      width: RS.w10 * 5,
                      height: RS.w10 * 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[400]!),
                        color: AppColors.white,
                      ),
                      child: Center(
                          child: Image.asset(
                        fealIcon.iconPath[index2],
                        width: isSelected ? RS.w10 * 6 : RS.w10 * 5,
                        height: isSelected ? RS.w10 * 6 : RS.w10 * 5,
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
