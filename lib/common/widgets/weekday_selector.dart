import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_color.dart';

class WeekdaySelector extends StatelessWidget {
  const WeekdaySelector({
    super.key,
    this.width,
    this.height,
    this.fontSize,
    required this.onTap,
    required this.isSelected,
    required this.weekDay,
  });

  final double? width;
  final double? height;
  final double? fontSize;
  final String weekDay;
  final Function() onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 10 * 8,
        height: height ?? 10 * 10,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(color: AppColors.primaryColor, width: 2)
              : Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            weekDay,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
