import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_color.dart';

class CustomToggleBtn extends StatelessWidget {
  const CustomToggleBtn({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.isChecked,
  });

  final Function(int) onTap;
  final List<bool> isSelected;
  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: onTap,
      borderRadius: BorderRadius.circular(20),
      isSelected: isSelected,
      children: [
        Text(
          'ON',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isChecked ? AppColors.primaryColor : null,
          ),
        ),
        Text(
          'OFF',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: !isChecked ? AppColors.primaryColor : null),
        )
      ],
    );
  }
}
