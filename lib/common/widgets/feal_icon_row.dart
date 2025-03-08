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
      padding: EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
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
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fealIcon.title),
                SizedBox(height: 5),
                Text(
                  fealIcon.description,
                  style: TextStyle(fontSize: 10 * 1.2),
                ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: List.generate(
                  fealIcon.iconPath.length,
                  (index2) => Positioned(
                    right: index2 == 0 ? null : index2 * 10 * 2.7,
                    child: Container(
                      width: 10 * 5,
                      height: 10 * 5,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor,
                            offset: const Offset(1, 1),
                          )
                        ],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[400]!),
                        color: AppColors.white,
                      ),
                      child: Image.asset(
                        fealIcon.iconPath[index2],
                        width: isSelected ? 10 * 6 : 10 * 5,
                        height: isSelected ? 10 * 6 : 10 * 5,
                      ),
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
